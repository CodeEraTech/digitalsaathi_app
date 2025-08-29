import 'dart:io';
import 'dart:typed_data';

import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/constants/components/pro_text.dart';
import 'package:digitalsaathi/provider/profile_provider.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../provider/theme_provider.dart';
import '../../../utils/color_utils.dart';
class IdCard extends StatefulWidget {
  const IdCard({super.key});

  @override
  State<IdCard> createState() => _IdCardState();
}

class _IdCardState extends State<IdCard> {

  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<ProfileProvider>(context,listen: false).getMemberId();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.darkTheme ?  ColorUtils.colorBlack: ColorUtils.lightTheme,
      appBar: AppBar(
        surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorBlack :  ColorUtils.appBarColor ,
        backgroundColor: themeProvider.darkTheme ? ColorUtils.colorBlack :  ColorUtils.appBarColor ,
        centerTitle: true,
        elevation: 4,
        leading: Container(
          height: 30,
          width: 30,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              shape: BoxShape.circle
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Center(  // Center the Icon widget here
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title:  const CommonKhandText(
          title: "Member ID Card",
          textColor: Color(0xffffffff),
          fontWeight: FontWeight.w300,
          fontSize: 17,
        ),
        actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                  onTap: (){

                    screenshotController
                        .capture(
                        delay: Duration(milliseconds: 10))
                        .then((capturedImage) async {
                      saveFile(capturedImage!,"Share");
                    });
                  },
                  child: const Image(
                    image: AssetImage(AssetUtils.shareIconWhite),
                    height: 30,)
              ),
            )
        ],
      ),
      body: Consumer<ProfileProvider>(
        builder: (context,profileProvider,_) {
          return Container(
            padding: const EdgeInsets.only(left: 10,right: 10),
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
            child: Stack(
              children: [
                profileProvider.cardData != null?Column(
                  children: [
                    verticalSpace(15),
                    Screenshot(
                      controller: screenshotController,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Card(
                            elevation: 3,
                            margin: EdgeInsets.zero,
                            child: Container(
                              padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image:  DecorationImage(
                                    image: AssetImage(AssetUtils.screenBackgroundFour),
                                    fit: BoxFit.fill
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 200,
                                        width: 120,
                                        decoration:   BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(AssetUtils.idCard),
                                              fit: BoxFit.fill
                                          ),
                                        ),
                                        child: Container(
                                          margin: const EdgeInsets.fromLTRB(9,65,11,9),
                                          decoration:  BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            image: DecorationImage(
                                                image: profileProvider.cardData!.userProfilePicture.toString().isEmpty ?AssetImage(AssetUtils.screenBackgroundThree):NetworkImage(AppUrl.BASE_IMAGE_URL+profileProvider.cardData!.userProfilePicture),
                                                fit: BoxFit.cover
                                            ),
                                          ),
                                        ),
                                      ),
                                      horizontalSpace(10),
                                      Expanded(
                                        // flex: 2,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 15),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: CommonKhandText(
                                                  title: "Digital Saathi",
                                                  textColor: Color(0xffffffff),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              verticalSpace(15),
                                              CommonKhandText(
                                                title: "नामः ${profileProvider.cardData!.firstName}",
                                                textColor: Color(0xffffffff),
                                                // fontWeight: FontWeight.w300,
                                                fontSize: 16,
                                              ),
                                              CommonKhandText(
                                                title: "विधानसभाः ${profileProvider.cardData!.assemblyName}",
                                                textColor: Color(0xffffffff),
                                                // fontWeight: FontWeight.w300,
                                                fontSize: 16,
                                              ),
                                              CommonKhandText(
                                                title: "फ़ोन नं.: ${profileProvider.cardData!.mobile}",
                                                textColor: Color(0xffffffff),
                                                // fontWeight: FontWeight.w300,
                                                fontSize: 16,
                                              ),
                                              CommonKhandText(
                                                title: "बूथ: ${profileProvider.cardData!.boothNumber}",
                                                textColor: Color(0xffffffff),
                                                // fontWeight: FontWeight.w300,
                                                fontSize: 16,
                                              ),
                                              CommonKhandText(
                                                title: "पद: ${profileProvider.cardData!.workerCategory}",
                                                textColor: Color(0xffffffff),
                                                // fontWeight: FontWeight.w300,
                                                fontSize: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),


                          // const Padding(
                          //   padding: EdgeInsets.only(top: 5),
                          //   child: CommonKhandText(
                          //     title: "Digital Saathi",
                          //     textColor: Color(0xffffffff),
                          //     fontWeight: FontWeight.w500,
                          //     fontSize: 19,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    verticalSpace(10),
                  ],
                ):
                const SizedBox.shrink(),

                profileProvider.isLoading?const CustomLoader():SizedBox.shrink()
              ],
            ),
          );
        }
      ),
    );
  }

  saveFile(Uint8List bytes,String type) async{
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
        Directory? downloadsDirectory;
        if (Platform.isAndroid) {
          downloadsDirectory = Directory('/storage/emulated/0/Download');
        } else {
          downloadsDirectory = await getDownloadsDirectory();
        }
        final filePath = "${downloadsDirectory!.path}/$timeStamp.jpg";
        final file = File(filePath);

        // Ensure the directory exists
        await file.create(recursive: true);

        // Write the file data
        await file.writeAsBytes(bytes.toList());

        if(type == "Share") {
          Share.shareXFiles([XFile(file.path)],);
        }else{
          Utils.toastMessage("File Downloaded");
        }

      } else {
        print("Could not access the Downloads directory.");
      }

      // Directory root = await getTemporaryDirectory();
      // String directoryPath = '${root.path}/digital';
      // // Create the directory if it doesn't exist
      // await Directory(directoryPath).create(recursive: true);
      // String filePath = '$directoryPath/$timeStamp.jpg';
      // print(filePath);
      // final file = await File(filePath).writeAsBytes(bytes.toList());
      // path = file.path;
      // } catch (e) {
      //   debugPrint(e.toString());
      // }
    }else if(status.isDenied){
      await Permission.manageExternalStorage.request();
    }else{
      openAppSettings();
    }
    return path;
  }

}
