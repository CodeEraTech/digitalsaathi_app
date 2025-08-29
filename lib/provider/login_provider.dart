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
import 'package:digitalsaathi/data/model/login_model.dart';
import 'package:digitalsaathi/data/model/meeting_detail_response.dart';
import 'package:digitalsaathi/data/model/meeting_list_response.dart';
import 'package:digitalsaathi/data/model/meeting_report_response.dart';
import 'package:digitalsaathi/data/model/state_response.dart';
import 'package:digitalsaathi/model/feedmodel.dart';
import 'package:digitalsaathi/ui/botttom_bar/bottom_nav_bar.dart';
import 'package:digitalsaathi/ui/home/widgets/ReelModel.dart';
import 'package:digitalsaathi/utils/connection_util.dart';
import 'package:digitalsaathi/utils/prefrence/pref_utils.dart';
import 'package:digitalsaathi/utils/prefrence/shared_preferences.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class LoginProvider with ChangeNotifier {

  bool _isLoading = false;
  bool get isLoading => _isLoading;




  Future loginUser(BuildContext context,String mobile,String otp) async{
    _isLoading = true;
    notifyListeners();
   // try {

      var data = {
        "device_id":"${AppUrl.FCM_TOKEN}","mobile":mobile,"mobile_otp":otp
      };

      print(data);

      http.Response response = await http.post(Uri.parse(AppUrl.loginUser), body: data);

      Utils.printConsoleData(response.body);
      if (response.statusCode == 200) {
        if(jsonDecode(response.body)['status_code'] == 200) {
          LoginModel loginModel = LoginModel.fromJson(jsonDecode(response.body));
          AppUrl.apiToken = loginModel.authkey.toString();
          PrefUtils.setToken(loginModel.authkey.toString());
          PrefUtils.setUserId(loginModel.id.toString().toString());
          PrefUtils.setUserName(loginModel.firstName.toString().toString());
          PrefUtils.setMlaAssemblyId(loginModel.mlaAssemblyId.toString());
          PrefUtils.setMpConstituencyId(loginModel.mpConstituencyId.toString());

          if (loginModel.primaryFontSize != null) {
            PrefUtils.setFontSizeName(double.parse(loginModel.primaryFontSize!));
          }

          if (loginModel.secondaryFontSize != null) {
            PrefUtils.setFontSizeDesignation(double.parse(loginModel.secondaryFontSize!));
          }


          // PrefUtils.setFontSizeName(double.parse(loginModel.primaryFontSize));///loginModel.->pont ke baad indicate kar raha hai problem kya hai<-primaryFontSize
          // PrefUtils.setFontSizeDesignation(double.parse(loginModel.secondaryFontSize));
          // log('--------------- NAME AND DESIGNATION FONTSIZE----------------------------');
          // log("NAME  FONTSIZE${loginModel.primaryFontSize}  DESIGNATION FONTSIZE${loginModel.secondaryFontSize}");

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => BottomNavBar(),
            ),(Route<dynamic> route) => false,
          );
          _isLoading = false;
          notifyListeners();
        }else{
          EasyLoading.showError("Wrong OTP!!!.");
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








}