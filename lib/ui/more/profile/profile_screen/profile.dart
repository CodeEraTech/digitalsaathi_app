import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/data/model/profile_model.dart';
import 'package:digitalsaathi/provider/profile_provider.dart';
import 'package:digitalsaathi/ui/more/more_screen.dart';
import 'package:digitalsaathi/ui/more/profile/add_facebook.dart';
import 'package:digitalsaathi/ui/more/profile/add_instagram.dart';
import 'package:digitalsaathi/ui/more/profile/add_twitter.dart';
import 'package:digitalsaathi/ui/more/profile/add_youtube.dart';
import 'package:digitalsaathi/ui/more/profile/faqs.dart';
import 'package:digitalsaathi/ui/more/profile/follow_mla.dart';
import 'package:digitalsaathi/ui/more/profile/id_card.dart';
import 'package:digitalsaathi/ui/more/profile/personal_details.dart';
import 'package:digitalsaathi/ui/more/profile/profile_ui/profile_ui.dart';
import 'package:digitalsaathi/ui/more/profile/voter.dart';
import 'package:digitalsaathi/constants/components/pro_text.dart';
import 'package:digitalsaathi/ui/more/progress/progress_screen.dart';
import 'package:digitalsaathi/ui/notification/notification_screen.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utils/color_utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProfileProvider>(context,listen: false).getProfile();
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
        title:   CommonKhandText(
          title: "Profile",
          textColor:themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorWhite,
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),
        actions: [
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(8),
              color: Colors.black.withOpacity(0.2),
              shape: BoxShape.circle,

            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen(),));
              },
              child: const Center(  // Center the Icon widget here
                child: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Consumer<ProfileProvider>(
        builder: (context,profileProvider,_) {
          return Stack(
            children: [
              profileProvider.profileData==null?SizedBox.shrink():Container(
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 2,
                        shadowColor: Colors.blue,
                        margin: const EdgeInsets.only(top: 20),
                        shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration:  BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: profileProvider.profileData!.userProfilePicture.isEmpty?AssetImage(AssetUtils.AddYouTube):NetworkImage(AppUrl.BASE_IMAGE_URL+profileProvider.profileData!.userProfilePicture),
                                  fit: BoxFit.fill
                              )
                          ),
                        ),
                      ),
                      verticalSpace(10),
                      Container(
                        width: screenWidth(context) * 0.5,
                        alignment: Alignment.center,
                        child:  CommonKhandText(
                          title: profileProvider.profileData!.fullName,
                          textColor: themeProvider.darkTheme ? ColorUtils.colorWhite : ColorUtils.colorWhite ,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      verticalSpace(14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProfileUi(
                            navigateTo: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalDetails(profileData: profileProvider.profileData!,),));
                            },
                            contentImage: AssetUtils.PersonalDetails,
                            contentName: "Personal Details",
                          ),
                          ProfileUi(
                            navigateTo: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => IdCard(),));
                            },
                            contentImage: AssetUtils.IdCard,
                            contentName: "ID Card",

                          )
                        ],
                      ),
                      verticalSpace(14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProfileUi(
                            navigateTo: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProgressScreen(),));
                            },
                            contentImage: AssetUtils.Progress,
                            contentName: "Progress",
                          ),
                          ProfileUi(
                            navigateTo: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => FollowMla(),));
                            },
                            contentImage: AssetUtils.FollowMlaMp,
                            contentName: "Follow MLA/MP",
                          )
                        ],
                      ),
                      verticalSpace(14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProfileUi(
                            navigateTo: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Faqs(),));
                            },
                            contentImage: AssetUtils.Faqs,
                            contentName: "Faqs",
                          ),
                          ProfileUi(
                            navigateTo: () {
                              AppRedirector().openOrDownloadApp();
                              // launchUrl(Uri.parse("https://newdgs.mydigitalsaathi.com/download-app"));

                            },
                            contentImage: AssetUtils.Voter,
                            contentName: "Voter",
                          )
                        ],
                      ),
                      verticalSpace(14)
                    ],
                  ),
                ),
              ),
              profileProvider.isLoading?CustomLoader():SizedBox.shrink()
            ],
          );
        }
      ),
    );
  }
}
