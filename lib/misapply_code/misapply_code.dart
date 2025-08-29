  // content.dart appbar
  // Row(
  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   children: [
  //     Container(
  //       height: 40,
  //       width: 40,
  //       padding: const EdgeInsets.only(left: 8),
  //       decoration: BoxDecoration(
  //           color: Colors.black.withOpacity(0.3),
  //           shape: BoxShape.circle
  //       ),
  //       child: GestureDetector(
  //         onTap: () {
  //           Navigator.pop(context);
  //         },
  //         child: const Center(  // Center the Icon widget here
  //           child: Icon(
  //             Icons.arrow_back_ios,
  //             color: Colors.white,
  //           ),
  //         ),
  //       ),
  //     ),
  //     const CommonKhandText(
  //       title: "Creative-Videos-Media Links",
  //       textColor: Color(0xffffffff),
  //       fontWeight: FontWeight.w300,
  //       fontSize: 18,
  //     ),
  //     Container()
  //
  //   ],
  // ),


  //poster second design

  // Column(
  //   children: [
  //     verticalSpace(10),
  //     const Divider(),
  //     Container(
  //     width: screenWidth(context),
  //       decoration:const BoxDecoration(
  //         // color: Colors.green,
  //       ),
  //       child: Column(
  //         children: [
  //           // Top Section
  //           Container(
  //             padding: const EdgeInsets.all(10),
  //             color: Color(0xffFFFFFF),
  //             child: Column(
  //               children: [
  //                 Row(
  //                   children: [
  //                     Container(
  //                       height: 40,
  //                       width: 40,
  //                       decoration: const BoxDecoration(
  //                         shape: BoxShape.circle,
  //                         image:DecorationImage(image: AssetImage(AssetUtils.profilePng),fit: BoxFit.fill)
  //                       ),
  //                     ),
  //                     horizontalSpace(10),
  //                     Container(
  //                       padding: const EdgeInsets.only(bottom:7),
  //                       child: const Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         children: [
  //                           CommonKhandText(
  //                             title: "Admin",
  //                             textColor: Colors.black,
  //                             fontWeight: FontWeight.w300,
  //                             fontSize: 18,
  //                           ),
  //                           CommonKhandText(
  //                             title: "31 Dec 2024 8:11 PM",
  //                             textColor: Colors.black,
  //                             fontWeight: FontWeight.w300,
  //                             fontSize: 10,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ),
  //           // user image
  //           Container(
  //             height: 350,
  //             padding: const EdgeInsets.only(top: 10,bottom: 10),
  //             decoration: const BoxDecoration(
  //               border: Border(top: BorderSide(width: 1,color: Colors.black),bottom: BorderSide(width: 1,color: Colors.black)),
  //               image: DecorationImage(image: AssetImage(AssetUtils.posterCheck),fit: BoxFit.cover)
  //             ),
  //           ),
  //           // like comment share data
  //           Container(
  //             height: 45,
  //             padding: const EdgeInsets.only(left: 10,right: 10),
  //             color: Color(0xffFFFFFF),
  //             child:Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Row(
  //                   children: [
  //                     const Image(image: AssetImage(AssetUtils.FBLikeButton),height: 20,),
  //                     horizontalSpace(5),
  //                     const CommonKhandText(
  //                       title: "6.9K",
  //                       textColor: Colors.black,
  //                       fontWeight: FontWeight.w300,
  //                       fontSize: 14,
  //                     ),
  //                   ],
  //                 ),
  //                 const CommonKhandText(
  //                   title: "100 comments",
  //                   textColor: Colors.black,
  //                   fontWeight: FontWeight.w300,
  //                   fontSize: 14,
  //                 ),
  //                 const CommonKhandText(
  //                   title: "100 shares",
  //                   textColor: Colors.black,
  //                   fontWeight: FontWeight.w300,
  //                   fontSize: 14,
  //                 ),
  //               ],
  //             ),
  //           ),
  //          // like comment share ui
  //           Container(
  //             padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
  //             color: Color(0xffFFFFFF),
  //             child:  Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Row(
  //                   children: [
  //                     const Icon(Icons.thumb_up_alt_outlined,size: 23,),
  //                     horizontalSpace(5),
  //                     const CommonKhandText(
  //                       title: "Like",
  //                       textColor: Colors.black,
  //                       fontWeight: FontWeight.w300,
  //                       fontSize: 14,
  //                     ),
  //                   ],
  //                 ),
  //                 Container(
  //                   height: 25,
  //                   width: 1,
  //                   color: Colors.black,
  //                 ),
  //                 Row(
  //                   children: [
  //                     const Icon(Icons.mode_comment_outlined,size: 23,),
  //                     horizontalSpace(5),
  //                     const CommonKhandText(
  //                       title: "Comment",
  //                       textColor: Colors.black,
  //                       fontWeight: FontWeight.w300,
  //                       fontSize: 14,
  //                     ),
  //                   ],
  //                 ),
  //                 Container(
  //                   height: 25,
  //                   width: 1,
  //                   color: Colors.black,
  //                 ),
  //                 Row(
  //                   children: [
  //                     const Image(image: AssetImage(AssetUtils.ShareArrow),height: 20,),
  //                     horizontalSpace(5),
  //                     const CommonKhandText(
  //                       title: "Share",
  //                       textColor: Colors.black,
  //                       fontWeight: FontWeight.w300,
  //                       fontSize: 14,
  //                     ),
  //                   ],
  //                 ),
  //
  //               ],
  //             ),
  //           ),
  //
  //         ],
  //       ),
  //     ),
  //     Divider(),
  //   ],
  // ),



//   Create post profile body section

  // body: Builder(
  //   builder:(context) {
  //     return Container(
  //       height: screenHeight(context),
  //       width: screenWidth(context),
  //       decoration: const BoxDecoration(
  //           image: DecorationImage(
  //               image: AssetImage(AssetUtils.screenBackgroundTwo),
  //               fit: BoxFit.fill)
  //       ),
  //       child: SafeArea(
  //         child: SingleChildScrollView(
  //           child: Padding(
  //             padding: const EdgeInsets.only(left: 10,right: 10),
  //             child: Column(
  //               children: [
  //                 verticalSpace(10),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     // Card(
  //                     //   elevation: 3,
  //                     //   shape: const RoundedRectangleBorder(
  //                     //       borderRadius: BorderRadius.all( Radius.circular(5))
  //                     //   ),
  //                     //   color: const Color(0xffffffff),
  //                     //   child: Container(
  //                     //     width: 164,
  //                     //     decoration:  const BoxDecoration(
  //                     //         borderRadius: BorderRadius.only(
  //                     //             topLeft: Radius.circular(10),
  //                     //             topRight: Radius.circular(10),
  //                     //             bottomRight: Radius.circular(4),
  //                     //             bottomLeft: Radius.circular(4)
  //                     //         )
  //                     //     ),
  //                     //     child: Column(
  //                     //       children: [
  //                     //         Container(
  //                     //           height: 170,
  //                     //           width: 170,
  //                     //           // padding: EdgeInsets.all(10),
  //                     //           decoration: const BoxDecoration(
  //                     //               borderRadius: BorderRadius.only(
  //                     //                   topLeft: Radius.circular(4),
  //                     //                   topRight: Radius.circular(4),
  //                     //                   bottomRight: Radius.circular(4),
  //                     //                   bottomLeft: Radius.circular(4)
  //                     //               ),
  //                     //               image: DecorationImage(
  //                     //                   image: AssetImage(AssetUtils.AddFacebook),
  //                     //                   fit: BoxFit.fill)
  //                     //           ),
  //                     //         ),
  //                     //         Column(
  //                     //           crossAxisAlignment: CrossAxisAlignment.start,
  //                     //           children: [
  //                     //             Container(
  //                     //               width: 170,
  //                     //               padding: const EdgeInsets.only(
  //                     //                   left: 6,
  //                     //                   right: 6,
  //                     //                   top: 3,
  //                     //                   bottom: 3
  //                     //               ),
  //                     //               margin: const EdgeInsets.only(left: 8,right: 8,top: 8),
  //                     //               decoration: BoxDecoration(
  //                     //                 color: const Color(0xff6d9eeb),
  //                     //                 borderRadius: BorderRadius.circular(4),
  //                     //               ),
  //                     //               child: const CommonKhandText(
  //                     //                 title: "Add Image",
  //                     //                 textAlign: TextAlign.center,
  //                     //                 textColor: Colors.white,
  //                     //                 fontWeight: FontWeight.w400,
  //                     //                 fontSize: 15,
  //                     //               ),
  //                     //             ),
  //                     //             verticalSpace(3),
  //                     //             Container(
  //                     //               width: 170,
  //                     //               margin: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
  //                     //               padding: const EdgeInsets.only(
  //                     //                   left: 6,
  //                     //                   right: 6,
  //                     //                   top: 3,
  //                     //                   bottom: 3
  //                     //               ),
  //                     //               decoration: BoxDecoration(
  //                     //                 color: const Color(0xff6d9eeb),
  //                     //                 borderRadius: BorderRadius.circular(4),
  //                     //               ),
  //                     //               child: CommonKhandText(
  //                     //                 title: "Remove Image",
  //                     //                 textAlign: TextAlign.center,
  //                     //                 textColor: Colors.white,
  //                     //                 fontWeight: FontWeight.w400,
  //                     //                 fontSize: 15,
  //                     //               ),
  //                     //             ),
  //                     //           ],
  //                     //         ),
  //                     //       ],
  //                     //     ),
  //                     //   ),
  //                     // ),
  //                     // Card(
  //                     //   elevation: 3,
  //                     //   shape: const RoundedRectangleBorder(
  //                     //       borderRadius: BorderRadius.all( Radius.circular(5))
  //                     //   ),
  //                     //   color: const Color(0xffffffff),
  //                     //   child: Container(
  //                     //     width: 164,
  //                     //     decoration:  const BoxDecoration(
  //                     //         borderRadius: BorderRadius.only(
  //                     //             topLeft: Radius.circular(10),
  //                     //             topRight: Radius.circular(10),
  //                     //             bottomRight: Radius.circular(4),
  //                     //             bottomLeft: Radius.circular(4)
  //                     //         )
  //                     //     ),
  //                     //     child: Column(
  //                     //       children: [
  //                     //         Container(
  //                     //           height: 170,
  //                     //           width: 170,
  //                     //           // padding: EdgeInsets.all(10),
  //                     //           decoration: BoxDecoration(
  //                     //               borderRadius: BorderRadius.only(
  //                     //                   topLeft: Radius.circular(4),
  //                     //                   topRight: Radius.circular(4),
  //                     //                   bottomRight: Radius.circular(4),
  //                     //                   bottomLeft: Radius.circular(4)
  //                     //               ),
  //                     //               image: const DecorationImage(
  //                     //                   image: AssetImage(AssetUtils.AddFacebook),
  //                     //                   fit: BoxFit.fill)
  //                     //           ),
  //                     //           child: Column(
  //                     //             mainAxisAlignment: MainAxisAlignment.end,
  //                     //             children: [
  //                     //             ],
  //                     //           ),
  //                     //         ),
  //                     //         Column(
  //                     //           crossAxisAlignment: CrossAxisAlignment.start,
  //                     //           children: [
  //                     //             Container(
  //                     //               width: 170,
  //                     //               padding: const EdgeInsets.only(
  //                     //                   left: 6,
  //                     //                   right: 6,
  //                     //                   top: 3,
  //                     //                   bottom: 3
  //                     //               ),
  //                     //               margin: const EdgeInsets.only(left: 8,right: 8,top: 8),
  //                     //               decoration: BoxDecoration(
  //                     //                 color: const Color(0xff6d9eeb),
  //                     //                 borderRadius: BorderRadius.circular(4),
  //                     //               ),
  //                     //               child: const CommonKhandText(
  //                     //                 title: "Party Logo",
  //                     //                 textAlign: TextAlign.center,
  //                     //                 textColor: Colors.white,
  //                     //                 fontWeight: FontWeight.w400,
  //                     //                 fontSize: 15,
  //                     //               ),
  //                     //             ),
  //                     //             verticalSpace(3),
  //                     //             Container(
  //                     //               width: 170,
  //                     //               margin: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
  //                     //               padding: const EdgeInsets.only(
  //                     //                   left: 6,
  //                     //                   right: 6,
  //                     //                   top: 3,
  //                     //                   bottom: 3
  //                     //               ),
  //                     //               decoration: BoxDecoration(
  //                     //                 color: const Color(0xff6d9eeb),
  //                     //                 borderRadius: BorderRadius.circular(4),
  //                     //               ),
  //                     //               child: CommonKhandText(
  //                     //                 title: "Remove Logo",
  //                     //                 textAlign: TextAlign.center,
  //                     //                 textColor: Colors.white,
  //                     //                 fontWeight: FontWeight.w400,
  //                     //                 fontSize: 15,
  //                     //               ),
  //                     //             ),
  //                     //           ],
  //                     //         ),
  //                     //       ],
  //                     //     ),
  //                     //   ),
  //                     // ),
  //
  //                     Container(
  //                       width: 164,
  //                       padding: EdgeInsets.only(bottom: 10),
  //                       decoration:   BoxDecoration(
  //                           color: Colors.black.withOpacity(0.1),
  //                           borderRadius: const BorderRadius.all(Radius.circular(10),
  //                           ),
  //                         image: DecorationImage(image: AssetImage(AssetUtils.bgMlaFollow),fit:BoxFit.fill )
  //                       ),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         children: [
  //                           Container(
  //                             height: 170,
  //                             width: 170,
  //                             decoration: const BoxDecoration(
  //                                 borderRadius: BorderRadius.all(Radius.circular(12)),
  //                             ),
  //                             child: Center(
  //                               child: Container(
  //                                 height: 150,
  //                                 width: 150,
  //                                 decoration: const BoxDecoration(
  //                                     borderRadius: BorderRadius.all(Radius.circular(12)),
  //                                     image: DecorationImage(
  //                                         image: AssetImage(AssetUtils.myPic),
  //                                         fit: BoxFit.fill
  //                                     )
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Column(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Container(
  //                                 width: 170,
  //                                 margin: const EdgeInsets.only(left: 8,right: 8),
  //                                 padding: const EdgeInsets.only(
  //                                   top: 3,bottom: 3
  //                                 ),
  //                                 decoration: BoxDecoration(
  //                                   // color:Colors.blue.withOpacity(0.5) ,
  //                                   image: const DecorationImage(image: AssetImage(AssetUtils.bgCardThree),fit:BoxFit.fill ),
  //                                   borderRadius: BorderRadius.circular(4),
  //                                 ),
  //                                 child: const CommonKhandText(
  //                                   title: "Add Image",
  //                                   textAlign: TextAlign.center,
  //                                   textColor: Colors.white,
  //                                   fontWeight: FontWeight.w400,
  //                                   fontSize: 15,
  //                                 ),
  //                               ),
  //                               verticalSpace(7),
  //                               Container(
  //                                 width: 170,
  //                                 padding: const EdgeInsets.only(
  //                                     top: 3,
  //                                     bottom: 3
  //                                 ),
  //                                 margin: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
  //                                 decoration: BoxDecoration(
  //                                   // color:Colors.blue.withOpacity(0.5) ,
  //                                   image: DecorationImage(image: AssetImage(AssetUtils.bgCardThree),fit:BoxFit.fill ),
  //                                   borderRadius: BorderRadius.circular(4),
  //                                 ),
  //                                 child: CommonKhandText(
  //                                   title: "Remove Image",
  //                                   textAlign: TextAlign.center,
  //                                   textColor: Colors.white,
  //                                   fontWeight: FontWeight.w400,
  //                                   fontSize: 15,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     Container(
  //                       width: 164,
  //                       decoration:   BoxDecoration(
  //                           color: Colors.black.withOpacity(0.1),
  //                           borderRadius: const BorderRadius.all(Radius.circular(10),
  //                           ),
  //                           image: DecorationImage(image: AssetImage(AssetUtils.bgMlaFollow),fit:BoxFit.fill )
  //                       ),
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         children: [
  //                           Container(
  //                             height: 170,
  //                             width: 170,
  //                             decoration: const BoxDecoration(
  //                               borderRadius: BorderRadius.all(Radius.circular(12)),
  //                             ),
  //                             child: Center(
  //                               child: Container(
  //                                 height: 150,
  //                                 width: 150,
  //                                 decoration: const BoxDecoration(
  //                                     borderRadius: BorderRadius.all(Radius.circular(12)),
  //                                     image: DecorationImage(
  //                                         image: AssetImage(AssetUtils.myPic),
  //                                         fit: BoxFit.fill
  //                                     )
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Column(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Container(
  //                                 width: 170,
  //                                 padding: const EdgeInsets.only(
  //                                     top: 3,
  //                                     bottom: 3
  //                                 ),
  //                                 margin: const EdgeInsets.only(left: 8,right: 8),
  //                                 decoration: BoxDecoration(
  //                                   // color:Colors.green.withOpacity(0.5) ,
  //                                     image: DecorationImage(image: AssetImage(AssetUtils.bgCardThree),fit:BoxFit.fill ),
  //
  //                                     borderRadius: BorderRadius.circular(4),
  //                                 ),
  //                                 child: const CommonKhandText(
  //                                   title: "Party Logo",
  //                                   textAlign: TextAlign.center,
  //                                   textColor: Colors.white,
  //                                   fontWeight: FontWeight.w400,
  //                                   fontSize: 15,
  //                                 ),
  //                               ),
  //                               verticalSpace(7),
  //                               Container(
  //                                 width: 170,
  //                                 padding: const EdgeInsets.only(
  //                                     top: 3,
  //                                     bottom: 3
  //                                 ),
  //                                 margin: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
  //                                 decoration: BoxDecoration(
  //                                   // color:Colors.blue.withOpacity(0.5) ,
  //                                   image: DecorationImage(image: AssetImage(AssetUtils.bgCardThree),fit:BoxFit.fill ),
  //                                   borderRadius: BorderRadius.circular(4),
  //                                 ),
  //                                 child: CommonKhandText(
  //                                   title: "Remove Logo",
  //                                   textAlign: TextAlign.center,
  //                                   textColor: Colors.white,
  //                                   fontWeight: FontWeight.w400,
  //                                   fontSize: 15,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //
  //                   ],
  //                 ),
  //                 verticalSpace(20),
  //                 const Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     CommonKhandText(
  //                       title: "Add Leader Profile",
  //                       textAlign: TextAlign.center,
  //                       textColor: Colors.white,
  //                       fontWeight: FontWeight.w300,
  //                       fontSize: 13,
  //                     ),
  //                     CommonKhandText(
  //                       title: "Add Symbol",
  //                       textAlign: TextAlign.center,
  //                       textColor: Colors.white,
  //                       fontWeight: FontWeight.w300,
  //                       fontSize: 13,
  //                     ),
  //                   ],
  //                 ),
  //                 // verticalSpace(5),
  //                 Stack(
  //                   alignment: Alignment.center,
  //                   children: [
  //                     Card(
  //                       margin: const EdgeInsets.only(top:33),
  //                       elevation: 2,
  //                       child: Container(
  //                         width: screenWidth(context)*0.8,
  //                         height: 175,
  //                         decoration:    BoxDecoration(
  //                           color: Color(0xff0000ff).withOpacity(0.2),
  //                           borderRadius: BorderRadius.all(Radius.circular(11)),
  //                           image: DecorationImage(image: AssetImage(AssetUtils.bgCardThree),fit: BoxFit.fill)
  //                         ),
  //                       ),
  //                     ),
  //                     Card(
  //                       elevation: 1,
  //                       margin: const EdgeInsets.only(left: 10,right: 10,top: 15),
  //                       child: Container(
  //                         width: screenWidth(context)*0.88,
  //                         height: 175,
  //                         decoration:    BoxDecoration(
  //                           color:Color(0xff9900ff).withOpacity(0.7),
  //                           borderRadius: BorderRadius.all(Radius.circular(11)),
  //                           image: DecorationImage(image: AssetImage(AssetUtils.bgCardFour),fit: BoxFit.fill)
  //                         ),
  //                       ),
  //                     ),
  //                     Card(
  //                       // elevation: 4,
  //                       margin: EdgeInsets.zero,
  //                       child: Container(
  //                         height: 170,
  //                         padding: const EdgeInsets.only(top: 10,right: 10,left: 290),
  //                         width: screenWidth(context),
  //                         decoration:   const BoxDecoration(
  //                             borderRadius: BorderRadius.all(Radius.circular(11)),
  //                             image: DecorationImage(image: AssetImage(AssetUtils.creatives),fit: BoxFit.fill)
  //                         ),
  //                         child: Column(
  //                           // crossAxisAlignment: CrossAxisAlignment.end,
  //                           children: [
  //                             GestureDetector(
  //                               onTap: (){
  //                                 showMenu(
  //                                   color: Color(0xffffffff),
  //                                   context: context,
  //                                   position: const RelativeRect.fromLTRB(290.0, 380.0, 10.0, 100.0), // Adjust position as needed
  //                                   items: [
  //                                     PopupMenuItem(
  //                                       // height: 40,
  //                                       onTap: (){
  //                                         Navigator.push(context, MaterialPageRoute(builder: (context) => AddLeaderProfile(),));
  //                                       },
  //                                       child: Container(
  //                                         width: screenWidth(context)*0.46,
  //                                         padding: const EdgeInsets.fromLTRB(10, 4, 10,4),
  //                                         decoration: BoxDecoration(
  //                                           color: const Color(0xff6d9eeb),
  //                                           borderRadius: BorderRadius.circular(4),
  //                                         ),
  //                                         child: const CommonKhandText(
  //                                           title: "Add Leader Profile",
  //                                           textAlign: TextAlign.center,
  //                                           textColor: Colors.white,
  //                                           fontWeight: FontWeight.w400,
  //                                           fontSize: 15,
  //                                         ),
  //                                       ),
  //
  //                                     ),
  //                                     PopupMenuItem(
  //                                       height: 40,
  //                                       onTap: (){
  //                                         Navigator.push(context, MaterialPageRoute(builder: (context) => AddSymbol(),));
  //                                       },
  //                                       child:  Container(
  //                                         width: screenWidth(context)*0.46,
  //                                         padding: const EdgeInsets.fromLTRB(10, 4, 10,4),
  //                                         decoration: BoxDecoration(
  //                                           color: const Color(0xff6d9eeb),
  //                                           borderRadius: BorderRadius.circular(4),
  //                                         ),
  //                                         child: const CommonKhandText(
  //                                           title: "Add Symbol",
  //                                           textAlign: TextAlign.center,
  //                                           textColor: Colors.white,
  //                                           fontWeight: FontWeight.w400,
  //                                           fontSize: 15,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 );
  //                               },
  //                               child: Container(
  //                                 height: 40,
  //                                 decoration:   BoxDecoration(
  //                                     color: Colors.black.withOpacity(0.5),
  //                                     shape: BoxShape.circle
  //                                 ),
  //                                 child: Row(
  //                                   mainAxisAlignment: MainAxisAlignment.center,
  //                                   crossAxisAlignment: CrossAxisAlignment.center,
  //                                   children: [
  //                                     Container(
  //                                       height:7,
  //                                       width: 7,
  //                                       decoration:   BoxDecoration(
  //                                           color: Colors.white,
  //                                           shape: BoxShape.circle
  //                                       ),
  //                                     ),
  //                                     horizontalSpace(2),
  //                                     Container(
  //                                       height:7,
  //                                       width: 7,
  //                                       decoration:   BoxDecoration(
  //                                           color: Colors.white,
  //                                           shape: BoxShape.circle
  //                                       ),
  //                                     ),
  //                                     horizontalSpace(2),
  //                                     Container(
  //                                       height:7,
  //                                       width: 7,
  //                                       decoration:   BoxDecoration(
  //                                           color: Colors.white,
  //                                           shape: BoxShape.circle
  //                                       ),
  //                                     )
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 verticalSpace(15),
  //                 Container(
  //                   width: screenWidth(context),
  //                   padding: EdgeInsets.all(10),
  //                   decoration:    BoxDecoration(
  //                     color: Colors.black.withOpacity(0.2),
  //                     borderRadius: BorderRadius.all(Radius.circular(11)),
  //                     // image: DecorationImage(image: AssetImage(AssetUtils.posterCheck),fit: BoxFit.fill)
  //                   ),
  //                   child:Column(
  //                     children: [
  //                       MyTextField(controller:nameCtr,labelText: "Name*",),
  //                       Container(
  //                         height: 1.5,
  //                         width: screenWidth(context),
  //                         color: Colors.white,
  //                       ),
  //                       MyTextField(
  //                         controller: positionAreaCtr,
  //                         labelText: "Position & Area*",
  //                       ),
  //                       Container(
  //                         height: 1.5,
  //                         width: screenWidth(context),
  //                         color: Colors.white,
  //                       ),
  //                       MyTextField(
  //                         controller: positionAreaCtr,
  //                         labelText: "Party Name*",
  //                       ),
  //                       Container(
  //                         height: 1.5,
  //                         width: screenWidth(context),
  //                         color: Colors.white,
  //                       ),
  //                       MyTextField(
  //                         controller: evmSerialNoCtr,
  //                         labelText: "EVM Serial No (optional)*",
  //                       ),
  //                       Container(
  //                         height: 1.5,
  //                         width: screenWidth(context),
  //                         color: Colors.white,
  //                       ),
  //                       MyTextField(
  //                         controller: positionAreaCtr,
  //                         labelText: "WhatsApp (Optional)*",
  //                       ),
  //                       Container(
  //                         height: 1.5,
  //                         width: screenWidth(context),
  //                         color: Colors.white,
  //                       ),
  //                       MyTextField(
  //                         controller: facebookCtr,
  //                         labelText: "Facebook*",
  //                       ),
  //                       Container(
  //                         height: 1.5,
  //                         width: screenWidth(context),
  //                         color: Colors.white,
  //                       ),
  //                       MyTextField(controller: twitterIdCtr,labelText: "Twitter*",),
  //                       Container(
  //                         height: 1.5,
  //                         width: screenWidth(context),
  //                         color: Colors.white,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 verticalSpace(15),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //   },
  // ),
