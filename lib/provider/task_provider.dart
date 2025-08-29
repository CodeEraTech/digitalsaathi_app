import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/data/app_excaptions.dart';
import 'package:digitalsaathi/data/model/common_response.dart';
import 'package:digitalsaathi/data/model/meeting_detail_response.dart';
import 'package:digitalsaathi/data/model/meeting_list_response.dart';
import 'package:digitalsaathi/data/model/meeting_report_response.dart';
import 'package:digitalsaathi/data/model/task_data_response.dart';
import 'package:digitalsaathi/model/feedmodel.dart';
import 'package:digitalsaathi/ui/botttom_bar/bottom_nav_bar.dart';
import 'package:digitalsaathi/ui/home/widgets/ReelModel.dart';
import 'package:digitalsaathi/utils/connection_util.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class TaskProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<Tasks> _nationalTaskListF = [];
  List<Tasks> _stateTaskListF = [];
  List<Tasks> _districttTaskListF = [];
  List<Tasks> _blockTaskListF = [];

  List<Tasks> _nationalTaskList = [];
  List<Tasks> _stateTaskList = [];
  List<Tasks> _districttTaskList = [];
  List<Tasks> _blockTaskList = [];


  List<Tasks> get nationalTaskList => _nationalTaskList;

  List<Tasks> get stateTaskList => _stateTaskList;

  List<Tasks> get districttTaskList => _districttTaskList;

  List<Tasks> get blockTaskList => _blockTaskList;




  int initialIndex = 0;
  Future getAllTask() async {
    _isLoading = true;
   // try {
      var body = {
        "api_token": AppUrl.apiToken,
        "limit": "500",
        "page": "1",
        "role": "0",
        "search": "",
        "type": "",
        "workerid": "0",
      };

      http.Response response = await http.post(Uri.parse(AppUrl.getTaskList), body: body);
      Utils.printConsoleData(body.toString());
      Utils.printConsoleData(response.body);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status_code'] == 200) {
          TaskModel taskModel = TaskModel.fromJson(jsonDecode(response.body));
          for (var taskData in taskModel.data) {
            if (taskData.roleId == 5) {
              _nationalTaskListF = taskData.tasks;
              List<Tasks> tempList = [];
              List<Tasks> removeList = [];
              tempList = _nationalTaskListF;

              for (var task in tempList) {
                if (AppUrl.roleId == AppUrl.mRoleWorker) {
                  if (task.canViewWorker == 0) {
                    removeList.add(task);
                  }
                } else if (AppUrl.roleId == AppUrl.mRoleStateHead) {
                  if (task.canViewSh == 0) {
                    removeList.add(task);
                  }
                } else if (AppUrl.roleId == AppUrl.mRoleMP) {
                  if (task.canViewMp == 0) {
                    removeList.add(task);
                  }
                } else if (AppUrl.roleId == AppUrl.mRoleMLA) {
                  if (task.canViewMla == 0) {
                    removeList.add(task);
                  }
                }
              }
              if (removeList.isNotEmpty) {
                for (var nation in removeList) {
                  _nationalTaskListF.remove(nation);
                }
              }
            }
            else if(taskData.roleId == 6){
              _stateTaskListF = taskData.tasks;
              List<Tasks> tempList = [];
              List<Tasks> removeList = [];
              tempList = _stateTaskListF;

              for (var task in tempList) {
                if (AppUrl.roleId == AppUrl.mRoleWorker) {
                  if (task.canViewWorker == 0) {
                    removeList.add(task);
                  }
                } else if (AppUrl.roleId == AppUrl.mRoleStateHead) {
                  if (task.canViewSh == 0) {
                    removeList.add(task);
                  }
                } else if (AppUrl.roleId == AppUrl.mRoleMP) {
                  if (task.canViewMp == 0) {
                    removeList.add(task);
                  }
                } else if (AppUrl.roleId == AppUrl.mRoleMLA) {
                  if (task.canViewMla == 0) {
                    removeList.add(task);
                  }
                }
              }
              if (removeList.isNotEmpty) {
                for (var nation in removeList) {
                  _stateTaskListF.remove(nation);
                }
              }
            }
            else if(taskData.roleId == 7){
              _districttTaskListF = taskData.tasks;
              List<Tasks> tempList = [];
              List<Tasks> removeList = [];
              tempList = _districttTaskListF;

              for (var task in tempList) {
                if (AppUrl.roleId == AppUrl.mRoleWorker) {
                  if (task.canViewWorker == 0) {
                    removeList.add(task);
                  }
                } else if (AppUrl.roleId == AppUrl.mRoleStateHead) {
                  if (task.canViewSh == 0) {
                    removeList.add(task);
                  }
                } else if (AppUrl.roleId == AppUrl.mRoleMP) {
                  if (task.canViewMp == 0) {
                    removeList.add(task);
                  }
                } else if (AppUrl.roleId == AppUrl.mRoleMLA) {
                  if (task.canViewMla == 0) {
                    removeList.add(task);
                  }
                }
              }
              if (removeList.isNotEmpty) {
                for (var nation in removeList) {
                  _districttTaskListF.remove(nation);
                }
              }
            }
            else {
              _blockTaskListF = taskData.tasks;
              List<Tasks> tempList = [];
              List<Tasks> removeList = [];
              tempList = _blockTaskListF;

              for (var task in tempList) {
                if (AppUrl.roleId == AppUrl.mRoleWorker) {
                  if (task.canViewWorker == 0) {
                    removeList.add(task);
                  }
                } else if (AppUrl.roleId == AppUrl.mRoleStateHead) {
                  if (task.canViewSh == 0) {
                    removeList.add(task);
                  }
                } else if (AppUrl.roleId == AppUrl.mRoleMP) {
                  if (task.canViewMp == 0) {
                    removeList.add(task);
                  }
                } else if (AppUrl.roleId == AppUrl.mRoleMLA) {
                  if (task.canViewMla == 0) {
                    removeList.add(task);
                  }
                }
              }
              if (removeList.isNotEmpty) {
                for (var nation in removeList) {
                  _blockTaskListF.remove(nation);
                }
              }
            }
          }

          _blockTaskList = _blockTaskListF;
          _nationalTaskList = _nationalTaskListF;
          _stateTaskList = _stateTaskListF;
          _districttTaskList = _districttTaskListF;
          if(_nationalTaskList.isNotEmpty){
            initialIndex = 0;
          }else if(_stateTaskList.isNotEmpty){
            initialIndex = 1;
          }else if(_districttTaskList.isNotEmpty){
            initialIndex = 2;
          }else if(_blockTaskList.isNotEmpty){
            initialIndex = 3;
          }else{
            initialIndex = 0;
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

  filterTask(int tabType, List<String> list){
    switch (tabType){
      case 0:
        if(list.isEmpty){
          _nationalTaskList = _nationalTaskListF;
        }else{
          _nationalTaskList = [];
          for(var d in list){
            _nationalTaskList.addAll(_nationalTaskListF.where((e)=>e.socialType.toString().toUpperCase() == d.toUpperCase()));
          }
        }
        break;

      case 1:
        if(list.isEmpty){
          _stateTaskList = _stateTaskListF;
        }else{
          _stateTaskList = [];
          for(var d in list){
            _stateTaskList.addAll(_stateTaskListF.where((e)=>e.socialType.toString().toUpperCase() == d.toUpperCase()));
          }
        }
        break;

      case 2:
        if(list.isEmpty){
          _districttTaskList = _districttTaskListF;
        }else{
          _nationalTaskList = [];
          for(var d in list){
            _nationalTaskList.addAll(_districttTaskListF.where((e)=>e.socialType.toString().toUpperCase() == d.toUpperCase()));
          }
        }
        break;

      case 3:
        if(list.isEmpty){
          _blockTaskList = _blockTaskListF;
        }else{
          _blockTaskList = [];
          for(var d in list){
            _blockTaskList.addAll(_blockTaskListF.where((e)=>e.socialType.toString().toUpperCase() == d.toUpperCase()));
          }
        }
        break;
    }
    notifyListeners();
  }


  Future postSocialPoint(String type,String id,int position,int workerType) async {
    _isLoading = true;
    // try {
    var body = {
      "api_token": AppUrl.apiToken,
      "clicked_time": DateTime.now().toString(),
      "platform": type,
      "points_status": "No",
      "task_list_id": id
    };

    http.Response response =
    await http.post(Uri.parse(AppUrl.postSocialPoint), body: body);

    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status_code'] == 200) {
        if(workerType == 1){
          //_nationalTaskList[position].isShared = true;
          _nationalTaskList[position].showDone = 1;
        }else if(workerType ==2){
         // _stateTaskList[position].isShared = true;
          _stateTaskList[position].showDone = 1;

        }else if(workerType == 3){
         // _districttTaskList[position].isShared = true;
          _districttTaskList[position].showDone = 1;
        }else{
         // _blockTaskList[position].isShared = true;
          _blockTaskList[position].showDone = 1;
        }
        CommonResponse commonResponse = CommonResponse.fromJson(jsonDecode(response.body));
        _isLoading = false;
        notifyListeners();
      }else if(jsonDecode(response.body)['status_code'] == 400){
        if(workerType == 1){
         // _nationalTaskList[position].isShared = true;
          _nationalTaskList[position].showDone = 1;
        }else if(workerType ==2){
         // _stateTaskList[position].isShared = true;
          _stateTaskList[position].showDone = 1;
        }else if(workerType == 3){
         // _districttTaskList[position].isShared = true;
          _districttTaskList[position].showDone = 1;
        }else{
         // _blockTaskList[position].isShared = true;
          _blockTaskList[position].showDone = 1;
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
  Future markTaskDone(String type,String id,int position,int workerType) async {
    _isLoading = true;
    // try {
    var body = {
      "api_token": AppUrl.apiToken,
      "platform": type,
      "shared_post_url": "",
      "task_list_id": id
    };

    http.Response response =
    await http.post(Uri.parse(AppUrl.markTaskDone), body: body);
    Utils.printConsoleData(AppUrl.markTaskDone);
    Utils.printConsoleData(body.toString());
    Utils.printConsoleData(response.body);

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status_code'] == 200) {
        if(workerType == 1){
          _nationalTaskList.removeAt(position);
        }else if(workerType ==2){
          _stateTaskList.removeAt(position);
        }else if(workerType == 3){
          _districttTaskList.removeAt(position);
        }else{
          _blockTaskList.removeAt(position);
        }
        CommonResponse commonResponse = CommonResponse.fromJson(jsonDecode(response.body));
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


  final Dio _dio = Dio();

  Future<bool> downloadFile(String url, String value) async {
    // Request storage permissions
    bool isDone = false;
    if(url.isNotEmpty) {
      PermissionStatus status = await Permission.manageExternalStorage
          .request();
      if (status.isGranted) {
        String timeStamp = DateTime
            .now()
            .millisecondsSinceEpoch
            .toString();
        Directory? downloadsDirectory = await getExternalStorageDirectory();

        if (downloadsDirectory != null) {
          Directory? downloadsDirectory;
          if (Platform.isAndroid) {
            downloadsDirectory = Directory('/storage/emulated/0/Download');
          } else {
            downloadsDirectory = await getDownloadsDirectory();
          }
          String filePath = "";
          if (url.contains("mp4")) {
            filePath = "${downloadsDirectory!.path}/$timeStamp.mp4";
          } else {
            filePath = "${downloadsDirectory!.path}/$timeStamp.jpg";
          }


          final file = File(filePath);
          await file.create(recursive: true);
          print(AppUrl.BASE_SOCIAL_MEDIAATTACHMENT_W + url);
          try {
            _isLoading = true;
            notifyListeners();
            await _dio.download(
              AppUrl.BASE_SOCIAL_MEDIAATTACHMENT_W + url.replaceAll(" ", ""),
              filePath,
              onReceiveProgress: (received, total) {
                // setState(() {
                //   _progress = received / total;
                // });
              },
            );
            _isLoading = false;
            notifyListeners();
            Utils.toastMessage("Download completed! File saved");
            // if(type == "Share"){
            ShareResult sh = await Share.shareXFiles(
                [XFile(filePath)], text: value);

            isDone = true;
            //}
            //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Download completed! File saved at $savePath")));
          } catch (e) {
            _isLoading = false;
            notifyListeners();
            Utils.toastMessage("Error downloading file");
          }
         // Utils.toastMessage("Error downloading file: ");
          _isLoading = false;
          notifyListeners();
        }
      } else if (status.isDenied) {
        await Permission.manageExternalStorage.request();
      } else {
        openAppSettings();
      }
    }else{
      isDone = true;
      Share.share(value);
    }
    return isDone;
  }
}
