// import 'package:digitalsaathi/constants/components/pro_text.dart';
// import 'package:digitalsaathi/data/model/poster_list_response.dart';
// import 'package:digitalsaathi/ui/more/poster/poster_font_size_adjuster/FontSizeController.dart';
// import 'package:digitalsaathi/utils/app_utils.dart';
// import 'package:digitalsaathi/utils/color_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class PosterFontSizeAdjuster extends StatelessWidget {
//   final DefaultProfile defaultProfile;
//   final int type;
//   final FontSizeController controller;
//
//   const PosterFontSizeAdjuster({
//     Key? key,
//     required this.defaultProfile,
//     required this.type,
//     required this.controller,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => Column(
//       children: [
//         // Stack(
//         //   alignment: Alignment.center,
//         //   children: [
//         //     Visibility(
//         //       visible: defaultProfile.designation.isNotEmpty,
//         //       child: Container(
//         //         margin: const EdgeInsets.fromLTRB(35, 3, 90, 3),
//         //         padding: const EdgeInsets.only(bottom: 4),
//         //         width: MediaQuery.of(context).size.width,
//         //         alignment: Alignment.topCenter,
//         //         decoration: BoxDecoration(
//         //           color: ColorUtils.orangeAccent,
//         //           borderRadius: BorderRadius.circular(50),
//         //         ),
//         //         child: Container(
//         //           alignment: Alignment.centerRight,
//         //           margin: const EdgeInsets.only(right: 30),
//         //           child: CommonKhandText(
//         //             title: defaultProfile.name,
//         //             textAlign: TextAlign.start,
//         //             textColor: ColorUtils.colorWhite,
//         //             fontWeight: FontWeight.bold,
//         //             fontSize: controller.fontSizeName.value,
//         //           ),
//         //         ),
//         //       ),
//         //     ),
//         //     Visibility(
//         //       visible: defaultProfile.designation.isNotEmpty,
//         //       child: Align(
//         //         alignment: Alignment.bottomCenter,
//         //         child: Container(
//         //           margin: const EdgeInsets.fromLTRB(20, 40, 90, 0),
//         //           padding: const EdgeInsets.only(bottom: 1),
//         //           width: MediaQuery.of(context).size.width,
//         //           alignment: Alignment.bottomCenter,
//         //           decoration: BoxDecoration(
//         //             color: ColorUtils.colorGreen,
//         //             borderRadius: BorderRadius.circular(50),
//         //           ),
//         //           child: Container(
//         //             alignment: Alignment.centerRight,
//         //             margin: const EdgeInsets.only(right: 30),
//         //             child: CommonKhandText(
//         //               title: defaultProfile.designation,
//         //               textAlign: TextAlign.start,
//         //               textColor: ColorUtils.colorWhite,
//         //               fontWeight: FontWeight.w300,
//         //               fontSize: controller.fontSizeDesignation.value,
//         //             ),
//         //           ),
//         //         ),
//         //       ),
//         //     ),
//         //     defaultProfile.profileImg.isEmpty
//         //         ? const SizedBox.shrink()
//         //         : Align(
//         //       alignment: Alignment.centerRight,
//         //       child: type == 0
//         //           ? Container(
//         //         margin: const EdgeInsets.only(bottom: 1, right: 5),
//         //         height: 100,
//         //         width: 110,
//         //         decoration: BoxDecoration(
//         //           border: Border.all(
//         //             color: ColorUtils.colorWhite,
//         //             width: 2,
//         //           ),
//         //           shape: BoxShape.circle,
//         //           image: DecorationImage(
//         //             image: NetworkImage(defaultProfile.profileImg),
//         //             fit: BoxFit.fill,
//         //           ),
//         //         ),
//         //       )
//         //           : Container(
//         //         margin: const EdgeInsets.only(bottom: 1, right: 5),
//         //         height: 100,
//         //         width: 110,
//         //         child: Image.network(defaultProfile.profileImg, fit: BoxFit.fill),
//         //       ),
//         //     )
//         //   ],
//         // ),
//         // const SizedBox(height: 15),
//         Container(
//           padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
//           decoration: BoxDecoration(
//               // color: Colors.orangeAccent.withOpacity(0.8),
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(10),
//                   topRight: Radius.circular(10)
//               )
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               InkWell(
//                 borderRadius: BorderRadius.circular(100),
//                 onTap: controller.decreaseFontSizeName,
//                 child: Container(
//                   height: 30,
//                   width: 30,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.black,
//                   ),
//                   child: const Text(
//                     '−',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 15),
//               Text(
//                 controller.fontSizeName.value.toInt().toString(),
//                 style:  TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: ColorUtils.orangeAccent
//                 ),
//               ),
//               const SizedBox(width: 15),
//               // Plus Button
//               InkWell(
//                 borderRadius: BorderRadius.circular(100),
//                 onTap: controller.increaseFontSizeName,
//                 child: Container(
//                   height: 30,
//                   width: 30,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.black,
//                   ),
//                   child: const Center(
//                     child: Icon(Icons.add, color: Colors.white, size: 20),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 40),
//               GestureDetector(
//                 onTap: (){
//                   controller.saveFontSizeName;
//                   Navigator.pop(context);
//                 },
//                 child: Container(
//                   width: 90,
//                   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.orangeAccent
//                     // gradient: const LinearGradient(
//                     //   colors: [Color(0xFF0093E9), Color(0xFF80D0C7)],
//                     //   begin: Alignment.topRight,
//                     //   end: Alignment.bottomLeft,
//                     // ),
//                   ),
//                   child:  CommonKhandText(
//                     title: "Save",
//                     textColor: ColorUtils.colorWhite,
//                     fontWeight: FontWeight.w200,
//                     fontSize: 12,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
//           decoration: BoxDecoration(
//               // color: ColorUtils.colorGreen.withOpacity(0.7),
//               borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(10),
//                   bottomRight: Radius.circular(10)
//               )
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//
//                 children: [
//                   InkWell(
//                     borderRadius: BorderRadius.circular(100),
//                     onTap: controller.decreaseFontSizeDesignation,
//                     child: Container(
//                       height: 30,
//                       width: 30,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.black,
//                       ),
//                       child: const Text(
//                         '−',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   horizontalSpace(15),
//                   Text(
//                     controller.fontSizeDesignation.value.toInt().toString(),
//                     style:  TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: ColorUtils.colorGreen
//                     ),
//                   ),
//                   horizontalSpace(15),
//                   InkWell(
//                     borderRadius: BorderRadius.circular(100),
//                     onTap: controller.increaseFontSizeDesignation,
//                     child: Container(
//                       height: 30,
//                       width: 30,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.black,
//                       ),
//                       child: const Center(
//                         child: Icon(Icons.add, color: Colors.white, size: 20),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               horizontalSpace(40),
//               GestureDetector(
//                 onTap: (){
//                   controller.saveFontSizeDesignation();
//                   Navigator.pop(context);
//                 },
//                 child: Container(
//                   // height: 30,
//                   width: 90,
//                   padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color:ColorUtils.colorGreen,
//                     // gradient: const LinearGradient(
//                     //   begin: Alignment.topRight,
//                     //   end: Alignment.bottomLeft,
//                     //   colors: [
//                     //     Color(0xFF0093E9),
//                     //     Color(0xFF80D0C7),
//                     //   ],
//                     //   stops: [0.0, 1.0],
//                     //   transform: GradientRotation(160 * (3.14159 / 180)),
//                     // ),
//                   ),
//                   child: const Center(
//                     child: CommonKhandText(
//                       title: "Save",
//                       textColor: ColorUtils.colorWhite,
//                       fontWeight: FontWeight.w200,
//                       fontSize: 12,
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         )
//       ],
//     ));
//   }
// }


import 'package:digitalsaathi/constants/components/pro_text.dart';
import 'package:digitalsaathi/data/model/poster_list_response.dart';
import 'package:digitalsaathi/ui/more/poster/poster_font_size_adjuster/FontSizeController.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PosterFontSizeAdjuster extends StatelessWidget {
  final DefaultProfile defaultProfile;
  final int type;
  final FontSizeController controller;

  const PosterFontSizeAdjuster({
    Key? key,
    required this.defaultProfile,
    required this.type,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                )
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: controller.decreaseFontSizeName,
                  child: Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: const Text(
                      '−',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),

                Text(
                  controller.displayFontSizeName,
                  // controller.tempFontSizeName.value.toInt().toString(),
                  // controller.tempFontSizeName.value.toInt().toString(),
                  // controller.fontSizeName.value.toInt().toString(),
                  style:  TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ColorUtils.orangeAccent
                  ),
                ),
                const SizedBox(width: 15),
                // Plus Button
                InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: controller.increaseFontSizeName,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: const Center(
                      child: Icon(Icons.add, color: Colors.white, size: 20),
                    ),
                  ),
                ),
                // const SizedBox(width: 40),
                // GestureDetector(
                //   onTap: (){
                //     controller.saveFontSizeNameAndDesignation();
                //     Navigator.pop(context);
                //   },
                //   child: Container(
                //     width: 90,
                //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(20),
                //         color: Colors.orangeAccent
                //     ),
                //     child:  CommonKhandText(
                //       title: "Save",
                //       textColor: ColorUtils.colorWhite,
                //       fontWeight: FontWeight.w200,
                //       fontSize: 12,
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                // )
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
            decoration: BoxDecoration(
              // color: ColorUtils.colorGreen.withOpacity(0.7),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                )
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: controller.decreaseFontSizeDesignation,
                      child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: const Text(
                          '−',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    horizontalSpace(15),
                    Text(
                      controller.displayFontSizeDesignation,
                      // controller.fontSizeDesignation.value.toInt().toString(),
                      style:  TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ColorUtils.colorGreen
                      ),
                    ),
                    horizontalSpace(15),
                    InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: controller.increaseFontSizeDesignation,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: const Center(
                          child: Icon(Icons.add, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),

          horizontalSpace(40),
          verticalSpace(10),
          GestureDetector(
            onTap: (){
              controller.saveFontSizeNameAndDesignation();
              controller.saveFontSizeNameAndDesignation();
              // controller.saveFontSizeDesignation();
              Navigator.pop(context);
            },
            child: Container(
               height: 40,
              width: 200,
              padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
               // color:ColorUtils.colorGreen,
                gradient: LinearGradient(colors: [ColorUtils.orangeAccent,ColorUtils.colorGreen,ColorUtils.orangeAccent])
              ),
              child: const Center(
                child: CommonKhandText(
                  title: "Save",
                  textColor: ColorUtils.colorWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )

        ],
      ) ;
    });
  }
}
