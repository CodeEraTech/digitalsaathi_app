import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/data/app_excaptions.dart';
import 'package:digitalsaathi/data/model/assembly_model.dart';
import 'package:digitalsaathi/data/model/category_and_mla_response.dart';
import 'package:digitalsaathi/data/model/complaint_list_response.dart';
import 'package:digitalsaathi/data/model/constituency_response.dart';
import 'package:digitalsaathi/data/model/district_response.dart';
import 'package:digitalsaathi/data/model/id_card_response.dart';
import 'package:digitalsaathi/data/model/login_model.dart';
import 'package:digitalsaathi/data/model/meeting_detail_response.dart';
import 'package:digitalsaathi/data/model/meeting_list_response.dart';
import 'package:digitalsaathi/data/model/meeting_report_response.dart';
import 'package:digitalsaathi/data/model/my_epic_data_model.dart';
import 'package:digitalsaathi/data/model/profile_model.dart';
import 'package:digitalsaathi/data/model/state_response.dart';
import 'package:digitalsaathi/model/feedmodel.dart';
import 'package:digitalsaathi/ui/botttom_bar/bottom_nav_bar.dart';
import 'package:digitalsaathi/ui/home/widgets/ReelModel.dart';
import 'package:digitalsaathi/utils/connection_util.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class ProfileProvider with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;




  ProfileData? profileData;
  Future getProfile() async{
    _isLoading = true;
   // try {

      var data = {"api_token":AppUrl.apiToken};

      http.Response response = await http.post(
          Uri.parse(AppUrl.getProfile), body: data);

      Utils.printConsoleData(AppUrl.getProfile);
      Utils.printConsoleData(data.toString());
      Utils.printConsoleData(response.body);
      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['status_code'] == 200) {
          ProfileModel profileModel = ProfileModel
              .fromJson(jsonDecode(response.body));
          profileData = profileModel.data;
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
    // }
    // catch(e){
    //   EasyLoading.showError("Something went wrong. Please try again!!!");
    //   _isLoading = false;
    //   notifyListeners();
    // }
  }
  // Future updateProfile(var data,context) async{
  //   _isLoading = true;
  //   notifyListeners();
  //  // try {
  //
  //
  //     http.Response response = await http.post(
  //         Uri.parse(AppUrl.updateProfile), body: data);
  //
  //     Utils.printConsoleData(response.body);
  //     if (response.statusCode == 200) {
  //       if(jsonDecode(response.body)['status_code'] == 200) {
  //         _isLoading = false;
  //         notifyListeners();
  //         getProfile();
  //         Navigator.pop(context);
  //
  //       }else{
  //         EasyLoading.showError("${jsonDecode(response.body)['status_code']} - ${jsonDecode(response.body)['status_text']}");
  //         _isLoading = false;
  //         notifyListeners();
  //       }
  //     }else{
  //       EasyLoading.showError("${response.statusCode}");
  //       _isLoading = false;
  //       notifyListeners();
  //     }
  //
  //     log(response.body);
  //   // }on SocketException {
  //   //   _isLoading = false;
  //   //   notifyListeners();
  //   //   throw FetchDataException('No Internet Connection');
  //   // }
  //   // catch(e){
  //   //   EasyLoading.showError("Something went wrong. Please try again!!!");
  //   //   _isLoading = false;
  //   //   notifyListeners();
  //   // }
  // }

  Future updateProfile(var data,context,File? documentFile) async {
    _isLoading = true;
    notifyListeners();

    var request =  http.MultipartRequest(
        'POST', Uri.parse(AppUrl.updateProfile));
    request.fields.addAll(data);
    if(documentFile != null){
     // for(var file in documentFiles){
        var multipartFile = await http.MultipartFile.fromPath(
            'profile_pic', documentFile.path); //returns a Future<MultipartFile>
        request.files.add(multipartFile);
     // }

    }
    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    var result = jsonDecode(respStr);

    if (response.statusCode == 200) {
      if(result['status_code'] == 200) {
        _isLoading = false;
        notifyListeners();
        getProfile();
        Navigator.pop(context);

      }else{
        EasyLoading.showError("${result['status_code']} - ${result['status_text']}");
        _isLoading = false;
        notifyListeners();
      }
    }else{
      EasyLoading.showError("${response.statusCode}");
      _isLoading = false;
      notifyListeners();
    }
  }



  CardData? cardData;

  Future getMemberId() async{
    _isLoading = true;
    // try {

    var data = {"api_token":AppUrl.apiToken};

    http.Response response = await http.post(
        Uri.parse(AppUrl.getMemberId), body: data);

    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if(jsonDecode(response.body)['status_code'] == 200) {
        IDCardModel idCardModel = IDCardModel
            .fromJson(jsonDecode(response.body));
        cardData = idCardModel.data;
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
    // }
    // catch(e){
    //   EasyLoading.showError("Something went wrong. Please try again!!!");
    //   _isLoading = false;
    //   notifyListeners();
    // }
  }



  Future getEPICNumber(String epicNumber,callback) async{
    _isLoading = true;
    notifyListeners();
    // try {

    var data = {
      "api_token":AppUrl.apiToken,
      "district_id":"",
      "epic_number":"${epicNumber}",
      "limit":"50",
      "mla_assembly_id":"",
      "mp_constituency_id":"",
      "state_id":"",
      "boothno":"",
      "search":"",
      "mobile":"",
      "page":"",
      "rname":"",
    };

    http.Response response = await http.post(
        Uri.parse(AppUrl.checkEpicNumber), body: data);

    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if(jsonDecode(response.body)['status'] == 200) {
        MyEpicDataModel myEpicDataModel = MyEpicDataModel
            .fromJson(jsonDecode(response.body));
        callback(myEpicDataModel.data);
        _isLoading = false;
        notifyListeners();
      }else{
        callback(null);
        EasyLoading.showError("${jsonDecode(response.body)['status']} - ${jsonDecode(response.body)['message']}");
        _isLoading = false;
        notifyListeners();
      }
    }else{
      callback(null);
      EasyLoading.showError("${response.statusCode}");
      _isLoading = false;
      notifyListeners();
    }

    log(response.body);
    // }on SocketException {
    //   _isLoading = false;
    //   notifyListeners();
    //   throw FetchDataException('No Internet Connection');
    // }
    // catch(e){
    //   EasyLoading.showError("Something went wrong. Please try again!!!");
    //   _isLoading = false;
    //   notifyListeners();
    // }
  }






}