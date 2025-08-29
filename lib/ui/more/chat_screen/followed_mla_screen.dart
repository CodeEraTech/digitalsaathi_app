import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/data/model/follow_list_response.dart';
import 'package:digitalsaathi/provider/follow_provider.dart';
import 'package:digitalsaathi/provider/theme_provider.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/constants/components/pro_text.dart';
import 'package:digitalsaathi/ui/more/chat_screen/chat_screen.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
class FollowedMLAScreen extends StatefulWidget {
  @override
  State<FollowedMLAScreen> createState() => _FollowedMLAScreenState();
}

class _FollowedMLAScreenState extends State<FollowedMLAScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FollowProvider>(context,listen: false).getMLAList();
  }

  @override
  Widget build(BuildContext context) {
    final followProvider = Provider.of<FollowProvider>(context);
    // final followedList = followProvider.filterFollowMlaData.where((mla) => mla.followed == 1).toList();
    final followedList = followProvider.filterFollowMlaData
        .where((mla) => mla.followed == 1)
        .fold<Map<String, FollowMlaData>>({}, (map, mla) {
      map.putIfAbsent(mla.name, () => mla);
      return map;
    })
        .values
        .toList();

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
          title: "Followed MLAs/MP",
          textColor: Color(0xffffffff),
          fontWeight: FontWeight.w300,
          fontSize: 17,
        ),
      ),
      body: Consumer<FollowProvider>(
          builder: (context,followProvider,_) {
            return Container(
              height: screenHeight(context),
              width: screenWidth(context),
              padding: const EdgeInsets.all(10),
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

                DynamicHeightGridView(
                  shrinkWrap: true,
                  rowCrossAxisAlignment: CrossAxisAlignment.start,
                  itemCount: followedList.length,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  builder: (context, index) {
                      final mla = followedList[index];
                      return Card(
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
                                          image: mla.userProfilePicture.toString().isEmpty?AssetImage(AssetUtils.profilePng):NetworkImage(AppUrl.BASE_IMAGE_URL+mla.userProfilePicture.toString()),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  verticalSpace(5),
                                  CommonKhandText(
                                    title: mla.name,
                                    textColor: Color(0xffffffff),
                                    textAlign: TextAlign.center,
                                    fontSize: 15,
                                  ),
                                  verticalSpace(5),
                                  Container(
                                    width: screenWidth(context),
                                    alignment: Alignment.center,
                                    child: CommonKhandText(
                                      title: "${mla.followers} Followers",
                                      textColor: ColorUtils.errorColor,
                                      textAlign: TextAlign.center,
                                      fontSize: 14,
                                    ),
                                  ),
                                  verticalSpace(10),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ChatScreen(
                                        chattingWithUserId: mla.id,
                                        userName: mla.name,
                                      ),
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
                      );
                    },
                  ),
                  followProvider.isLoading?CustomLoader():SizedBox.shrink()
                ],
              ),
            );
          }
      ),
    );
  }
}



