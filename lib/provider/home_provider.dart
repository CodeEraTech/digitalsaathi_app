import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/data/app_excaptions.dart';
import 'package:digitalsaathi/data/model/notification_count_model.dart';
import 'package:digitalsaathi/data/model/poster_comment_response.dart';
import 'package:digitalsaathi/model/feedmodel.dart';
import 'package:digitalsaathi/ui/authentication_screen/login_screen.dart';
import 'package:digitalsaathi/ui/botttom_bar/bottom_nav_bar.dart';
import 'package:digitalsaathi/ui/home/widgets/ReelModel.dart';
import 'package:digitalsaathi/ui/home/widgets/ReelsCommentModel.dart';
import 'package:digitalsaathi/ui/home/widgets/utils/CommentBottomSheet.dart';
import 'package:digitalsaathi/utils/prefrence/pref_utils.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class HomeProvider with ChangeNotifier {

  List<ReelsData> _reelsData = [];
  Future getAllFeeds(context,{bool needUpadte = false}) async{
    if(needUpadte) {
      _reelsData = [];
    }
    var data = {"api_token":AppUrl.apiToken,"limit":"10","page":"1","search":""};

    http.Response response = await http.post(
        Uri.parse(AppUrl.getAllFeeds), body: data);

    Utils.printConsoleData(AppUrl.getAllFeeds);
   Utils.printConsoleData(response.body);
   Utils.printConsoleData(response.statusCode!.toString());
    if(response.statusCode == 200){
      if(jsonDecode(response.body)['status_code']==200) {
        FeedData feedData = FeedData.fromJson(jsonDecode(response.body));
        _reelsData = feedData.data;
        setReelData(feedData.data);
        notifyListeners();
      }else{
        Utils.toastMessage("Unauthorized");
        PrefUtils.setToken("");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      }
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
    }

    log(response.body);
  }
  List<ReelModel> reelsList = [];

  setReelData (List<ReelsData> data){
    reelsList = [];

    for(var d in data){
      List<ReelCommentModel> comment = [];
      for(int i=0;i< d.commentsCount;i++){
        comment.add(ReelCommentModel(comment: i.toString(), userProfilePic: "", userName: "", commentTime: DateTime.now()));
      }
      reelsList.add(
        ReelModel(
            d.eventPhotos.isEmpty?"":AppUrl.EVENT_URL+d.eventPhotos[0].photoName,
            d.name,
            d.userId,
            likeCount: d.likesCount,
            isLiked: d.isLikeStatus=="1"?true:false,
            musicName: 'In the name of Love',
            reelDescription: "${d.eventName}",
            profileUrl:
            AppUrl.BASE_IMAGE_URL+d.userProfilePicture,
            commentList: comment,
            imageurl: d.eventPhotos.isEmpty?[]:d.eventPhotos[0].photoName.contains("mp4")?[]:d.eventPhotos,
            isVideo: d.eventPhotos.isEmpty?false:d.eventPhotos[0].photoName.contains("mp4")?true:false,
      )
      );
    }
  }

  List<Comments> _posterComments = [];

  List<Comments> get posterComments => _posterComments;
  Future getPosterComments(BuildContext context,int position,String type) async {
    // try {
    isLoading = true;
    notifyListeners();
    var body = {"api_token":AppUrl.apiToken,"event_id":"${_reelsData[position].id.toString()}"};
    http.Response response =
    await http.post(Uri.parse(AppUrl.getPosterComment),body: body);

    Utils.printConsoleData(body.toString());
    Utils.printConsoleData(AppUrl.getPosterComment);
    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status_code'] == 200) {
        isLoading = false;
        notifyListeners();
        PosterCommentResponse posterCommentResponse = PosterCommentResponse.fromJson(jsonDecode(response.body));
        _posterComments = posterCommentResponse.comments;
        List<ReelCommentModel> _reelsCmnt = [];
        DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");

        for(var c in _posterComments){
          DateTime ct = format.parse(c.createdAt);
          _reelsCmnt.add(ReelCommentModel(comment: c.comment, userProfilePic: "", userName: c.firstName, commentTime: ct,id: c.comId.toString()));
        }
        reelsList[position].commentList = _reelsCmnt;
        if(type != "comment") {
          showModalBottomSheet(
              barrierColor: Colors.transparent,
              context: context,
              builder: (ctx) =>
                  CommentBottomSheet(
                    commentList: _reelsCmnt, position: position,)
          );
        }
        notifyListeners();
      } else {
        EasyLoading.showError(
            "${jsonDecode(response.body)['status_code']} - ${jsonDecode(response.body)['status_text']}");
        isLoading = false;
        notifyListeners();
      }
    } else {
      EasyLoading.showError("${response.statusCode}");
      isLoading = false;
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

  Future postComment(BuildContext context,int position,String comment) async {
    isLoading = true;
    notifyListeners();
    // try {

    var body = {"api_token":AppUrl.apiToken,"event_id":"${_reelsData[position].id.toString()}","comment":comment,"epic_ids":""};
    http.Response response =
    await http.post(Uri.parse(AppUrl.postComment),body: body);

    Utils.printConsoleData(body.toString());
    Utils.printConsoleData(AppUrl.postComment);
    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status_code'] == 200) {
       // _posterData[index].commentsCount += 1;
        isLoading = false;
        notifyListeners();
        getPosterComments(context,position,"comment").then((v){
          Navigator.pop(context);
        });
        //_isLoading = false;
      //  notifyListeners();
      } else {
        EasyLoading.showError(
            "${jsonDecode(response.body)['status_code']} - ${jsonDecode(response.body)['status_text']}");
       // _isLoading = false;
        isLoading = false;
        notifyListeners();
      }
    } else {
      EasyLoading.showError("${response.statusCode}");
     // _isLoading = false;
      isLoading = false;
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
  Future deleteComment(BuildContext context,String eventId,int position) async {
    isLoading = true;
    notifyListeners();
    // try {
    var body = {"api_token":AppUrl.apiToken,"event_comment_id":"$eventId",};
    http.Response response =
    await http.post(Uri.parse(AppUrl.deleteEventComment),body: body);

    Utils.printConsoleData(body.toString());
    Utils.printConsoleData(AppUrl.deleteEventComment);
    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status_code'] == 200) {
       // _posterData[index].commentsCount += 1;
        isLoading = false;
        notifyListeners();
        getPosterComments(context,position,"comment").then((v){
          Navigator.pop(context);
        });
        //_isLoading = false;
      //  notifyListeners();
      } else {
        EasyLoading.showError(
            "${jsonDecode(response.body)['status_code']} - ${jsonDecode(response.body)['message']}");
       // _isLoading = false;
        isLoading = false;
        notifyListeners();
      }
    } else {
      EasyLoading.showError("${response.statusCode}");
     // _isLoading = false;
      isLoading = false;
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

  Future posterLike(int position) async {
    // try {
    var body = {"api_token":AppUrl.apiToken,"event_id": "${_reelsData[position].id.toString()}","is_like":"${_reelsData[position].isLikeStatus=="1"?"0":"1"}"};
    http.Response response =
    await http.post(Uri.parse(AppUrl.posterLike),body: body);

    Utils.printConsoleData(body.toString());
    Utils.printConsoleData(AppUrl.posterLike);
    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status_code'] == 200) {
        reelsList[position].isLiked = !reelsList[position].isLiked;
        if(reelsList[position].isLiked) {
          reelsList[position].likeCount += 1;
        }else{
          reelsList[position].likeCount -= 1;
        }
        notifyListeners();
      } else {
        EasyLoading.showError(
            "${jsonDecode(response.body)['status_code']} - ${jsonDecode(response.body)['status_text']}");
        notifyListeners();
      }
    } else {
      EasyLoading.showError("${response.statusCode}");
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


  Future deleteFeed(int position,BuildContext context) async {
    // try {
    isLoading = true;
    notifyListeners();
    var body = {"api_token":AppUrl.apiToken,"event_id": "${_reelsData[position].id.toString()}",};
    http.Response response =
    await http.post(Uri.parse(AppUrl.deleteFeed),body: body);

    Utils.printConsoleData(body.toString());
    Utils.printConsoleData(AppUrl.deleteFeed);
    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status_code'] == 200) {
        //getAllFeeds(context,needUpadte: true);
       _reelsData.removeAt(position);
       setReelData(_reelsData);
       isLoading = false;

        notifyListeners();
      } else {
        EasyLoading.showError(
            "${jsonDecode(response.body)['status_code']} - ${jsonDecode(response.body)['message']}");
        isLoading = false;
        notifyListeners();
      }
    } else {
      EasyLoading.showError("${response.statusCode}");
      isLoading = false;
      notifyListeners();
    }


    // } on SocketException {
    //    isLoading = false;
    //   notifyListeners();
    //   throw FetchDataException('No Internet Connection');
    // }
    // catch (e) {
    //   EasyLoading.showError("Something went wrong. Please try again!!!");
    //   isLoading = false;
    //   notifyListeners();
    // }
  }

  bool isLoading = false;

  final Dio _dio = Dio();

  Future<void> downloadFile(String url, String type,int position) async {
    // Request storage permissions
    PermissionStatus status = await Permission.manageExternalStorage.request();
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
        if(url.contains("mp4")){
           filePath = "${downloadsDirectory!.path}/$timeStamp.mp4";
        }else{
           filePath = "${downloadsDirectory!.path}/$timeStamp.jpg";
        }


        final file = File(filePath);
        await file.create(recursive: true);
      try {
        isLoading = true;
        notifyListeners();
        await _dio.download(
          url,
          filePath,
          onReceiveProgress: (received, total) {
            // setState(() {
            //   _progress = received / total;
            // });
          },
        );
        isLoading = false;
        notifyListeners();
        Utils.toastMessage("Download completed! File saved");
        if(type == "Share"){
          Share.shareXFiles([XFile(filePath)], text: _reelsData[position].eventName);
        }
        //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Download completed! File saved at $savePath")));
      } catch (e) {
        isLoading = false;
        notifyListeners();
        Utils.toastMessage("Error downloading file");
      }
        Utils.toastMessage("Error downloading file: ");
        isLoading = false;
        notifyListeners();
      }
    } else if(status.isDenied){
      await Permission.manageExternalStorage.request();
    }else{
      openAppSettings();
    }
  }
  Future<void> createTimeLine(BuildContext context, String title, List<File> files) async {
    try {
      isLoading = true;
      notifyListeners();

      Map<String, String> data = {
        "api_token": AppUrl.apiToken,
        "title": title,
      };

      var request = http.MultipartRequest('POST', Uri.parse(AppUrl.createPost));
      request.fields.addAll(data);

      for (var file in files) {
        request.files.add(await http.MultipartFile.fromPath('abc[]', file.path));
      }

      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      var result = jsonDecode(respStr);

      if (response.statusCode == 200 && result["status_code"] == 200) {
        Utils.toastMessage(result["status_text"].toString());
        getAllFeeds(context);
      } else {
        Utils.toastMessage(result["status_text"]?.toString() ?? "Unknown error");
      }
    } catch (e, stack) {
      print("createTimeLine exception: $e\n$stack");
      Utils.toastMessage("Failed to post. Please try again.");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Future createTimeLine(BuildContext context,String title,List<File> files) async {
  //   isLoading = true;
  //   notifyListeners();
  //
  //   Map<String, String> data = {
  //     "api_token": AppUrl.apiToken,
  //     "title": "$title",
  //   };
  //   var request =  http.MultipartRequest(
  //       'POST', Uri.parse(AppUrl.createPost));
  //   request.fields.addAll(data);
  //   if(files.isNotEmpty){
  //     for(var f in files)
  //     {
  //       var multipartFile = await http.MultipartFile.fromPath(
  //           'abc[]', f.path); //returns a Future<MultipartFile>
  //       request.files.add(multipartFile);
  //     }
  //   }
  //   http.StreamedResponse response = await request.send();
  //   final respStr = await response.stream.bytesToString();
  //   var result = jsonDecode(respStr);
  //
  //   if (response.statusCode == 200) {
  //     if(result["status_code"] == 200){
  //       isLoading = false;
  //       getAllFeeds(context);
  //       // Navigator.pop(context);
  //       Utils.toastMessage(result["status_text"].toString());
  //       notifyListeners();
  //     }else{
  //       isLoading = false;
  //       Utils.toastMessage(result["status_text"].toString());
  //       notifyListeners();
  //     }
  //
  //   } else {
  //     isLoading = false;
  //     Utils.toastMessage(result["status_text"].toString());
  //     notifyListeners();
  //   }
  // }

///
  int unreadNotificationCount = 0;
  Future getNotificationCount() async {
    //_isLoading = true;
    // try {
    var body = {
      "api_token": AppUrl.apiToken,
      "user_id": "0",
    };

    http.Response response =
    await http.post(Uri.parse(AppUrl.unreadNotificationCount), body: body);

    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status_code'] == 200) {
        NotificationCountModel notificationCountModel = NotificationCountModel.fromJson(jsonDecode(response.body));
        unreadNotificationCount = notificationCountModel.data;
        notifyListeners();
      } else {
        EasyLoading.showError(
            "${jsonDecode(response.body)['status_code']} - ${jsonDecode(response.body)['status_text']}");
        notifyListeners();
      }
    } else {
      EasyLoading.showError("${response.statusCode}");
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