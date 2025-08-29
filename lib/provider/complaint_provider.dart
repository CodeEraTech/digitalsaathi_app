import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/data/app_excaptions.dart';
import 'package:digitalsaathi/data/model/category_and_mla_response.dart';
import 'package:digitalsaathi/data/model/complaint_list_response.dart';
import 'package:digitalsaathi/data/model/meeting_detail_response.dart';
import 'package:digitalsaathi/data/model/meeting_list_response.dart';
import 'package:digitalsaathi/data/model/meeting_report_response.dart';
import 'package:digitalsaathi/model/feedmodel.dart';
import 'package:digitalsaathi/ui/botttom_bar/bottom_nav_bar.dart';
import 'package:digitalsaathi/ui/home/widgets/ReelModel.dart';
import 'package:digitalsaathi/utils/connection_util.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class ComplaintProvider with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  onInitValue(){
    _getMLAList = [];
    _getCategoryList = [];
    documentFiles = [];
     selectedRbValue = "Self";
     showOtherDesign = false;
     isChecked = false;
     subjectCtr.text = "";
     addressCtr.text = "";
     descriptionCtr.text = "";
     nameCtr.text = "";
     epicCtr.text = "";
     mobileCtr.text = "";
    categorySelectedValue = null;
    tagInviteSelectedValue = null;
  }



  List<Mla> _getMLAList = [];
  List<Category> _getCategoryList = [];

  List<Mla> get getMLAList => _getMLAList;
  List<Category> get getCategoryList => _getCategoryList;

  List<File> documentFiles = [];

  TextEditingController subjectCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();
  TextEditingController descriptionCtr = TextEditingController();
  TextEditingController nameCtr = TextEditingController();
  TextEditingController epicCtr = TextEditingController();
  TextEditingController mobileCtr = TextEditingController();

  String? selectedRbValue = "Self";
  bool showOtherDesign = false;
  bool isChecked = false;


  void radioGroupChange(String value,bool status){
      selectedRbValue = value;
      showOtherDesign = status;
      notifyListeners();
  }
  void onCheckboxChanged(bool? value) {

      isChecked = value!;
      notifyListeners();
  }

  Category? categorySelectedValue;
  Mla? tagInviteSelectedValue;

  onMLATagSelected(Mla m){
    tagInviteSelectedValue = m;
    notifyListeners();
  }

  onCategorySelected(Category m){
    categorySelectedValue = m;
    notifyListeners();
  }

  Future getMlaAndCategory() async{
    _isLoading = true;
    try {
      var data = {
        "api_token": AppUrl.apiToken,
        "user_id":"0"
      };

      http.Response response = await http.post(
          Uri.parse(AppUrl.getMlaAndCategoryList), body: data);

      Utils.printConsoleData(response.body);
      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['status_code'] == 200) {
          CategoryAndMLAResponse categoryAndMLAResponse = CategoryAndMLAResponse.fromJson(jsonDecode(response.body));
          _getMLAList = categoryAndMLAResponse.mla;
          _getCategoryList = categoryAndMLAResponse.category;
          _isLoading = false;
          notifyListeners();
        }else{
          EasyLoading.showError("${jsonDecode(response.body)['status_code']} - ${jsonDecode(response.body)['status_text']}");
          _isLoading = false;
          notifyListeners();
        }
      }else{
        EasyLoading.showError("${response.statusCode}");
        _isLoading = false;
        notifyListeners();
      }

      log(response.body);
    }on SocketException {
      _isLoading = false;
      notifyListeners();
      throw FetchDataException('No Internet Connection');
    }
    catch(e){
      EasyLoading.showError("Something went wrong. Please try again!!!");
      _isLoading = false;
      notifyListeners();
    }
  }

  Future raiseComplaint(BuildContext context,String createType) async {
    _isLoading = true;
    notifyListeners();

    Map<String, String> data = {
      "api_token": AppUrl.apiToken,
      "subject": subjectCtr.text.toString(),
      "category_id":categorySelectedValue!.id.toString(),
      "description":descriptionCtr.text.toString(),
      "status_id":"1",
      "mla_id":tagInviteSelectedValue!.id.toString(),
      "lat":"${currentPosittion!.latitude}",
      "lng":"${currentPosittion!.longitude}",
      "high_severity":isChecked?"Yes":"No",
      "relation_type":showOtherDesign?"Other":"Self",
      "relation_name":showOtherDesign?nameCtr.text.toString():"",
      "relation_epic":showOtherDesign?epicCtr.text.toString():"",
      "relation_mobile":showOtherDesign?mobileCtr.text.toString():"",
      "address":addressCtr.text.toString(),
      "createType":createType,
    };
    var request =  http.MultipartRequest(
        'POST', Uri.parse(AppUrl.createComplaint));
    request.fields.addAll(data);
    if(documentFiles.isNotEmpty){
      for(var file in documentFiles){
        var multipartFile = await http.MultipartFile.fromPath(
            'documents[]', file.path); //returns a Future<MultipartFile>
        request.files.add(multipartFile);
      }

    }
    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    var result = jsonDecode(respStr);

    if (response.statusCode == 200) {
      if(result["status_code"] == 200){
        _isLoading = false;
        Utils.toastMessage(result["status_text"].toString());
        Navigator.pop(context,true);
        notifyListeners();
      }else{
        _isLoading = false;
        Utils.toastMessage(result["status_text"].toString());
        notifyListeners();
      }

    } else {
      _isLoading = false;
      Utils.toastMessage(result["status_text"].toString());
      notifyListeners();
    }
  }
List<ComplaintData> _complainData = [];

  List<ComplaintData> get complainData => _complainData;

  Future getAllComplaints(String createType) async{
    _isLoading = true;
   // try {
      var data = {"api_token":AppUrl.apiToken,"limit":"40","page":"1","search":""};

      http.Response response = await http.post(
          Uri.parse(AppUrl.getAllComplaints), body: data);

      Utils.printConsoleData(response.body);
      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['status_code'] == 200) {
          ComplaintListResponse categoryAndMLAResponse = ComplaintListResponse
              .fromJson(jsonDecode(response.body));
          _complainData = categoryAndMLAResponse.data.where((e)=>e.createType == createType).toList();
          _isLoading = false;
          notifyListeners();
        }else{
          EasyLoading.showError("${jsonDecode(response.body)['status_code']} - ${jsonDecode(response.body)['status_text']}");
          _isLoading = false;
          notifyListeners();
        }
      }else{
        EasyLoading.showError("${response.statusCode}");
        _isLoading = false;
        notifyListeners();
      }

      log(response.body);
    // }on SocketException {
    //   _isLoading = false;
    //   notifyListeners();
    //   throw FetchDataException('No Internet Connection');
    //}
    // catch(e){
    //   EasyLoading.showError("Something went wrong. Please try again!!!");
    //   _isLoading = false;
    //   notifyListeners();
    // }
  }
  Future deleteComplaint(String id,int index) async{
    _isLoading = true;
    notifyListeners();
   // try {
      var data = {"api_token":AppUrl.apiToken,"complaint_id":id};

      http.Response response = await http.post(
          Uri.parse(AppUrl.deleteComplaintt), body: data);

      Utils.printConsoleData(response.body);
      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['status_code'] == 200) {
         _complainData.removeAt(index);
          _isLoading = false;
          notifyListeners();
        }else{
          EasyLoading.showError("${jsonDecode(response.body)['status_code']} - ${jsonDecode(response.body)['status_text']}");
          _isLoading = false;
          notifyListeners();
        }
      }else{
        EasyLoading.showError("${response.statusCode}");
        _isLoading = false;
        notifyListeners();
      }

      log(response.body);
    // }on SocketException {
    //   _isLoading = false;
    //   notifyListeners();
    //   throw FetchDataException('No Internet Connection');
    //}
    // catch(e){
    //   EasyLoading.showError("Something went wrong. Please try again!!!");
    //   _isLoading = false;
    //   notifyListeners();
    // }
  }

  Position? currentPosittion;
  Future<Position> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.requestPermission();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('Location Permission'),
            content: const Text(
                'Location services would need to be Enabled.\n\nTo Enable, go to settings and turn on Location.'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              CupertinoDialogAction(
                child: const Text('Go To Setting'),
                onPressed: () async{
                  openAppSettings();
                },
              ),
            ],
          ));
    }
    currentPosittion = await Geolocator.getCurrentPosition();
    getAddressFromCoordinates(LatLng(currentPosittion!.latitude, currentPosittion!.longitude));
    return await Geolocator.getCurrentPosition();
  }

  getAddressFromCoordinates(LatLng p) async{
    List<Placemark> placemarks = await placemarkFromCoordinates(p.latitude, p.longitude);
    var address   = "${placemarks.first.street} ${placemarks.first.subAdministrativeArea} ${placemarks.first.administrativeArea}-${placemarks.first.postalCode} ${placemarks.first.country}";

    print("adddress $address");
    addressCtr.text = address;
    notifyListeners();
  }

}