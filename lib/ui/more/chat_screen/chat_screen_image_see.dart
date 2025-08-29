import 'dart:io';
import 'dart:typed_data';
import 'package:digitalsaathi/constants/components/pro_text.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';


class ChatScreenImageSee extends StatefulWidget {
  final String image;
  final String userName ;
  const ChatScreenImageSee({super.key, required this.image, required this.userName});

  @override
  State<ChatScreenImageSee> createState() => _ChatScreenImageSeeState();
}

class _ChatScreenImageSeeState extends State<ChatScreenImageSee> {
  ScreenshotController screenshotController = ScreenshotController();

  Future<void> saveFile(Uint8List bytes, String type) async {
    PermissionStatus status = await Permission.manageExternalStorage.request();

    if (status.isGranted) {
      String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      Directory? targetDirectory;

      if (Platform.isAndroid) {
        targetDirectory = Directory('/storage/emulated/0/Download');
      } else if (Platform.isIOS) {
        targetDirectory = await getTemporaryDirectory();
      } else {
        targetDirectory = await getDownloadsDirectory();
      }

      if (targetDirectory != null) {
        if (!await targetDirectory.exists()) {
          await targetDirectory.create(recursive: true);
        }

        final filePath = "${targetDirectory.path}/$timeStamp.jpg";
        final file = File(filePath);

        try {
          await file.writeAsBytes(bytes.toList());

          if (type == "Share") {
            await Share.shareXFiles([XFile(file.path)], text: "");
          } else {
            bool? isSaved = await GallerySaver.saveImage(filePath);
            if (isSaved == true) {
              Utils.toastMessage("Image saved to gallery!");
            } else {
              Utils.toastMessage("Failed to save image.");
            }
          }
        } catch (e) {
          print("Error saving/sharing file: $e");
          Utils.toastMessage("An error occurred: $e");
        }
      } else {
        Utils.toastMessage("Could not access a suitable directory.");
        print("Could not access a suitable directory.");
      }
    } else if (status.isDenied) {
      Utils.toastMessage("Permission denied to access storage.");
      await Permission.manageExternalStorage.request();
    } else if (status.isPermanentlyDenied) {
      Utils.toastMessage("Storage permission permanently denied. Please enable from settings.");
      openAppSettings();
    }
  }

  Future<void> _saveImageToGallery() async {
    try {
      File imageFile = File(widget.image);
      if (await imageFile.exists()) {
        Uint8List bytes = await imageFile.readAsBytes();
        await saveFile(bytes, "Download");
      } else {
        Utils.toastMessage("Image file not found.");
      }
    } catch (e) {
      print("Error saving image: $e");
      Utils.toastMessage("Failed to save image.");
    }
  }

  Future<void> _shareImage() async {
    try {
      File imageFile = File(widget.image);
      if (await imageFile.exists()) {
        Uint8List bytes = await imageFile.readAsBytes();
        await saveFile(bytes, "Share");
      } else {
        Utils.toastMessage("Image file not found.");
      }
    } catch (e) {
      print("Error sharing image: $e");
      Utils.toastMessage("Failed to share image.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 45,
            width: 45,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorUtils.colorWhite.withOpacity(0.3),
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios,
                color: ColorUtils.colorWhite,
              ),
            ),
          ),
        ),
        title: CommonKhandText(
          title: widget.userName,
          textColor: Color(0xffffffff),
          fontWeight: FontWeight.w300,
          fontSize: 17,
        ),
        centerTitle: true,
        backgroundColor: Color(0xff28B3D5),
        surfaceTintColor: Color(0xff28B3D5),
        automaticallyImplyLeading: false,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.share, color: ColorUtils.colorWhite),
          //   onPressed: _shareImage,
          // ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
                onTap: _shareImage,
                child: Image(image: AssetImage('assets/profile_images/share.png'),height: 30,)),
          ),
          IconButton(
            icon: Icon(Icons.save_alt, color: ColorUtils.colorWhite),
            onPressed: _saveImageToGallery,
          ),
        ],
      ),
      body: Container(
        height: screenHeight(context),
        width: screenWidth(context),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.112, 0.789, 1.0],
            colors: [
              Color(0xFF000000), // Black
              Color(0xFF3F3D3D), // Dark Grey
              Color(0xFF606060), // Medium Grey
            ],
          ),
        ),
        child: Center(
          child: Image.file(
            File(widget.image),
            fit: BoxFit.contain,
          ),
        )
      ),
    );
  }
}