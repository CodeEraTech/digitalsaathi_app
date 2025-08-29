import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/data/app_excaptions.dart';
import 'package:digitalsaathi/data/model/meeting_detail_response.dart';
import 'package:digitalsaathi/data/model/meeting_list_response.dart';
import 'package:digitalsaathi/data/model/meeting_report_response.dart';
import 'package:digitalsaathi/model/feedmodel.dart';
import 'package:digitalsaathi/ui/botttom_bar/bottom_nav_bar.dart';
import 'package:digitalsaathi/ui/home/widgets/ReelModel.dart';
import 'package:digitalsaathi/utils/connection_util.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class MeetingProvider with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  List<MeetingData> _meetingListData = [];

  List<MeetingData> get meetingListData => _meetingListData;

  Future getAllMeetings() async{
    _isLoading = true;
    //try {
      var data = {
        "api_token": AppUrl.apiToken,
      };

      http.Response response = await http.post(
          Uri.parse(AppUrl.getMeetingList), body: data);

      Utils.printConsoleData(response.body);
    Utils.printConsoleData(data.toString());
      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['status_code'] == 200) {
          MeetingListResponse meetingListResponse = MeetingListResponse.fromJson(jsonDecode(response.body));
          _meetingListData = meetingListResponse.data;
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





  List<MeetingDetailData> _meetingDetailData = [];

  List<MeetingDetailData> get meetingDetailData => _meetingDetailData;

  Future getMeetingDetail(String meetingId) async{
    _isLoading = true;
    //try {
      var data = {
        "meeting_id": meetingId,
      };

      http.Response response = await http.post(Uri.parse(AppUrl.getMeetingDetail), body: data);

      Utils.printConsoleData(response.body);
      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['status_code'] == 200) {
          MeetingDetailResponse meetingListResponse = MeetingDetailResponse.fromJson(jsonDecode(response.body));
          _meetingDetailData = [meetingListResponse.data];
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


  Future markAttendance(String meetingId,String participantId, String attendance, int position) async{
    _isLoading = true;
    notifyListeners();
    //try {
      var data = {
        "api_token": AppUrl.apiToken,
        "meeting_id": meetingId,
        "participant_id": participantId,
        "attandance": attendance,
      };

      http.Response response = await http.post(
          Uri.parse(AppUrl.markMeetingAttendance), body: data);

      Utils.printConsoleData(response.body);
      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['status_code'] == 200) {
          _meetingDetailData[0].participants[position].attandance = attendance;
          getMeetingDetail(meetingId);
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


  //Add/Updat Participant

  TextEditingController nameCtr = TextEditingController();
  TextEditingController mobileCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController fatherNameCtr = TextEditingController();
  TextEditingController genderCtr = TextEditingController();
  TextEditingController designationCtr = TextEditingController();
  TextEditingController ageCtr = TextEditingController();
  TextEditingController idCardNoCtr = TextEditingController();
  TextEditingController wardNoCtr = TextEditingController();
  TextEditingController castCtr = TextEditingController();

  TextEditingController houseCtr = TextEditingController();
  TextEditingController rTyprCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();

  setUpdateData(Participants? participant){
    if(participant != null) {
      nameCtr.text = participant.name;
      mobileCtr.text = participant.mobile;
      emailCtr.text = participant.email;
      fatherNameCtr.text = participant.fatherName;
      genderCtr.text = participant.gender;
      designationCtr.text = participant.designation;
      ageCtr.text = participant.age;
      idCardNoCtr.text = participant.idCardNo;
      wardNoCtr.text = participant.wardNo;
      castCtr.text = participant.cast;
      rTyprCtr.text = participant.rtype;
      addressCtr.text = participant.address;
    }else{
      nameCtr.text = "";
      mobileCtr.text = "";
      emailCtr.text = "";
      fatherNameCtr.text = "";
      genderCtr.text = "";
      designationCtr.text = "";
      ageCtr.text = "";
      idCardNoCtr.text = "";
      wardNoCtr.text = "";
      castCtr.text = "";
      rTyprCtr.text = "";
      addressCtr.text = "";
    }
    //notifyListeners();
  }

  Future addParticipant(BuildContext context,String meetingId) async{
    _isLoading = true;
    //try {
      var data = {
        "api_token": AppUrl.apiToken,
        "meeting_id": meetingId,
        "name": nameCtr.text.toString(),
        "mobile": mobileCtr.text.toString(),
        "email": emailCtr.text.toString(),
        "father_name": fatherNameCtr.text.toString(),
        "gender": genderCtr.text.toString(),
        "rtype": rTyprCtr.text.toString(),
        "age": ageCtr.text.toString(),
        "id_card_no": idCardNoCtr.text.toString(),
        "house_no": houseCtr.text.toString(),
        "address": addressCtr.text.toString(),
        "ward_no": wardNoCtr.text.toString(),
        "party":"",
        "category": "",
        "cast": castCtr.text.toString(),
        "designation": designationCtr.text.toString(),
      };

      print('PARTICIPANT SENDED DATA ---->');
      Utils.printConsoleData(data.toString());

      http.Response response = await http.post(
          Uri.parse(AppUrl.addMeetingParticipant), body: data);

      Utils.printConsoleData(response.body);
      // log("SEND PARTICIPANT RESPONSE :-------->${response.body}");
      // log("SEND PARTICIPANT DATA:-------->${data.toString()}");
      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['status_code'] == 200) {
          _isLoading = false;
          notifyListeners();
          Navigator.pop(context,true);
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
  Future updateParticipant(BuildContext context,String meetingId,String participantId) async{
    _isLoading = true;
   // try {
      var data = {
        "api_token": AppUrl.apiToken,
        "meeting_id": meetingId,
        "participant_id": participantId,
        "name": nameCtr.text.toString(),
        "mobile": mobileCtr.text.toString(),
        "email": emailCtr.text.toString(),
        "father_name": fatherNameCtr.text.toString(),
        "gender": genderCtr.text.toString(),
        "rtype": rTyprCtr.text.toString(),
        "age": ageCtr.text.toString(),
        "id_card_no": idCardNoCtr.text.toString(),
        "house_no": houseCtr.text.toString(),
        "address": addressCtr.text.toString(),
        "ward_no": wardNoCtr.text.toString(),
        "party":"",
        "category": "",
        "cast": castCtr.text.toString(),
        "designation": designationCtr.text.toString(),
      };

      http.Response response = await http.post(
          Uri.parse(AppUrl.updateMeetingParticipants), body: data);

      Utils.printConsoleData(response.body);
      Utils.printConsoleData(data.toString());
      // log("Update And Get Data -----> ${data.toString()}");
      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['status_code'] == 200) {
          _isLoading = false;
          notifyListeners();
          Navigator.pop(context,true);
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

  //Meeting Report

  List<MeetingReportData> _meetingReportResponse = [];

  List<MeetingReportData> get meetingReportResponse => _meetingReportResponse;

  Future getMeetingReport() async{
    _isLoading = true;
   // try {
      var data = {
        "api_token": AppUrl.apiToken,
      };

      http.Response response = await http.post(
          Uri.parse(AppUrl.getMeetingReport), body: data);

      Utils.printConsoleData(response.body);
      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['status_code'] == 200) {
          MeetingReportResponse meetingReportResponse = MeetingReportResponse
              .fromJson(jsonDecode(response.body));
          _meetingReportResponse = [meetingReportResponse.data];
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


  Future submitMeetingReview({required List<File> meetingFiles,required List<File> agendaFiles,required String meetingId,required String meetingDesc,required String agendaDisc}) async {
    _isLoading = true;
    notifyListeners();

    Map<String, String> data = {
      "api_token": AppUrl.apiToken,
      "meeting_id": meetingId,
      "message":meetingDesc,
      "description":agendaDisc,

    };
    print(data);
    print(AppUrl.meetingReview);
    var request =  http.MultipartRequest(
        'POST', Uri.parse(AppUrl.meetingReview));
    request.fields.addAll(data);
    if(meetingFiles.isNotEmpty){
      for( int i=0;i<meetingFiles.length;i++){
        var multipartFile = await http.MultipartFile.fromPath(
            'images[$i]', meetingFiles[i].path); //returns a Future<MultipartFile>
        request.files.add(multipartFile);
      }
    }

    if(agendaFiles.isNotEmpty){
      for( int i=0;i<agendaFiles.length;i++){
        var multipartFile = await http.MultipartFile.fromPath(
            'agenda_images[$i]', agendaFiles[i].path); //returns a Future<MultipartFile>
        request.files.add(multipartFile);
      }
    }
    for(var i in request.files){
      print(i);
    }

    http.StreamedResponse response = await request.send();
    //print(await response.stream.bytesToString());
    final respStr = await response.stream.bytesToString();
    var result = jsonDecode(respStr);

    if (response.statusCode == 200) {
      if(result["status_code"] == 200){
        _isLoading = false;
        Utils.toastMessage(result["status_text"].toString());
        getMeetingDetail(meetingId);
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

}