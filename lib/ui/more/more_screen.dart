// import 'package:android_intent_plus/android_intent.dart';
import 'dart:io';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:digitalsaathi/provider/home_provider.dart';
import 'package:digitalsaathi/ui/authentication_screen/login_screen.dart';
import 'package:digitalsaathi/ui/more/chat_screen/followed_mla_screen.dart';
import 'package:digitalsaathi/ui/more/content/content.dart';
import 'package:digitalsaathi/ui/more/logout/logout_screen.dart';
import 'package:digitalsaathi/ui/more/meeting/meeting_screen/meeting_screen.dart';
import 'package:digitalsaathi/ui/more/meeting_report/meeting_report_screen.dart';
import 'package:digitalsaathi/ui/more/news_letter/news_letter_screen.dart';
import 'package:digitalsaathi/ui/more/poster/poster.dart';
import 'package:digitalsaathi/ui/more/profile/follow_mla.dart';
import 'package:digitalsaathi/ui/more/profile/profile_screen/profile.dart';
import 'package:digitalsaathi/ui/more/progress/progress_screen.dart';
import 'package:digitalsaathi/ui/more/suggestions/suggestion_screen.dart';
import 'package:digitalsaathi/ui/more/task/task.dart';
import 'package:digitalsaathi/ui/more/timeline/create_timeline.dart';
import 'package:digitalsaathi/ui/more/worker_report/worker_report_screen.dart';
import 'package:digitalsaathi/ui/notification/notification_screen.dart';
import 'package:digitalsaathi/ui/theme_toggle_switch/theme_toggle_switch.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:digitalsaathi/utils/prefrence/pref_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/components/pro_text.dart';
import '../../provider/theme_provider.dart';
import 'complaint_screen/complaint/complaint_screen.dart';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';


class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomeProvider>(context,listen: false).getNotificationCount();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: themeProvider.darkTheme ?  ColorUtils.colorBlack: ColorUtils.lightTheme,
        //backgroundColor: ColorUtils.colorBlack,
      //   appBar: AppBar(
      //     automaticallyImplyLeading: false,
      //     // leading: Container(
      //     //   height: 30,
      //     //   width: 30,
      //     //   margin: const EdgeInsets.all(8),
      //     //   padding: const EdgeInsets.only(left: 8),
      //     //   decoration: BoxDecoration(
      //     //       color: Colors.black.withOpacity(0.2),
      //     //       shape: BoxShape.circle
      //     //   ),
      //     //   child: GestureDetector(
      //     //     onTap: () {
      //     //       Navigator.pop(context);
      //     //     },
      //     //     child: const Center(  // Center the Icon widget here
      //     //       child: Icon(
      //     //         Icons.arrow_back_ios,
      //     //         color: Colors.white,
      //     //       ),
      //     //     ),
      //     //   ),
      //     // ),
      //     surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorBlack :  ColorUtils.colorBlack ,
      //     backgroundColor: themeProvider.darkTheme ? ColorUtils.colorBlack :  ColorUtils.colorBlack ,
      // ),
      body: Container(

        padding: const EdgeInsets.only(bottom: 60,top: 40),
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
        child: ListView(
          padding: EdgeInsets.only(bottom:90),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){

                    //  i.setData(Uri.parse("https://twitter.com/intent/tweet?text=" + urlEncode(message)));
                      //launchUrl(Uri.parse("https://twitter.com/intent/tweet?text=Hello"));
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TaskScreen(initialTabIndex: 0,)),
                      );
                      // Navigator.pushNamed(context, RoutesName.taskScreen);
                    } ,
                    child: Card(
                      color: const Color(0xffE5D9F2),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(6,8,6,8),
                        child: Column(
                          children: [
                            Image.asset(AssetUtils.taskPng,height: 40,color: Color(0xff3913f8),),
                            const SizedBox(height: 6,),
                            CommonKhandText(
                              title: "Task",
                              textColor: Color(0xff3913f8),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            // Text("Task",style: TextStyle(color: Color(0xff3913f8)),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ContentScreen()),
                      );
                    } ,
                    child: Card(
                      color: Color(0xfff2d9db),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(6,8,6,8),
                        child: Column(
                          children: [
                            Image.asset(AssetUtils.contentPng,height: 40,color: Color(
                                0xfffa132f),),
                            const SizedBox(height: 6,),
                            CommonKhandText(
                              title: "Content",
                              textColor: Color(0xfffa132f),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            // Text("Content",style: TextStyle(color: Color(0xfffa132f)),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PosterScreen()),
                      );
                    } ,
                    child: Card(color: Color(0xffd9f0f2),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(6,8,6,8),
                        child: Column(
                          children: [
                            Image.asset(AssetUtils.posterPng,height: 40,color: Color(
                                0xff13ddf8),),
                            const SizedBox(height: 6,),
                            CommonKhandText(
                              title: "Poster",
                              textColor: Color(0xff13ddf8),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            // const Text("Poster",style: TextStyle(color: Color(0xff13ddf8)),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewsLetterScreen()),
                      );
                    } ,
                    child: Card(
                      color: Color(0xffedd9f2),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(6,8,6,8),
                        child: Column(
                          children: [
                            Image.asset(AssetUtils.newsPng,height: 40,color: Color(
                                0xffcc16f6),),
                            const SizedBox(height: 6,),
                            CommonKhandText(
                              title: "Newsletter",
                              textColor: Color(0xffc415f5),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            // Text("Newsletter",style: TextStyle(color: Color(0xffc415f5)),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(color: ColorUtils.primaryColor,),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)
              ),
              surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorWhite :  ColorUtils.colorWhite ,
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context) => ProfileScreen(),));
                },
                leading: Image.asset(AssetUtils.profilePng,color: ColorUtils.primaryColor,height: 30,),
                title:  CommonKhandText(
                  title: "Profile",
                  textColor: themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
                trailing: const Icon(Icons.arrow_forward_ios,color: ColorUtils.primaryColor),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)
              ),
              surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorWhite :  ColorUtils.colorWhite ,
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FollowMla(),));
                },
                leading: Image.asset('assets/images/follow_mla_mp_icon.png',color: ColorUtils.primaryColor,height: 30,),
                title:  CommonKhandText(
                  title: "Follow MLA/MP",
                  textColor: themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
                trailing: Icon(Icons.arrow_forward_ios,color: ColorUtils.primaryColor),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)
              ),
              surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorWhite :  ColorUtils.colorWhite ,
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context) => FollowedMLAScreen(),));
                },
                leading: Image.asset(AssetUtils.chatPng,color: ColorUtils.primaryColor,height: 30,),
                title:  CommonKhandText(
                  title: "Chat With Follwed MLA/MP",
                  textColor: themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
                trailing: const Icon(Icons.arrow_forward_ios,color: ColorUtils.primaryColor),
              ),
            ),


            // Card(
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(7)
            //   ),
            //   surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorWhite :  ColorUtils.colorWhite ,
            //   child: ListTile(
            //     onTap: (){
            //       // Navigator.push(
            //       //   context,
            //       //   MaterialPageRoute(builder: (context) =>ProgressScreen()),
            //       // );
            //       showModalBottomSheet(
            //         context: context,
            //         isScrollControlled: true,
            //         barrierColor: Colors.transparent,
            //         backgroundColor: Colors.black,
            //         builder: (ctx) => Container(
            //           // margin: EdgeInsets.only(top: 60),
            //           height: MediaQuery.of(ctx).size.height * 0.83,
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            //           ),
            //           child: CreateTimeLine(),
            //         ),
            //       );
            //
            //       // showModalBottomSheet(
            //       //
            //       //     barrierColor: Colors.transparent,
            //       //     context: context,
            //       //     builder: (ctx) =>
            //       //         CreateTimeLine()
            //       // );
            //     },
            //     leading: Image.asset(AssetUtils.posterPng,color: ColorUtils.primaryColor,height: 30,),
            //     title:  CommonKhandText(
            //       title: "Create Timeline",
            //       textColor: themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorBlack,
            //       fontWeight: FontWeight.w400,
            //       fontSize: 18,
            //     ),
            //     trailing: Icon(Icons.arrow_forward_ios,color: ColorUtils.primaryColor),
            //   ),
            // ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)
              ),
              surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorWhite :  ColorUtils.colorWhite ,
              child: ListTile(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>ProgressScreen()),
                  );
                },
                leading: Image.asset(AssetUtils.progressPng,color: ColorUtils.primaryColor,height: 30,),
                title:  CommonKhandText(
                  title: "Progress",
                  textColor: themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
                trailing: Icon(Icons.arrow_forward_ios,color: ColorUtils.primaryColor),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)
              ),
              surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorWhite :  ColorUtils.colorWhite ,
              child: ListTile(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WorkerReportScreen()),
                  );
                },
                leading: Image.asset(AssetUtils.workerReportPng,color: ColorUtils.primaryColor,height: 30,),
                title:  CommonKhandText(
                  title: "Worker Report",
                  textColor: themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
                trailing: const Icon(Icons.arrow_forward_ios,color: ColorUtils.primaryColor),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)
              ),
              surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorWhite :  ColorUtils.colorWhite ,
              child: ListTile(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MeetingScreen()),
                  );
                },
                leading: Image.asset(AssetUtils.meetingPng,color: ColorUtils.primaryColor,height: 30,),
                title:  CommonKhandText(
                  title: "Meeting",
                  textColor: themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
                trailing: Icon(Icons.arrow_forward_ios,color: ColorUtils.primaryColor),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)
              ),
              surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorWhite :  ColorUtils.colorWhite ,
              child: ListTile(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MeetingReportScreen()),
                  );
                },
                leading: Image.asset(AssetUtils.meetingReportPng,color: ColorUtils.primaryColor,height: 30,),
                title:  CommonKhandText(
                  title: "Meeting Report",
                  textColor: themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
                trailing: Icon(Icons.arrow_forward_ios,color: ColorUtils.primaryColor),
              ),
            ),

            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)
              ),
              surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorWhite :  ColorUtils.colorWhite ,
              child: ListTile(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ComplaintScreen(createType: "Complaint",)),
                  );
                },
                leading: Image.asset(AssetUtils.complainPng,color: ColorUtils.primaryColor,height: 30,),
                title:  CommonKhandText(
                  title: "Complaint",
                  textColor: themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
                trailing: Icon(Icons.arrow_forward_ios,color: ColorUtils.primaryColor),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)
              ),
              surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorWhite :  ColorUtils.colorWhite ,
              child: ListTile(
                onTap: (){
                  AppRedirector().openOrDownloadApp();
                },
                // onTap: openOrDownloadApp,
                // onTap: _launchUrl,
                // onTap: ()async{
                //  await AppLauncher.launchOrDownloadApp();
                // },
                leading: const Icon(Icons.download,
                    color: ColorUtils.primaryColor, size: 30),
                // leading: Image.asset(AssetUtils.meetingReportPng,color: ColorUtils.primaryColor,height: 30,),
                title:  CommonKhandText(
                  title: "Download Voter App",
                  textColor: themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
                trailing: Icon(Icons.arrow_forward_ios,color: ColorUtils.primaryColor),
              ),
            ),

            Stack(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  surfaceTintColor: themeProvider.darkTheme
                      ? ColorUtils.colorWhite
                      : ColorUtils.colorWhite,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => NotificationScreen()));
                    },
                    leading: const Icon(Icons.notifications_active_outlined,
                        color: ColorUtils.primaryColor, size: 30),
                    title: CommonKhandText(
                      title: "Notifications",
                      textColor: themeProvider.darkTheme
                          ? ColorUtils.colorWhite
                          : ColorUtils.colorBlack,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: ColorUtils.primaryColor),
                  ),
                ),

                Positioned(
                  top: 8,
                  left: 8,
                  child: Consumer<HomeProvider>(
                    builder: (context, homeProvider, _) {
                      return homeProvider.unreadNotificationCount > 0
                          ? Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorUtils.errorColor,
                        ),
                        child: Text(
                          "${homeProvider.unreadNotificationCount}",
                          style: const TextStyle(
                            color: ColorUtils.colorWhite,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ): const SizedBox();
                    },
                  ),
                ),
              ],
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)
              ),
              surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorWhite :  ColorUtils.colorWhite ,
              child: ListTile(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ComplaintScreen(createType: "Suggestion",)),
                  );
                },
                leading: Image.asset(AssetUtils.suggestionPng,color: ColorUtils.primaryColor,height: 30,),
                title:  CommonKhandText(
                  title: "Suggestions",
                  textColor: themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
                trailing: Icon(Icons.arrow_forward_ios,color: ColorUtils.primaryColor),
              ),
            ),
            // Card(
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(7)
            //   ),
            //   surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorWhite :  ColorUtils.colorWhite ,
            //   child: ListTile(
            //     onTap: (){
            //       Navigator.push(context, MaterialPageRoute(builder:(context) => Events(),));
            //     },
            //     leading: Image.asset(AssetUtils.profilePng,color: ColorUtils.primaryColor,height: 30,),
            //     title:  CommonKhandText(
            //       title: "Events",
            //       textColor: themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorBlack,
            //       fontWeight: FontWeight.w400,
            //       fontSize: 18,
            //     ),
            //     trailing: Icon(Icons.arrow_forward_ios,color: ColorUtils.primaryColor),
            //   ),
            // ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)
              ),
              surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorWhite :  ColorUtils.colorWhite ,
              child: ListTile(
                leading:const Icon(Icons.dark_mode_outlined,color: ColorUtils.primaryColor,size: 25,),
                  title:  CommonKhandText(
                    title: "Dark Theme",
                    textColor: themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorBlack,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                trailing:ThemeToggleSwitch()
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)
              ),
              surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorWhite :  ColorUtils.colorWhite ,
              child: ListTile(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        title: const Text('Logout User'),
                        content: const Text(
                            'Do you want to logout?'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: const Text('Cancel',style: TextStyle(color: ColorUtils.colorBlack)),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          CupertinoDialogAction(
                            child: const Text('Logout',style: TextStyle(color: ColorUtils.primaryColor),),
                            onPressed: () async{
                           //   Navigator.pop(context);
                              PrefUtils.setToken('');
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                              // openAppSettings();
                            },
                          ),
                        ],
                      ));

                },
                leading: Image.asset(AssetUtils.logoutPng,color: ColorUtils.primaryColor,height: 30,),
                title:  CommonKhandText(
                  title: "Logout",
                  textColor: themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorBlack,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                ),
                trailing: Icon(Icons.arrow_forward_ios,color: ColorUtils.primaryColor),
              ),
            ),
          ],
        ),
      )
    );
  }

  final Uri _url = Uri.parse('https://ds.mydigitalsaathi.com/download-app');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

}

class AppRedirector {

  void printAllAppPackages() async {
    List<AppInfo> apps = await InstalledApps.getInstalledApps(true, true);
    for (var app in apps) {
      debugPrint("Installed: ${app.name} => ${app.packageName}");
    }
  }

  void launchAnotherApp({
    required String mlaAssemblyId,
    required String mpConstituencyId,
    required String authToken,
  }) {
    if (Platform.isAndroid) {
      final intent = AndroidIntent(
       // componentName: 'com.ebiz.digitalsaathivoter',
        componentName: 'com.ebiz.digitalsaathivoter.SplashScreen',
        action: 'action_view',
        package: 'com.ebiz.digitalsaathivoter',
        arguments: {
          'mla_assembly_id': mlaAssemblyId,
          'mp_constituency_id': mpConstituencyId,
          'auth': authToken,
        },
      );

      intent.launch();
    }
  }

  Future<void> openOrDownloadApp() async {
    final String packageName = 'com.ebiz.digitalsaathivoter';
    final Uri downloadUrl = Uri.parse('https://ds.mydigitalsaathi.com/download-app');

    try {
      bool isInstalled = (await InstalledApps.isAppInstalled(packageName)) ?? false;
      debugPrint("App Installed: $isInstalled");

      if (isInstalled) {
        debugPrint("Trying to open app...");
        // await InstalledApps.startApp(packageName);
        launchAnotherApp(
            mlaAssemblyId: PrefUtils.getMlaAssemblyId(),
            mpConstituencyId: PrefUtils.getMpConstituencyId(),
            authToken: PrefUtils.getToken()
        );
      } else {
        debugPrint("Redirecting to download link...");
        if (!await launchUrl(downloadUrl, mode: LaunchMode.externalApplication)) {
          throw Exception('Could not launch $downloadUrl');
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}



