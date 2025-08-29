import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/data/app_excaptions.dart';
import 'package:digitalsaathi/data/model/common_response.dart';
import 'package:digitalsaathi/data/model/content_post_model.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ContentProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;




  List<ContentData> imageContent = [];
  List<ContentData> videoContent = [];
  Future getAllContent() async
  {
    _isLoading = true;
    // try {

    var body = {
      "api_token":
          AppUrl.apiToken,

    };

    http.Response response =
        await http.post(Uri.parse(AppUrl.getContent), body: body);

    Utils.printConsoleData(AppUrl.getContent);
    Utils.printConsoleData(body.toString());
    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {
        ContentPostModel contentPostModel =
        ContentPostModel.fromJson(jsonDecode(response.body));

        imageContent =contentPostModel.data!.where((element)=>element.type == "image").toList();
        imageContent = imageContent.where((e)=>e.postUrl != null).toList();
        videoContent =contentPostModel.data!.where((element)=>element.type != "image").toList();
        videoContent = videoContent.where((e)=>e.postUrl != null).toList();
        _isLoading = false;
        notifyListeners();
      } else if (jsonDecode(response.body)['status'] == 400) {
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

  void shareContentInit(String imageUrl,String id,int index,String contentType) async {
    _isLoading = true;
    notifyListeners();
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {

      String path =   await saveFile(response.bodyBytes,contentType);

      if(path.isNotEmpty){
        final xFile = XFile(path);
        await Share.shareXFiles([xFile],);
        shareContent(id, "share", index,contentType);
      }

    } else {
      _isLoading = false;
      notifyListeners();
      print("Failed to download image for sharing");
    }
  }

  Future<void> downloadImage(String imageUrl, String postId,int index,String contentType) async {
    print(imageUrl);
    _isLoading = true;
    notifyListeners();
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      _isLoading = false;
      notifyListeners();
      String path =   await saveFile(response.bodyBytes,contentType);

      if(path.isNotEmpty){
        shareContent(postId, "download", index,contentType);
      }

    } else {
      _isLoading = false;
      notifyListeners();
      print('Failed to download image: ${response.statusCode}');
      Utils.toastMessage("Failed to download image!!!");

    }
  }

  saveFile(Uint8List bytess,String type) async{
    String path = "";
    PermissionStatus status = await Permission.manageExternalStorage.request();
    if (status.isGranted == true) {

      String timeStamp = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      //try {
      // Access the Downloads directory
      Directory? downloadsDirectory = await getExternalStorageDirectory();

      if (downloadsDirectory != null) {
       // Directory? downloadsDirectory;
        if (Platform.isAndroid) {
          bool dirDownloadExists = true;
          downloadsDirectory = Directory('/storage/emulated/0/Download');

          String directory = "/storage/emulated/0/Download";

          dirDownloadExists = await Directory(directory).exists();
          if(dirDownloadExists){
            directory = "/storage/emulated/0/Download";
          }else{
            directory = "/storage/emulated/0/Downloads";
          }
          downloadsDirectory = Directory(directory);
        } else {
          downloadsDirectory = await getDownloadsDirectory();
        }
        final filePath = type=="video"?"${downloadsDirectory!.path}/$timeStamp.mp4":"${downloadsDirectory!.path}/$timeStamp.jpg";
        final file = File(filePath);

        // Ensure the directory exists
        await file.create(recursive: true);

        // Write the file data
        await file.writeAsBytes(bytess.toList());
        print(file.path);
        if(type=='video') {
          GallerySaver.saveVideo(filePath);
        }
        else {
          GallerySaver.saveImage(filePath);
        }
        path = filePath;


        Utils.toastMessage("File Downloaded");

      } else {
        print("Could not access the Downloads directory.");
      }

    }else if(status.isDenied){
      await Permission.manageExternalStorage.request();
    }else{
      openAppSettings();
    }
    return path;
  }

  // Function to add the downloaded file to the MediaStore (Gallery)
  Future<void> addToGallery(String filePath) async {
    try {
      final result = await MethodChannel('com.ebiz.digitalsaathi')
          .invokeMethod('addToGallery', {'filePath': filePath});
      print(result);
    } on PlatformException catch (e) {
      print("Failed to add to gallery: ${e.message}");
    }
  }

  Future shareContent(String id, String type,int index,String contentType) async
  {
    _isLoading = true;
    notifyListeners();
    // try {

    var body = {
      'api_token': AppUrl.apiToken,
      "post_id":"$id",
      "type":"$type"
    };

    http.Response response =
    await http.post(Uri.parse(AppUrl.shareContent), body: body);

    Utils.printConsoleData(AppUrl.getContent);
    Utils.printConsoleData(body.toString());
    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 200) {

        if(contentType == "image") {
          if (type == "share") {
            imageContent[index].share += 1;
          } else {
            imageContent[index].download += 1;
          }
        }else{
          if (type == "share") {
            videoContent[index].share += 1;
          } else {
            videoContent[index].download += 1;
          }
        }
        _isLoading = false;
        notifyListeners();
      } else if (jsonDecode(response.body)['status'] == 400) {
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


}
