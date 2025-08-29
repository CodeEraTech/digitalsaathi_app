import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants/components/pro_text.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utils/color_utils.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.darkTheme ?  ColorUtils.colorBlack: ColorUtils.lightTheme,
      appBar: AppBar(
        surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorBlack :  ColorUtils.appBarColor ,
        backgroundColor: themeProvider.darkTheme ? ColorUtils.colorBlack :  ColorUtils.appBarColor ,         centerTitle: true,
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
          title: "Events",
          textColor: Color(0xffffffff),
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
                onTap: (){
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const RaiseComplaint(),
                  //   ),
                  // );
                },
                child: CommonKhandText(
                        title: "Create Event",
                        textColor: Color(0xffffffff),
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                ),
            )
          )
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(10),
              Container(
                margin: const EdgeInsets.all(10),
                width: screenWidth(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  gradient:  LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      themeProvider.darkTheme ? Color(0xff181818): Color.fromRGBO(13, 125, 246, 1) ,
                      themeProvider.darkTheme ?Color.fromRGBO(63, 61, 61, 1): Color.fromRGBO(222, 230, 225, 1),
                    ],
                    stops: [0.0, 1.0], // Stops to match 0% and 100%
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            height: 44,
                            width: 45,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(AssetUtils.myPic),
                                    fit: BoxFit.fill)),
                          ),
                          horizontalSpace(15),
                          Container(
                            padding: const EdgeInsets.only(bottom: 7),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CommonKhandText(
                                  title: "TESTIMP TW1",
                                  textColor: Color(0xffffffff),
                                  fontWeight: FontWeight.w500,
                                  fontSize:17,
                                ),
                                CommonKhandText(
                                  title: "11 jul 2024 4:58  PM",
                                  textColor:Color(0xffffffff),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: screenWidth(context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient:  LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(9, 9, 9, 1)
                                : const Color.fromRGBO(6, 108, 219, 0.8897934173669468),
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(63, 61, 61, 1)
                                : const Color.fromRGBO(216, 222, 218, 1),
                          ],
                          stops: const [0.0, 1.0], // Stops to match 0% and 100%
                        ),
                        // image: const DecorationImage(image: AssetImage(AssetUtils.bgMlaFollow),fit:BoxFit.fill)
                      ),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(5),
                          CommonKhandText(
                            title: "Block Meeting",
                            textColor: Color(0xffffffff),
                            fontWeight: FontWeight.w500,
                            fontSize:16,
                          ),
                          verticalSpace(8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonKhandText(
                                title: "Event Date",
                                textColor: Color(0xffffffff),
                                fontWeight: FontWeight.w300,
                                fontSize:15,
                              ),
                              CommonKhandText(
                                title: "Event Time",
                                textColor: Color(0xffffffff),
                                fontWeight: FontWeight.w300,
                                fontSize:15,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CommonKhandText(
                                title: "11-7-2024",
                                textColor: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize:13,
                              ),
                              CommonKhandText(
                                title: "1:00 PM",
                                textColor: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize:13,
                              ),
                            ],
                          ),
                          verticalSpace(8),
                          Container(
                            height: 45,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(5),
                                  bottomLeft: Radius.circular(5)
                              ),
                              // image: DecorationImage(image: AssetImage(AssetUtils.bgCardFour),fit: BoxFit.fill)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){},
                                  child: Row(
                                    children: [
                                      // const Image(image: AssetImage(AssetUtils.FBLikeButton),height: 20,),
                                      const Icon(
                                        Icons.favorite_outline,
                                        color: Colors.white,
                                      ),
                                      horizontalSpace(5),
                                      const CommonKhandText(
                                        title: "Like",
                                        textColor: const Color(0xffffffff),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){},
                                  child: Row(
                                    children: [
                                      const Image(
                                        image: AssetImage(AssetUtils.CommentIcon),
                                        height: 25,
                                      ),
                                      horizontalSpace(5),
                                      const CommonKhandText(
                                        title: "Comment",
                                        textColor:  Color(0xffffffff),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){},
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_on,size: 25,color: Colors.white,),
                                      horizontalSpace(5),
                                      const CommonKhandText(
                                        title: "Location",
                                        textColor: const Color(0xffffffff),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                width: screenWidth(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black.withOpacity(0.2),
                  // image: DecorationImage(image: AssetImage(AssetUtils.bgCardFive),fit: BoxFit.fill)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration:  BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)
                          ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(9, 9, 9, 1)
                                : const Color.fromRGBO(6, 108, 219, 0.8897934173669468),
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(63, 61, 61, 1)
                                : const Color.fromRGBO(216, 222, 218, 1),
                          ],
                          stops: const [0.0, 1.0], // Stops to match 0% and 100%
                        ),
                          // color: Colors.black.withOpacity(0.2),
                          // image: DecorationImage(image: AssetImage("assets/profile_images/event_card_bg.jpg"),fit: BoxFit.fill)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 44,
                                width: 45,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(AssetUtils.myPic),
                                        fit: BoxFit.fill)),
                              ),
                              horizontalSpace(15),
                              Container(
                                padding: const EdgeInsets.only(bottom: 7),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CommonKhandText(
                                      title: "TESTIMP TW1",
                                      textColor: Color(0xffffffff),
                                      fontWeight: FontWeight.w500,
                                      fontSize:17,
                                    ),
                                    CommonKhandText(
                                      title: "11 jul 2024 4:58  PM",
                                      textColor:Color(0xffffffff),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(5),
                          const CommonKhandText(
                            title: "Road Show",
                            textColor: Color(0xffffffff),
                            fontWeight: FontWeight.w500,
                            fontSize:14,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height:screenHeight(context)*0.65,
                      width: screenWidth(context),
                      // color: Colors.red.withOpacity(0.2),
                      decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/profile_images/event_test.jpg"),fit: BoxFit.fill)
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
