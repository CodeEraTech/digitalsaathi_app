import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/data/app_excaptions.dart';
import 'package:digitalsaathi/data/model/common_response.dart';
import 'package:digitalsaathi/data/model/follow_list_response.dart';
import 'package:digitalsaathi/data/model/meeting_detail_response.dart';
import 'package:digitalsaathi/data/model/meeting_list_response.dart';
import 'package:digitalsaathi/data/model/meeting_report_response.dart';
import 'package:digitalsaathi/data/model/survey_report_su.dart';
import 'package:digitalsaathi/data/model/survey_response.dart';
import 'package:digitalsaathi/data/model/task_data_response.dart';
import 'package:digitalsaathi/data/model/user_progress_model.dart';
import 'package:digitalsaathi/data/model/voter_report_response.dart';
import 'package:digitalsaathi/model/feedmodel.dart';
import 'package:digitalsaathi/provider/theme_provider.dart';
import 'package:digitalsaathi/ui/botttom_bar/bottom_nav_bar.dart';
import 'package:digitalsaathi/ui/home/widgets/ReelModel.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:digitalsaathi/utils/connection_util.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FollowProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<FollowMlaData> _followMlaData =  [];

  List<FollowMlaData> get followMlaData => _followMlaData;

  List<FollowMlaData> _filterFollowMlaData =  [];

  List<FollowMlaData> get filterFollowMlaData => _filterFollowMlaData;

  onMlaSearch(String v){
    if(v.isEmpty){
      _filterFollowMlaData = _followMlaData;
    }else{
      _filterFollowMlaData = _followMlaData.where((element)=>element.name.toString().toUpperCase().contains(v.toUpperCase())).toList();
    }

    notifyListeners();
  }

  Future getMLAList() async
  {
    _isLoading = true;
    // try {

    var body = {
      "api_token":
          AppUrl.apiToken,

    };

    http.Response response = await http.post(Uri.parse(AppUrl.getMlaList), body: body);

    Utils.printConsoleData(AppUrl.getMlaList);
    // Utils.printConsoleData(body.toString());
    // Utils.printConsoleData(response.body);
    // debugPrint(response.body);
    print(response.body.toString());

    if (response.statusCode == 200) {

      if (jsonDecode(response.body)['status_code'] == 200) {
        FollowMLAListResponse followMLAListResponse =
        FollowMLAListResponse.fromJson(jsonDecode(response.body));
        _followMlaData = followMLAListResponse.data;
        _filterFollowMlaData = _followMlaData;
        _isLoading = false;
        notifyListeners();
      } else if (jsonDecode(response.body)['status_code'] == 400) {
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

  Future followMLA(int position,int value) async
  {
    _isLoading = true;
    notifyListeners();
    // try {

    var body = {
      "api_token": AppUrl.apiToken,
      "mla_id": _filterFollowMlaData[position].id.toString(),
      "follow": value.toString(),

    };

    http.Response response =
    await http.post(Uri.parse(AppUrl.followMLA), body: body);

    Utils.printConsoleData(AppUrl.getMlaList);
    Utils.printConsoleData(body.toString());
    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status_code'] == 200) {
        _filterFollowMlaData[position].followed = value;
        _filterFollowMlaData[position].followers += 1;
        _isLoading = false;
        notifyListeners();
      } else if (jsonDecode(response.body)['status_code'] == 400) {
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




}
