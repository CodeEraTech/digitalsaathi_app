import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/data/app_excaptions.dart';
import 'package:digitalsaathi/data/model/leaders_response.dart';
import 'package:digitalsaathi/data/model/meeting_detail_response.dart';
import 'package:digitalsaathi/data/model/meeting_list_response.dart';
import 'package:digitalsaathi/data/model/meeting_report_response.dart';
import 'package:digitalsaathi/data/model/party_symbol_response.dart';
import 'package:digitalsaathi/data/model/political_profile_response.dart';
import 'package:digitalsaathi/data/model/poster_comment_response.dart';
import 'package:digitalsaathi/data/model/poster_list_response.dart';
import 'package:digitalsaathi/data/model/task_data_response.dart';
import 'package:digitalsaathi/model/feedmodel.dart';
import 'package:digitalsaathi/ui/botttom_bar/bottom_nav_bar.dart';
import 'package:digitalsaathi/ui/home/widgets/ReelModel.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:digitalsaathi/utils/connection_util.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PosterProvidder with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;


  List<PosterData> _posterData = [];

  List<PosterData> get posterData => _posterData;

  DefaultProfile? defaultProfile;

  Future getAllPoster() async {
    _isLoading = true;
   // try {
      var body = {
        "api_token": AppUrl.apiToken,
        "limit": "100",
        "page": "1",
      };

      http.Response response = await http.post(Uri.parse(AppUrl.getAllPoster), body: body);
    print(body.toString());
    print("fjvhfjvh");
      Utils.printConsoleData(response.body);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status_code'] == 200) {

          PosterListModel posterListModel = PosterListModel.fromJson(jsonDecode(response.body));
          _posterData = posterListModel.data;
          defaultProfile = posterListModel.defaultProfile;
          _isLoading = false;
          notifyListeners();
        } else {
          EasyLoading.showError(
              "${jsonDecode(response.body)['status_code']} - ${jsonDecode(response.body)['status_text']}");
          _isLoading = false;
          notifyListeners();
        }
      } else {
        EasyLoading.showError("${response.statusCode}");
        _isLoading = false;
        notifyListeners();
      }

    // } on SocketException {
    //   _isLoading = false;
    //   notifyListeners();
    //   throw FetchDataException('No Internet Connection');
    // } catch (e) {
    //   EasyLoading.showError("Something went wrong. Please try again!!!");
    //   _isLoading = false;
    //   notifyListeners();
    // }
  }

  Future posterLike(String eventId,String like,int position) async {
    _isLoading = true;
    // try {

    var body = {"api_token":AppUrl.apiToken,"event_id":eventId,"is_like":like};
    http.Response response =
    await http.post(Uri.parse(AppUrl.posterLike),body: body);

    Utils.printConsoleData(body.toString());
    Utils.printConsoleData(AppUrl.posterLike);
    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status_code'] == 200) {
        _posterData[position].isLikeStatus = like;
        if(like == "1") {
          _posterData[position].likesCount += 1;
        }else{
          _posterData[position].likesCount -= 1;
        }
        _isLoading = false;
        notifyListeners();
      } else {
        EasyLoading.showError(
            "${jsonDecode(response.body)['status_code']} - ${jsonDecode(response.body)['status_text']}");
        _isLoading = false;
        notifyListeners();
      }
    } else {
      EasyLoading.showError("${response.statusCode}");
      _isLoading = false;
      notifyListeners();
    }


    // } on SocketException {
    //   _isLoading = false;
    //   notifyListeners();
    //   throw FetchDataException('No Internet Connection');
    // } catch (e) {
    //   EasyLoading.showError("Something went wrong. Please try again!!!");
    //   _isLoading = false;
    //   notifyListeners();
    // }
  }

  List<Comments> _posterComments = [];

  List<Comments> get posterComments => _posterComments;

  Future getPosterComments(String eventId) async {
    _isLoading = true;
    // try {

    var body = {"api_token":AppUrl.apiToken,"event_id":eventId};
    http.Response response =
    await http.post(Uri.parse(AppUrl.getPosterComment),body: body);

    Utils.printConsoleData(body.toString());
    Utils.printConsoleData(AppUrl.posterLike);
    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status_code'] == 200) {
       PosterCommentResponse posterCommentResponse = PosterCommentResponse.fromJson(jsonDecode(response.body));
       _posterComments = posterCommentResponse.comments;
        _isLoading = false;
        notifyListeners();
      } else {
        EasyLoading.showError(
            "${jsonDecode(response.body)['status_code']} - ${jsonDecode(response.body)['status_text']}");
        _isLoading = false;
        notifyListeners();
      }
    } else {
      EasyLoading.showError("${response.statusCode}");
      _isLoading = false;
      notifyListeners();
    }


    // } on SocketException {
    //   _isLoading = false;
    //   notifyListeners();
    //   throw FetchDataException('No Internet Connection');
    // } catch (e) {
    //   EasyLoading.showError("Something went wrong. Please try again!!!");
    //   _isLoading = false;
    //   notifyListeners();
    // }
  }


  Future postComment(String eventId,String comment,int index) async {
    _isLoading = true;
    // try {

    var body = {"api_token":AppUrl.apiToken,"event_id":eventId,"comment":comment,"epic_ids":""};
    http.Response response =
    await http.post(Uri.parse(AppUrl.postComment),body: body);

    Utils.printConsoleData(body.toString());
    Utils.printConsoleData(AppUrl.postComment);
    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status_code'] == 200) {
        _posterData[index].commentsCount += 1;
         getPosterComments(eventId);
        _isLoading = false;
        notifyListeners();
      } else {
        EasyLoading.showError(
            "${jsonDecode(response.body)['status_code']} - ${jsonDecode(response.body)['status_text']}");
        _isLoading = false;
        notifyListeners();
      }
    } else {
      EasyLoading.showError("${response.statusCode}");
      _isLoading = false;
      notifyListeners();
    }


    // } on SocketException {
    //   _isLoading = false;
    //   notifyListeners();
    //   throw FetchDataException('No Internet Connection');
    // } catch (e) {
    //   EasyLoading.showError("Something went wrong. Please try again!!!");
    //   _isLoading = false;
    //   notifyListeners();
    // }
  }






  onInitCreateProfileData(PoliticalProfileData? politicalProfileData) async {
    if(politicalProfileData == null) {
      _partySymbolData = [];
      selectedLogo = -1;
      _partyLeadersData = [];
      nameCtr.text = "";
      positionAreaCtr.text = "";
      partyNameCtr.text = "";
      evmSerialNoCtr.text = "";
      whatsappCtr.text = "";
      facebookCtr.text = "";
      twitterIdCtr.text = "";
    }else{
      await getPartyLogo().then((onValue){
       int index = partySymbolData.indexWhere((element)=>element.id == politicalProfileData.symbolId);
       selectedLogo = index;
      });
      await getPoliticalProfile().then((newValue){
        for(var leader in partyLeadersData){
          for(var sl in politicalProfileData.leaders){
            if(leader.id == sl.id){
              leader.selected = true;
            }
          }
        }
        //partyLeadersData.where((element)=>element.id == politicalProfileData.leaders.).toList();
      });
      nameCtr.text = politicalProfileData.name;
      positionAreaCtr.text =politicalProfileData.designation;
      partyNameCtr.text = politicalProfileData.partyName;
      evmSerialNoCtr.text = politicalProfileData.evm;
      whatsappCtr.text = politicalProfileData.whatsapp;
      facebookCtr.text = politicalProfileData.facebook;
      twitterIdCtr.text =politicalProfileData.twitter;
    }
    image = null;
  }
  List<PartySymbolData> _partySymbolData = [];

  List<PartySymbolData> get partySymbolData => _partySymbolData;

  int selectedLogo = -1;
  onLogoSelected(int index){
    selectedLogo = index;
    notifyListeners();
  }

  Future getPartyLogo() async {
    _isLoading = true;
    // try {

    http.Response response =
    await http.get(Uri.parse(AppUrl.getPartySymbols),);

    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        PartySymbolResponse partySymbolResponse = PartySymbolResponse.fromJson(jsonDecode(response.body));
        _partySymbolData = partySymbolResponse.data;
        _isLoading = false;
        notifyListeners();
      } else {
        EasyLoading.showError(
            "${jsonDecode(response.body)['status']} - ${jsonDecode(response.body)['message']}");
        _isLoading = false;
        notifyListeners();
      }
    } else {
      EasyLoading.showError("${response.statusCode}");
      _isLoading = false;
      notifyListeners();
    }


    // } on SocketException {
    //   _isLoading = false;
    //   notifyListeners();
    //   throw FetchDataException('No Internet Connection');
    // } catch (e) {
    //   EasyLoading.showError("Something went wrong. Please try again!!!");
    //   _isLoading = false;
    //   notifyListeners();
    // }
  }


  List<LeaderData> _partyLeadersData = [];

  List<LeaderData> get partyLeadersData => _partyLeadersData;

  List<LeaderData> _selectedLeadersInOrder = [];

  List<LeaderData> get selectedLeadersInOrder => _selectedLeadersInOrder;

  /// Set new leaders (e.g. from backend)
  void setLeaders(List<LeaderData> leaders) {
    _partyLeadersData = leaders;
    resetSelection();
    notifyListeners();
  }

  /// Clear all previous selections
  void resetSelection() {
    for (var leader in _partyLeadersData) {
      leader.selected = false;
    }
    _selectedLeadersInOrder.clear();
    notifyListeners();
  }

  /// Select/deselect and maintain order
  void onLeaderSelected(int index) {
    final leader = _partyLeadersData[index];
    leader.selected = !leader.selected;

    if (leader.selected) {
      _selectedLeadersInOrder.add(leader);
    } else {
      _selectedLeadersInOrder.remove(leader);
    }

    notifyListeners();
  }

  // onLeaderSelected(int index){
  //   _partyLeadersData[index].selected = !_partyLeadersData[index].selected;
  //
  //   notifyListeners();
  // }

  Future getLeaders() async {
    _isLoading = true;
    // try {

    http.Response response =
    await http.get(Uri.parse(AppUrl.getAllLeaders),);

    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        LeadersResponse leadersResponse = LeadersResponse.fromJson(jsonDecode(response.body));
        _partyLeadersData = leadersResponse.data;

        _isLoading = false;
        notifyListeners();
      } else {
        EasyLoading.showError(
            "${jsonDecode(response.body)['status']} - ${jsonDecode(response.body)['message']}");
        _isLoading = false;
        notifyListeners();
      }
    } else {
      EasyLoading.showError("${response.statusCode}");
      _isLoading = false;
      notifyListeners();
    }

    log(response.body);
    // } on SocketException {
    //   _isLoading = false;
    //   notifyListeners();
    //   throw FetchDataException('No Internet Connection');
    // } catch (e) {
    //   EasyLoading.showError("Something went wrong. Please try again!!!");
    //   _isLoading = false;
    //   notifyListeners();
    // }
  }



  List<PoliticalProfileData> _politicalProfileData = [];

  List<PoliticalProfileData> get politicalProfileData => _politicalProfileData;

  Future getPoliticalProfile() async {
    _isLoading = true;
    // try {

    var body = {"api_token":AppUrl.apiToken};
    http.Response response =
    await http.post(Uri.parse(AppUrl.getPoliticalProfile),body: body);

    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        PoliticalProfileResponse politicalProfileResponse = PoliticalProfileResponse.fromJson(jsonDecode(response.body));
        _politicalProfileData = politicalProfileResponse.data;
        _isLoading = false;
        notifyListeners();
      } else {
        EasyLoading.showError(
            "${jsonDecode(response.body)['status']} - ${jsonDecode(response.body)['message']}");
        _isLoading = false;
        notifyListeners();
      }
    } else {
      EasyLoading.showError("${response.statusCode}");
      _isLoading = false;
      notifyListeners();
    }

    log(response.body);
    // } on SocketException {
    //   _isLoading = false;
    //   notifyListeners();
    //   throw FetchDataException('No Internet Connection');
    // } catch (e) {
    //   EasyLoading.showError("Something went wrong. Please try again!!!");
    //   _isLoading = false;
    //   notifyListeners();
    // }
  }
  Future deletePosterProfile(String id,int index) async {
    _isLoading = true;
    notifyListeners();
    // try {

    var body = {"api_token":AppUrl.apiToken,"id":id};
    http.Response response =
    await http.post(Uri.parse(AppUrl.deletePoliticalProfile),body: body);

    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        _politicalProfileData.removeAt(index);
        getPoliticalProfile();
        EasyLoading.showSuccess(
            "${jsonDecode(response.body)['status']} - ${jsonDecode(response.body)['message']}");

        _isLoading = false;
        notifyListeners();
      } else {
        EasyLoading.showError(
            "${jsonDecode(response.body)['status']} - ${jsonDecode(response.body)['message']}");
        _isLoading = false;
        notifyListeners();
      }
    } else {
      EasyLoading.showError("${response.statusCode}");
      _isLoading = false;
      notifyListeners();
    }

    log(response.body);
    // } on SocketException {
    //   _isLoading = false;
    //   notifyListeners();
    //   throw FetchDataException('No Internet Connection');
    // } catch (e) {
    //   EasyLoading.showError("Something went wrong. Please try again!!!");
    //   _isLoading = false;
    //   notifyListeners();
    // }
  }
  Future changePoliticalChange(BuildContext context,String id) async {
    _isLoading = true;
    notifyListeners();
    // try {

    var body = {"api_token":AppUrl.apiToken,"id":id};
    http.Response response =
    await http.post(Uri.parse(AppUrl.changePoliticalStatus),body: body);

    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {

        Navigator.pop(context,true);

        _isLoading = false;
        notifyListeners();
      } else {
        EasyLoading.showError(
            "${jsonDecode(response.body)['status']} - ${jsonDecode(response.body)['message']}");
        _isLoading = false;
        notifyListeners();
      }
    } else {
      EasyLoading.showError("${response.statusCode}");
      _isLoading = false;
      notifyListeners();
    }

    log(response.body);
    // } on SocketException {
    //   _isLoading = false;
    //   notifyListeners();
    //   throw FetchDataException('No Internet Connection');
    // } catch (e) {
    //   EasyLoading.showError("Something went wrong. Please try again!!!");
    //   _isLoading = false;
    //   notifyListeners();
    // }
  }


  TextEditingController nameCtr = TextEditingController();
  TextEditingController positionAreaCtr = TextEditingController();
  TextEditingController partyNameCtr = TextEditingController();
  TextEditingController evmSerialNoCtr = TextEditingController();
  TextEditingController whatsappCtr = TextEditingController();
  TextEditingController facebookCtr = TextEditingController();
  TextEditingController twitterIdCtr = TextEditingController();



  // Future<void> pickImage(ImageSource source) async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: source);
  //
  //   if (pickedFile != null) {
  //       image = File(pickedFile.path);
  //       notifyListeners();
  //       Get.back();
  //   }
  // }
  File? image;

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        cropStyle: CropStyle.rectangle,
        compressFormat: ImageCompressFormat.png,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Color(0xff28B3D5),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true,
            activeControlsWidgetColor: ColorUtils.primaryColor,
            backgroundColor: ColorUtils.darkTheme,
            showCropGrid: false,
            cropFrameColor: Colors.transparent,
          ),
          IOSUiSettings(
            title: 'Crop Image',
          ),
          WebUiSettings(
            context: Get.context!, // or `context` if within a widget
          ),
        ],
      );

      if (croppedFile != null) {
        image = File(croppedFile.path);
        notifyListeners();
        Get.back();
      }
    }
  }


  void removeImage() {
      image = null;
      notifyListeners();
  }
  Future createPosterProfile(BuildContext context, PoliticalProfileData? politicalProfileData,) async {
    _isLoading = true;
    notifyListeners();
    // var list = partyLeadersData.where((element) => element.selected).toList();
    var list = selectedLeadersInOrder;
    String leaders = "";
    for (int i = 0; i < list.length; i++) {
      leaders = leaders + "" + list[i].id.toString();
      if (list.length != i + 1) {
        leaders = leaders + ",";
      }
    }
    Map<String, String> data = {
      "api_token": AppUrl.apiToken,
      "id": politicalProfileData==null?"":politicalProfileData.id.toString(),
      "symbol_id":selectedLogo==-1?"0":partySymbolData[selectedLogo].id.toString(),
      "designation":positionAreaCtr.text.toString(),
      "party_name":partyNameCtr.text.toString(),
      "evm":evmSerialNoCtr.text.toString(),
      "whatsapp":whatsappCtr.text.toString(),
      "facebook":facebookCtr.text.toString(),
      "twitter":twitterIdCtr.text.toString(),
      "leader_symbol":list.isNotEmpty?list[0].id.toString():"",
      "name":nameCtr.text.toString(),
      "leaders":leaders,
    };
    print(data);
    var request =  http.MultipartRequest(
        'POST', Uri.parse(AppUrl.createPosterProfile));
    request.fields.addAll(data);
    if(image != null){
      var multipartFile = await http.MultipartFile.fromPath(
          'profile', image!.path); //returns a Future<MultipartFile>
      request.files.add(multipartFile);
    }
    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    var result = jsonDecode(respStr);

    if (response.statusCode == 200) {
      if(result["status"] == 200){
        _isLoading = false;
        Utils.toastMessage(result["message"].toString());
        Navigator.pop(context,true);
        notifyListeners();
      }else{
        _isLoading = false;
        Utils.toastMessage(result["message"].toString());
        notifyListeners();
      }

    } else {
      _isLoading = false;
      Utils.toastMessage(result["message"].toString());
      notifyListeners();
    }
  }

}
