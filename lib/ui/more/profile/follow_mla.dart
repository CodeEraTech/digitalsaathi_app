import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/constants/components/pro_text.dart';
import 'package:digitalsaathi/provider/follow_provider.dart';
import 'package:digitalsaathi/ui/more/chat_screen/chat_screen.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/theme_provider.dart';
import '../../../utils/color_utils.dart';

class FollowMla extends StatefulWidget {
  const FollowMla({super.key});

  @override
  State<FollowMla> createState() => _FollowMlaState();
}

class _FollowMlaState extends State<FollowMla> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FollowProvider>(context,listen: false).getMLAList();
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
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title:  const CommonKhandText(
          title: "FOLLOW",
          textColor: Color(0xffffffff),
          fontWeight: FontWeight.w300,
          fontSize: 17,
        ),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 8),
          //   child: GestureDetector(
          //     onTap: (){},
          //     child: const CommonKhandText(
          //       title: "DONE",
          //       textColor: Color(0xffffffff),
          //       fontWeight: FontWeight.w300,
          //       fontSize: 17,
          //     ),
          //   ),
          // ),
        ],
      ),

      body: Consumer<FollowProvider>(
        builder: (context,followProvider,_) {
          return Container(
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
                SafeArea(
                  child: Column(
                    children: [
                      verticalSpace(10),
                      searchWidget(followProvider),
                      verticalSpace(10),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: DynamicHeightGridView(
                            shrinkWrap: true,
                            rowCrossAxisAlignment: CrossAxisAlignment.start,
                            itemCount: followProvider.filterFollowMlaData.length,
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            builder: (context, index) {
                              return Stack(
                                children: [
                                  Card(
                                    margin: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 3,
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(10,6,10,6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: const DecorationImage(
                                          image: AssetImage(AssetUtils.screenBackgroundOne),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       // mainAxisSize: MainAxisSize.min, // Allow the height to adjust
                                        children: [
                                          Column(
                                            children: [
                                              Card(
                                                margin: EdgeInsets.zero,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(40),
                                                ),
                                                elevation: 4,
                                                child: Container(
                                                  height: 80,
                                                  width: 80,
                                                  decoration:  BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: followProvider.filterFollowMlaData[index].userProfilePicture.toString().isEmpty?AssetImage(AssetUtils.profilePng):NetworkImage(AppUrl.BASE_IMAGE_URL+followProvider.filterFollowMlaData[index].userProfilePicture),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              verticalSpace(5),
                                              CommonKhandText(
                                                title: "${followProvider.filterFollowMlaData[index].name.toString()}",
                                                textColor: Color(0xffffffff),
                                                textAlign: TextAlign.center,
                                                fontSize: 15,
                                              ),
                                              verticalSpace(5),
                                              Container(
                                                width: screenWidth(context),
                                                alignment: Alignment.center,
                                                child: CommonKhandText(
                                                  title: "${followProvider.filterFollowMlaData[index].followers.toString()} Followers",
                                                  textColor: ColorUtils.errorColor,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              verticalSpace(10),
                                            ],
                                          ),
                                          // if(followProvider.filterFollowMlaData[index].followed != 1)
                                          // GestureDetector(
                                          //   onTap: (){
                                          //     followProvider.followMLA(index, followProvider.filterFollowMlaData[index].followed==0?1:followProvider.filterFollowMlaData[index].followed);
                                          //   },
                                          //   child: Container(
                                          //     height: 30,
                                          //     padding: const EdgeInsets.only(top: 3, bottom: 3),
                                          //     decoration: BoxDecoration(
                                          //       borderRadius: BorderRadius.circular(5),
                                          //       color: Colors.blue.withOpacity(0.7),
                                          //     ),
                                          //     child: Center(
                                          //       child: CommonKhandText(
                                          //         title: "Follow",
                                          //         textColor: Color(0xffffffff),
                                          //         fontSize: 17,
                                          //         fontWeight: FontWeight.w500,
                                          //       ),
                                          //     ),
                                          //   ),
                                          // )
                                          followProvider.filterFollowMlaData[index].followed != 1
                                              ? GestureDetector(
                                            onTap: () {
                                              followProvider.followMLA(
                                                index,
                                                followProvider.filterFollowMlaData[index].followed == 0 ? 1 : followProvider.filterFollowMlaData[index].followed,
                                              );
                                            },
                                            child: Container(
                                              height: 30,
                                              padding: const EdgeInsets.only(top: 3, bottom: 3),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.blue.withOpacity(0.7),
                                              ),
                                              child: const Center(
                                                child: CommonKhandText(
                                                  title: "Follow",
                                                  textColor: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ): GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => ChatScreen(
                                                      chattingWithUserId: followProvider.filterFollowMlaData[index].id,
                                                      userName: followProvider.filterFollowMlaData[index].name),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: 30,
                                              padding: const EdgeInsets.only(top: 3, bottom: 3),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.green.withOpacity(0.8),
                                              ),
                                              child: const Center(
                                                child: CommonKhandText(
                                                  title: "Chat",
                                                  textColor: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      height: 25,
                                      width: 35,
                                     // margin: EdgeInsets.only(top: 10,left:60),
                                      decoration:  BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(6),bottomRight: Radius.circular(6))
                                      ),child:  Center(
                                      child: Text(followProvider.filterFollowMlaData[index].userType.toString().contains("National")?"NH":followProvider.filterFollowMlaData[index].userType.toString().contains("State")?"SH":followProvider.filterFollowMlaData[index].userType.toString().contains("Worker")?"WA":followProvider.filterFollowMlaData[index].userType.toString(),
                                      style: TextStyle(color: ColorUtils.primaryColor,fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    ),
                                  ),
                                  if(followProvider.filterFollowMlaData[index].followed == 1)
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        margin: EdgeInsets.only(top: 10,left:60),
                                        decoration: const BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                        ),child: const Center(
                                        child: Icon(Icons.check,color: Colors.white,),
                                      ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      verticalSpace(10)
                    ],
                  ),
                ),

                followProvider.isLoading?CustomLoader():SizedBox.shrink()
              ],
            ),
          );
        }
      ),
    );
  }

  TextEditingController tcSearch = TextEditingController();
  Widget searchWidget(FollowProvider followProvider) {
    return Container(
      height: 39,
      margin: EdgeInsets.only(left: 10,right: 10),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: tcSearch,
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: ColorUtils.colorWhite),
        onChanged: (val) {
           followProvider.onMlaSearch(val.toString());
          //widget.orderController.onSearch(val);
        },
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          prefixIcon: Icon(
            Icons.search,
            color: ColorUtils.primaryColor,
          ),
          suffixIcon: InkWell(
            onTap: () {
              tcSearch.text = '';
              followProvider.onMlaSearch("");
            },
            child: Icon(
              Icons.clear,
              color: ColorUtils.errorColor,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorUtils.colorWhite,
            ),
          ),
          hintText: 'Search Here...',
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
          filled: true,
          fillColor: ColorUtils.colorBlack,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: ColorUtils.colorWhite,
            ),
          ),
        ),
      ),
    );
  }
}
