import 'dart:io';
import 'dart:typed_data';

import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/constants/components/my_TextField.dart';
import 'package:digitalsaathi/constants/components/pro_text.dart';
import 'package:digitalsaathi/provider/home_provider.dart';
import 'package:digitalsaathi/provider/theme_provider.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

// class CreateTimeLine extends StatefulWidget {
//
//   const CreateTimeLine({Key? key}) : super(key: key);
//
//   @override
//   State<CreateTimeLine> createState() => _CreateTimeLineState();
// }
//
// class _CreateTimeLineState extends State<CreateTimeLine> {
//   String groupValue = "image";
//   TextEditingController writePost = TextEditingController();
//   ImagePicker _imagePicker = ImagePicker();
//
//   List<File> _imageFile = [];
//   Uint8List? _videoThumbnail;
//   final FocusNode _focusNode = FocusNode();
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<HomeProvider>(
//       builder: (context,homeProvider,_) {
//         return Stack(
//           children: [
//             Container(
//               padding: EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                   color: ColorUtils.colorBlack,
//                 borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                           child: RadioListTile(
//                             selected: false,
//                             activeColor: ColorUtils.orangeAccent,
//                             groupValue: groupValue,
//                             title: Text(
//                               "Image",
//                               style: TextStyle(
//                                   color: ColorUtils.colorWhite,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             onChanged: (value) {
//                               onValueChange(value!);
//                               //authProvider.onRingTypeChange(value);
//                             },
//                             value: "image",
//                           )),
//                       Expanded(
//                           child: RadioListTile(
//                             selected: false,
//                             activeColor: ColorUtils.orangeAccent,
//                             groupValue: groupValue,
//                             title: Text(
//                               "Video",
//                               style: TextStyle(
//                                   color: ColorUtils.colorWhite,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             onChanged: (value) {
//                               onValueChange(value!);
//                               //authProvider.onRingTypeChange(value);
//                             },
//                             value: "video",
//                           )),
//                     ],
//                   ),
//                   verticalSpace(6),
//                   Container(
//                     height: 150,
//                     padding: EdgeInsets.fromLTRB(15, 0,15, 0),
//                     width: screenWidth(context),
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Colors.white.withOpacity(0.3)),
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.black
//                     ),
//                     child: MyTextField(
//                       maxLines: 50,
//                       focusNode: _focusNode,
//                       showBorders: false,
//                       controller: writePost,
//                       hintText: "Write...",
//                       keyboardType: TextInputType.multiline,
//                       textSize: 16.1,
//                     ),
//                   ),
//                   verticalSpace(10),
//                   Row(
//                     children: [
//                       InkWell(
//                         onTap: () async {
//                           if(groupValue == "image") {
//                           List<XFile> file = await _imagePicker.pickMultiImage(limit: 10, imageQuality: 20);
//                           if(file.isNotEmpty){
//                             _imageFile.clear();
//                             for(var f in file){
//                               _imageFile.add(File(f.path));
//
//                             }
//                             setState(() {
//
//                             });
//                           }
//                           }else{
//                             XFile? file = await _imagePicker.pickVideo(source: ImageSource.gallery);
//                             if(file != null){
//                               _imageFile.clear();
//                                 _imageFile.add(File(file.path));
//                               _videoThumbnail = await VideoThumbnail.thumbnailData(
//                                 video: _imageFile[0].path,
//                                 imageFormat: ImageFormat.JPEG,
//                                 maxWidth: 128, // specify the width of the thumbnail, can be adjusted
//                                 quality: 25,
//                               );
//                               setState(() {
//
//                               });
//                             }
//                           }
//                         },
//                         child: Card(
//                           child: Container(
//                             padding: EdgeInsets.all(15),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(color: ColorUtils.primaryColor,width: 3)
//                             ),
//                             child: Icon(Icons.upload_file,color: ColorUtils.primaryColor,size: 30,),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(left: 4,right: 6),
//                         height: 65,
//                         width: 2,
//                         color: ColorUtils.colorWhite,
//                       ),
//
//                       groupValue=="image"?
//                       Expanded(child: Container(
//                         height: 65,
//                         child: ListView.separated(
//                           separatorBuilder: (context,index){
//                             return SizedBox(width: 6,);
//                           },
//                             shrinkWrap: true,
//                             itemCount: _imageFile.length,
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context,index){
//                               return Container(
//                                 height: 65,width: 65,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(color: ColorUtils.primaryColor,width: 2)
//                                 ),
//                                 child: Stack(
//                                   children: [
//
//                                     ClipRRect(
//                                       borderRadius: BorderRadius.circular(12),
//                                       child: Image.file(_imageFile[index],height: 65,width:65,fit: BoxFit.fill,),
//                                     ),
//
//                                     InkWell(
//                                       onTap:(){
//
//                                         _imageFile.removeAt(index);
//                                         setState(() {
//
//                                         });
//                               },
//                                       child: Container(
//                                         transform: Matrix4.translationValues(6.0, -13.0, 0.0),
//                                         child: Align(
//                                           alignment: Alignment.topRight,
//                                             child: Icon(Icons.cancel,color: ColorUtils.errorColor,)),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               );
//                             }),
//                       )):
//                       _videoThumbnail != null?Container(
//                         height: 65,width: 65,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: ColorUtils.primaryColor,width: 2)
//                         ),
//                         child: Stack(
//                           children: [
//
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(12),
//                               child: Image.memory(_videoThumbnail!,height: 65,width:65,fit: BoxFit.fill,),
//                             ),
//
//                             Container(
//                               transform: Matrix4.translationValues(6.0, -13.0, 0.0),
//                               child: Align(
//                                   alignment: Alignment.topRight,
//                                   child: Icon(Icons.cancel,color: ColorUtils.errorColor,)),
//                             )
//                           ],
//                         ),
//                       ):SizedBox.shrink()
//                     ],
//                   ),
//                   verticalSpace(30),
//                   Align(
//                     alignment: Alignment.center,
//                     child: GestureDetector(
//                       onTap:(){
//             homeProvider.createTimeLine(context, writePost.text.toString(), _imageFile);
//                       },
//                       child: Container(
//                         height: 50,
//                         width: screenWidth(context)*0.6,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black.withOpacity(0.1)),
//                           borderRadius: BorderRadius.circular(25),
//                           color: const Color(0xFF0093E9), // Solid background color
//                           gradient: const LinearGradient(
//                             begin: Alignment.topRight,
//                             end: Alignment.bottomLeft,
//                             colors: [
//                               Color(0xFF0093E9), // Starting color
//                               Color(0xFF80D0C7), // Ending color
//                             ],
//                             stops: [0.0, 1.0],
//                             transform: GradientRotation(160 * (3.14159 / 180)), // Rotate by 160 degrees
//                           ),
//                         ),
//                         child: const Center(
//                           child: CommonKhandText(
//                             title: "POST",
//                             textColor: ColorUtils.colorWhite,
//                             fontWeight: FontWeight.w200,
//                             fontSize: 18,
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             homeProvider.isLoading?CustomLoader():SizedBox.shrink()
//           ],
//         );
//       }
//     );
//   }
//
//   onValueChange(String value){
//     groupValue = value;
//     setState(() {
//
//     });
//   }
// }

class CreateTimeLine extends StatefulWidget {

  const CreateTimeLine({Key? key}) : super(key: key);

  @override
  State<CreateTimeLine> createState() => _CreateTimeLineState();
}

class _CreateTimeLineState extends State<CreateTimeLine> {
  String groupValue = "image";
  ImagePicker _imagePicker = ImagePicker();
  TextEditingController writePost = TextEditingController();
  List<File> _imageFile = [];
  Uint8List? _videoThumbnail;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.darkTheme ?  ColorUtils.colorBlack: ColorUtils.colorBlack,
      appBar: AppBar(
        surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorBlack :  ColorUtils.appBarColor ,
        backgroundColor: themeProvider.darkTheme ? ColorUtils.colorBlack :  ColorUtils.appBarColor ,
        centerTitle: true,
        elevation: 4,
        title:   CommonKhandText(
          title: "Create Timeline",
          textColor:themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorWhite,
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 60),
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
        child: Consumer<HomeProvider>(
            builder: (context,homeProvider,_) {
              return Stack(
                children: [
                  Container(
                    // padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        // color: ColorUtils.colorBlack,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: RadioListTile(
                                  selected: false,
                                  activeColor: ColorUtils.orangeAccent,
                                  groupValue: groupValue,
                                  title: Text(
                                    "Image",
                                    style: TextStyle(
                                        color: ColorUtils.colorWhite,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onChanged: (value) {
                                    onValueChange(value!);
                                    //authProvider.onRingTypeChange(value);
                                  },
                                  value: "image",
                                )),
                            Expanded(
                                child: RadioListTile(
                                  selected: false,
                                  activeColor: ColorUtils.orangeAccent,
                                  groupValue: groupValue,
                                  title: Text(
                                    "Video",
                                    style: TextStyle(
                                        color: ColorUtils.colorWhite,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onChanged: (value) {
                                    onValueChange(value!);
                                    //authProvider.onRingTypeChange(value);
                                  },
                                  value: "video",
                                )),
                          ],
                        ),
                        // verticalSpace(6),
                        Container(
                          height: 140,
                          padding: EdgeInsets.fromLTRB(15, 0,15, 0),
                          margin: EdgeInsets.fromLTRB(12,5,12,5),
                          width: screenWidth(context),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black
                          ),
                          child: MyTextField(
                            maxLines: 50,
                            focusNode: _focusNode,
                            showBorders: false,
                            controller: writePost,
                            hintText: "Write...",
                            keyboardType: TextInputType.multiline,
                            textSize: 16.1,
                          ),
                        ),
                        // verticalSpace(20),
                        Padding(
                          padding: EdgeInsets.only(left: 8,right: 8 ,top: 5),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  if(groupValue == "image") {
                                    List<XFile> file = await _imagePicker.pickMultiImage(limit: 10, imageQuality: 20);
                                    if(file.isNotEmpty){
                                      _imageFile.clear();
                                      for(var f in file){
                                        _imageFile.add(File(f.path));

                                      }
                                      setState(() {

                                      });
                                    }
                                  }else{
                                    XFile? file = await _imagePicker.pickVideo(source: ImageSource.gallery);
                                    if(file != null){
                                      _imageFile.clear();
                                      _imageFile.add(File(file.path));
                                      _videoThumbnail = await VideoThumbnail.thumbnailData(
                                        video: _imageFile[0].path,
                                        imageFormat: ImageFormat.JPEG,
                                        maxWidth: 128, // specify the width of the thumbnail, can be adjusted
                                        quality: 25,
                                      );
                                      setState(() {

                                      });
                                    }
                                  }
                                },
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: ColorUtils.primaryColor,width: 3)
                                    ),
                                    child: Icon(Icons.upload_file,color: ColorUtils.primaryColor,size: 30,),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 4,right: 6),
                                height: 60,
                                width: 2,
                                color: ColorUtils.colorWhite,
                              ),

                              groupValue=="image"?
                              Expanded(child: Container(
                                height: 65,
                                child: ListView.separated(
                                    separatorBuilder: (context,index){
                                      return SizedBox(width: 6,);
                                    },
                                    shrinkWrap: true,
                                    itemCount: _imageFile.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context,index){
                                      return Container(
                                        height: 65,width: 65,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: ColorUtils.primaryColor,width: 2)
                                        ),
                                        child: Stack(
                                          children: [

                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.file(_imageFile[index],height: 65,width:65,fit: BoxFit.fill,),
                                            ),

                                            InkWell(
                                              onTap:(){

                                                _imageFile.removeAt(index);
                                                setState(() {

                                                });
                                              },
                                              child: Container(
                                                // margin: EdgeInsets.only(top: 0.2),

                                              // transform: Matrix4.translationValues(6.0, -13.0, 0.0),
                                                child: Align(
                                                    alignment: Alignment.topRight,
                                                    child: Icon(Icons.cancel,color: ColorUtils.errorColor,)),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              )):
                              _videoThumbnail != null?Container(
                                height: 65,width: 65,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: ColorUtils.primaryColor,width: 2)
                                ),
                                child: Stack(
                                  children: [

                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.memory(_videoThumbnail!,height: 65,width:65,fit: BoxFit.fill,),
                                    ),

                                    InkWell(
                                      onTap:(){
                                        setState(() {
                                          _videoThumbnail = null;
                                        });
                                      },
                                      child: Container(
                                        // margin: EdgeInsets.only(top: 20),
                                        // transform: Matrix4.translationValues(6.0, -13.0, 0.0),
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: Icon(Icons.cancel,color: ColorUtils.errorColor,)),
                                      ),
                                    )
                                  ],
                                ),
                              ):SizedBox.shrink()
                            ],
                          ),
                        ),
                        // verticalSpace(5),
                        Spacer(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () async {
                              try {
                                FocusScope.of(context).unfocus();
                                if (writePost.text.trim().isEmpty && _imageFile.isEmpty) {
                                  Utils.toastMessage("Post text or image is required");
                                  return;
                                }

                                await homeProvider.createTimeLine(
                                  context,
                                  writePost.text.trim(),
                                  List<File>.from(_imageFile),
                                );
                                _imageFile.clear();
                                writePost.clear();
                                _videoThumbnail = null;
                                setState(() {});
                              } catch (e, stack) {
                                print("Error in createTimeLine: $e\n$stack");
                                Utils.toastMessage("Something went wrong");
                              }
                            },

                            // onTap:(){
                            //   homeProvider.createTimeLine(context, writePost.text.toString(), _imageFile);
                            // },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.only(left: 18,right: 18,top: 11,bottom: 35),
                              width: screenWidth(context),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(100),
                                color: const Color(0xFF0093E9),
                                gradient: const LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color(0xFF0093E9),
                                    Color(0xFF80D0C7),
                                  ],
                                  stops: [0.0, 1.0],
                                  transform: GradientRotation(160 * (3.14159 / 180)),
                                ),
                              ),

                              child: const Center(
                                child: CommonKhandText(
                                  title: "POST",
                                  textColor: ColorUtils.colorWhite,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 18,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // verticalSpace(25),
                      ],
                    ),
                  ),
                  homeProvider.isLoading?CustomLoader():SizedBox.shrink()
                ],
              );
            }
        ),
      ),
    );
  }

  onValueChange(String value){
    groupValue = value;
    setState(() {

    });
  }
}