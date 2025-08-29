import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/data/app_excaptions.dart';
import 'package:digitalsaathi/data/model/common_response.dart';
import 'package:digitalsaathi/data/model/meeting_detail_response.dart';
import 'package:digitalsaathi/data/model/meeting_list_response.dart';
import 'package:digitalsaathi/data/model/meeting_report_response.dart';
import 'package:digitalsaathi/data/model/notification_count_model.dart';
import 'package:digitalsaathi/data/model/notification_list_model.dart';
import 'package:digitalsaathi/data/model/task_data_response.dart';
import 'package:digitalsaathi/model/feedmodel.dart';
import 'package:digitalsaathi/ui/botttom_bar/bottom_nav_bar.dart';
import 'package:digitalsaathi/ui/home/widgets/ReelModel.dart';
import 'package:digitalsaathi/utils/connection_util.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class NotificationProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;



  List<NotificationData> _notificationData = [];

  List<NotificationData> get notificationData => _notificationData;

  Future getAllNotification() async {
    _isLoading = true;
   // try {
      var body = {
        "api_token": AppUrl.apiToken,
        "limit": "100",
        "page": "1",
      };

      http.Response response = await http.post(Uri.parse(AppUrl.notificationList), body: body);

      print('<--------------: Notification Response :--------------->');
      Utils.printConsoleData(response.body);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status_code'] == 200) {
          NotificationListModel notificationListModel = NotificationListModel.fromJson(jsonDecode(response.body));
          _notificationData = notificationListModel.data;
         //unreadNotificationCount = notificationCountModel.data;
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
  Future readAllNotification() async {
    _isLoading = true;
    notifyListeners();
   // try {
      var body = {
        "api_token": AppUrl.apiToken,
      };

      http.Response response =
          await http.post(Uri.parse(AppUrl.readAllNotification), body: body);

      Utils.printConsoleData(response.body);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status_code'] == 200) {
          getAllNotification();
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
  Future deleteAllNotification() async {
    _isLoading = true;
    notifyListeners();
   // try {
      var body = {
        "api_token": AppUrl.apiToken,
      };

      http.Response response =
          await http.post(Uri.parse(AppUrl.deleteAllNotification), body: body);

      Utils.printConsoleData(response.body);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status_code'] == 200) {
          getAllNotification();
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

  Future deleteOneNotification(String id,int index) async {
    _isLoading = true;
    notifyListeners();
   // try {
      var body = {
        "api_token": AppUrl.apiToken,
        "notification_id": "$id",
      };

      http.Response response =
          await http.post(Uri.parse(AppUrl.deleteSingleNotification), body: body);

      Utils.printConsoleData(response.body);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status_code'] == 200) {
          _notificationData.removeAt(index);
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
  Future markAsRead(NotificationData nt,int index) async {
    _isLoading = true;
    notifyListeners();
   // try {
      var body = {
        "api_token": AppUrl.apiToken,
        "type": "notification",
        "type_id": "${nt.notificationId}",
      };

      http.Response response =
          await http.post(Uri.parse(AppUrl.markAsReadNotify), body: body);
print(AppUrl.markAsReadNotify);
      Utils.printConsoleData(response.body);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status_code'] == 200) {
          _notificationData[index].readStatus == 1;
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
