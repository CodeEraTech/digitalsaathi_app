import 'dart:io';
import 'dart:typed_data';

import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/constants/components/pro_text.dart';
import 'package:digitalsaathi/data/model/poster_list_response.dart';
import 'package:digitalsaathi/ui/more/poster/poster_font_size_adjuster/FontSizeController.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:digitalsaathi/utils/prefrence/pref_utils.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get/get.dart';
class PosterDataUi extends StatefulWidget {
  final PosterData posterData;
  final DefaultProfile defaultProfile;
  final Function likeFunction;
  final Function commentFunction;
  final VoidCallback shareFunction;
  final Widget like;
  final Widget share;
  final Widget comment;
  final int type;



  const PosterDataUi(
      {super.key,
      required this.posterData,
      required this.defaultProfile,
      required this.likeFunction,
      required this.commentFunction,
      required this.shareFunction,
      required this.like,
      required this.share,
      required this.type,
      required this.comment});

  @override
  State<PosterDataUi> createState() => _PosterDataUiState();
}

class _PosterDataUiState extends State<PosterDataUi> {
  ScreenshotController screenshotController = ScreenshotController();
  final FontSizeController controller = Get.put(FontSizeController());


  @override
  Widget build(BuildContext context) {


    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Container(
        width: screenWidth(context),
        decoration: const BoxDecoration(
          color: Colors.white,
          //image: DecorationImage(image: AssetImage(AssetUtils.bgCardFour),fit: BoxFit.fill),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                // background image ui
                // then top opacity ui
                // user poster ui

                // Data ui
                Column(
                  children: [
                    Screenshot(
                      controller: screenshotController,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Container(
                                    height: 350,
                                   // margin: EdgeInsets.only(bottom: 25),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10)),
                                      child: widget.posterData.eventPhotos.isNotEmpty
                                          ? Image.network(
                                              fit: BoxFit.fill,
                                              AppUrl.BASE_POSTER_URL +
                                                  widget.posterData
                                                      .eventPhotos[0].photoName)
                                          : SizedBox(),
                                    ),
                                  ),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Obx(() {
                                        final double fontSizeName = controller.tempFontSizeName.value;
                                        final double fontSizeDesignation = controller.tempFontSizeDesignation.value;
                                        double bottomMargin = 3;
                                        switch (fontSizeName.round()) {
                                          case 15:
                                            bottomMargin = 4;
                                            break;
                                          case 16:
                                            bottomMargin = 5;
                                            break;
                                          case 17:
                                            bottomMargin = 6;
                                            break;
                                          case 18:
                                            bottomMargin = 7;
                                            break;
                                          case 19:
                                            bottomMargin = 8;
                                            break;
                                          case 20:
                                            bottomMargin = 10;
                                            break;
                                          case 21:
                                            bottomMargin =11;
                                            break;
                                          case 22:
                                            bottomMargin = 12;
                                            break;
                                          case 23:
                                            bottomMargin = 13;
                                            break;
                                          case 24:
                                            bottomMargin = 14;
                                            break;
                                          case 25:
                                            bottomMargin = 15;
                                            break;
                                          default:
                                            bottomMargin = 3; // fallback
                                        }

                                        switch (fontSizeDesignation.round()) {
                                          case 21:
                                            bottomMargin = 20;
                                            break;
                                          case 22:
                                            bottomMargin = 21;
                                            break;
                                          case 23:
                                            bottomMargin = 22;
                                            break;
                                          case 24:
                                            bottomMargin = 23;
                                            break;
                                          case 25:
                                            bottomMargin = 24;
                                            break;
                                        }

                                        return Visibility(
                                          visible: widget.defaultProfile.designation.toString().isNotEmpty,
                                          child: Container(
                                            // margin: EdgeInsets.fromLTRB(35, 0, 90, 0),
                                            margin:  EdgeInsets.fromLTRB(35, 3, 90, bottomMargin),
                                            padding: EdgeInsets.only(bottom: 4),
                                            width: screenWidth(context),
                                            alignment: Alignment.topCenter,
                                            decoration: BoxDecoration(
                                                color: ColorUtils.orangeAccent,
                                                borderRadius:
                                                BorderRadius.circular(50)),
                                            child: Container(
                                                alignment: Alignment.centerRight,
                                                margin: EdgeInsets.only(right: 30),
                                                child: Obx(() =>CommonKhandText(
                                                  title: widget.defaultProfile.name,
                                                  textAlign: TextAlign.start,
                                                  textColor: ColorUtils.colorWhite,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: controller.isEditing.value
                                                      ? controller.tempFontSizeName.value
                                                      : controller.tempFontSizeName.value,
                                                  // fontSize: controller.isEditing.value
                                                  //     ? controller.tempFontSizeName.value
                                                  //     : controller.fontSizeName.value,
                                                ),)
                                            ),
                                          ),
                                        );
                                      },),
                                      Visibility(
                                        visible: widget.defaultProfile.designation.toString().isNotEmpty,
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            margin:
                                            EdgeInsets.fromLTRB(20, 40, 90, 0),
                                            padding:
                                            EdgeInsets.only(bottom: 1),
                                            width: screenWidth(context),
                                            alignment: Alignment.bottomCenter,
                                            decoration: BoxDecoration(
                                                color: ColorUtils.colorGreen,
                                                borderRadius:
                                                BorderRadius.circular(50)
                                            ),
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              margin: EdgeInsets.only(right: 30),
                                              child:  Obx(() =>CommonKhandText(
                                                title: widget.defaultProfile.designation,
                                                textAlign: TextAlign.start,
                                                textColor: ColorUtils.colorWhite,
                                                fontWeight: FontWeight.w300,
                                                fontSize: controller.isEditing.value
                                                    ? controller.tempFontSizeDesignation.value
                                                    : controller.tempFontSizeDesignation.value,
                                              ),)
                                            ),
                                          ),
                                        ),
                                      ),
                                      widget.defaultProfile.profileImg.isEmpty
                                          ? SizedBox.shrink()
                                          : Align(
                                        alignment: Alignment.centerRight,
                                        child: widget.type==0?Container(
                                          margin: EdgeInsets.only(
                                              bottom: 1, right: 5),
                                          height: 100,
                                          width: 110,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                  ColorUtils.colorWhite,
                                                  width: 2),
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(widget
                                                      .defaultProfile
                                                      .profileImg),
                                                  fit: BoxFit.fill)),
                                        ):Container(
                                          margin: EdgeInsets.only(
                                              bottom: 1, right: 5),
                                          height: 100,
                                          width: 110,
                                          child: Image.network(widget
                                              .defaultProfile
                                              .profileImg,
                                              fit: BoxFit.fill),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: 100 ,
                                  margin: EdgeInsets.only(left: 6,right: 6),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                            widget.defaultProfile.leaders.length,
                                            itemBuilder: (context, index) {
                                              Leaders leader = widget.defaultProfile.leaders[index];
                                              return Container(
                                                height: index==0?30:25,
                                                width: index==0?40:35,
                                                transform: Matrix4.translationValues(0.0, -25.0, 0.0),
                                                margin: EdgeInsets.only(right: 2),
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                    border: Border.all(
                                                        color: ColorUtils.colorBlack,
                                                        width: 1),
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: NetworkImage(leader.image),
                                                        fit: BoxFit.contain)),
                                              );
                                            }),
                                      ),
                                      widget.defaultProfile.symbols.isNotEmpty?Container(
                                        height: 30,
                                        width: 30,
                                        transform: Matrix4.translationValues(0.0, -25.0, 0.0),
                                        margin: EdgeInsets.only(right: 2),
                                        padding: EdgeInsets.all(2),

                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            border: Border.all(
                                                color: ColorUtils.colorBlack,
                                                width: 1),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(widget.defaultProfile.symbols[0].image),
                                                fit: BoxFit.contain)),

                                      ):SizedBox.shrink()
                                    ],
                                  ),
                                ),
                              ),



                            ],
                          ),

                          Visibility(
                            visible: false,
                            child: Container(
                             // color: ColorUtils.primaryColor,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(AssetUtils.bgCardThree),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [


                                  Visibility(
                                    visible: false,
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                                        alignment: Alignment.bottomCenter,
                                        decoration: BoxDecoration(
                                            color: ColorUtils.colorWhite,

                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Visibility(
                                              visible: true,
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Row(
                                                  children: [
                                                    const Image(
                                                      image: AssetImage(
                                                          AssetUtils.Facebook),
                                                      height: 15,
                                                    ),
                                                    horizontalSpace(5),
                                                    CommonKhandText(
                                                      title: widget.defaultProfile
                                                          .facebook,
                                                      textAlign: TextAlign.start,
                                                      textColor:
                                                      ColorUtils.errorColor,
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                                visible: true,
                                                child: verticalSpace(10)),
                                            Visibility(
                                              visible: true,
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Row(
                                                  children: [
                                                    const Image(
                                                      image: AssetImage(
                                                          AssetUtils.Whatsapp),
                                                      height: 15,
                                                    ),
                                                    horizontalSpace(8),
                                                    CommonKhandText(
                                                      title: widget.defaultProfile
                                                          .whatsapp,
                                                      textColor:
                                                      ColorUtils.errorColor,
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                                visible: true,
                                                child: verticalSpace(10)),
                                            Visibility(
                                              visible: true,
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Row(
                                                  children: [
                                                    const Image(
                                                      image: AssetImage(
                                                          AssetUtils.Twitter),
                                                      height: 15,
                                                    ),
                                                    horizontalSpace(8),
                                                    CommonKhandText(
                                                      title: widget
                                                          .defaultProfile.twitter,
                                                      textColor:
                                                      ColorUtils.errorColor,
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),




                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 14, right: 14, bottom: 10),
                      // margin: const EdgeInsets.only(top: 220),
                      width: screenWidth(context),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AssetUtils.bgCardThree),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 25,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: widget.posterData.mla_image
                                                .isEmpty
                                            ? AssetImage(AssetUtils.profilePng)
                                            : NetworkImage(AppUrl.BASE_IMAGE_URL+widget
                                                .posterData.mla_image.toString()),
                                        fit: BoxFit.fill)),
                              ),
                              horizontalSpace(15),
                              Container(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CommonKhandText(
                                      title: widget.posterData.mla_name,
                                      textColor: const Color(0xffffffff),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                    CommonKhandText(
                                      title: widget.posterData.createdAt,
                                      textColor: const Color(0xffffffff),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              // InkWell(
                              //   onTap: (){
                              //     screenshotController
                              //         .capture(
                              //         delay: Duration(milliseconds: 10))
                              //         .then((capturedImage) async {
                              //       saveFile(capturedImage!,"Download");
                              //     });
                              //   },
                              //   child: Container(
                              //     height: 44,
                              //     width: 45,
                              //     decoration: const BoxDecoration(
                              //       shape: BoxShape.circle,
                              //     ),
                              //     child: const Center(
                              //       child: Icon(
                              //         Icons.arrow_circle_down_sharp,
                              //         color: const Color(0xffffffff),
                              //         size: 20,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  widget.likeFunction();
                                },
                                child: Row(
                                  children: [
                                    // const Image(image: AssetImage(AssetUtils.FBLikeButton),height: 20,),
                                    Icon(
                                      widget.posterData.isLikeStatus == "0"
                                          ? Icons.favorite_outline
                                          : Icons.favorite,
                                      color:
                                          widget.posterData.isLikeStatus == "0"
                                              ? Colors.white
                                              : Colors.red,
                                      size: 20,
                                    ),
                                    horizontalSpace(5),
                                    widget.like,
                                    const CommonKhandText(
                                      title: " Like",
                                      textColor: const Color(0xffffffff),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.commentFunction();
                                },
                                child: Row(
                                  children: [
                                    const Image(
                                      image: AssetImage(AssetUtils.CommentIcon),
                                      height: 20,
                                    ),
                                    horizontalSpace(5),
                                    widget.comment,
                                    const CommonKhandText(
                                      title: " Comment",
                                      textColor: Color(0xffffffff),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {

                                  screenshotController
                                      .capture(
                                          delay: Duration(milliseconds: 10))
                                      .then((capturedImage) async {
                                        saveFile(capturedImage!,"Share");
                                   });

                                },
                                child: Row(
                                  children: [
                                    const Image(
                                      image:
                                          AssetImage(AssetUtils.shareIconWhite),
                                      height: 20,
                                    ),
                                    //horizontalSpace(5),
                                    const CommonKhandText(
                                      title: "Share",
                                      textColor: const Color(0xffffffff),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {

                                  screenshotController
                                      .capture(
                                      delay: Duration(milliseconds: 10))
                                      .then((capturedImage) async {
                                    saveFile(capturedImage!,"Download");
                                  });

                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.arrow_circle_down_sharp,
                                      color: const Color(0xffffffff),
                                      size: 20,
                                    ),
                                    //horizontalSpace(5),
                                    const CommonKhandText(
                                      title: "Download",
                                      textColor: const Color(0xffffffff),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // social media ui facebook,Instagram,whatsapp,twitter
              ],
            ),
          ],
        ),
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
          GallerySaver.saveImage(filePath);

          if(type == "Share") {
            Share.shareXFiles([XFile(file.path)], text: "");
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
