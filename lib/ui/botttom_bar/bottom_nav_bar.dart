import 'package:digitalsaathi/constants/enum/TabEnum.dart';
import 'package:digitalsaathi/provider/home_provider.dart';
import 'package:digitalsaathi/ui/botttom_bar/widget/CrystalNavigationBar.dart';
import 'package:digitalsaathi/ui/botttom_bar/widget/CryystalNavigationBarItem.dart';
import 'package:digitalsaathi/ui/comming_soon.dart';
import 'package:digitalsaathi/ui/home/home_screen.dart';
import 'package:digitalsaathi/ui/more/more_screen.dart';
import 'package:digitalsaathi/ui/more/timeline/create_timeline.dart';
import 'package:digitalsaathi/ui/notification/notification_screen.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BottomNavBar extends StatefulWidget {
  const   BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  var _selectedTab = SelectedTab.add;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = SelectedTab.values[i];
    });
    Provider.of<HomeProvider>(context,listen: false).getNotificationCount();
    if(i ==2){
      Provider.of<HomeProvider>(context,listen: false).getAllFeeds(context);
    }

    // if (SelectedTab.values[i] == SelectedTab.createTimeLine) {
    //   showCreateTimelineBottomSheet;
    // }
  }

  // void showCreateTimelineBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     barrierColor: Colors.transparent,
  //     backgroundColor: Colors.black,
  //     builder: (ctx) => Container(
  //       height: MediaQuery.of(ctx).size.height * 0.83,
  //       decoration: const BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
  //       ),
  //       child: CreateTimeLine(),
  //     ),
  //   );
  // }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomeProvider>(context,listen: false).getNotificationCount();
    Provider.of<HomeProvider>(context,listen: false).getAllFeeds(context);

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBody: true,
      body:Consumer<HomeProvider>(
        builder: (context,homeProvider,_) {
          return SizedBox(
            height: screenHeight(context),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  _selectedTab==SelectedTab.add?HomeScreen()
                      :_selectedTab==SelectedTab.notification?NotificationScreen()
                      :_selectedTab==SelectedTab.person?MoreScreen()
                      :_selectedTab==SelectedTab.createTimeLine?CreateTimeLine():CommingSoon(),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: CrystalNavigationBar(
                      // itemPadding: EdgeInsets.only(top: 10,bottom: 10,left: 10),
                      // marginR: EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 20),
                      borderRadius: 100,
                      enableFloatingNavBar: true,
                      currentIndex: SelectedTab.values.indexOf(_selectedTab),
                      // indicatorColor: Colors.white,
                      unselectedItemColor: Colors.white70,
                      backgroundColor: Colors.black.withOpacity(0.1),
                      // outlineBorderColor: Colors.black.withOpacity(0.1),

                      onTap: _handleIndexChanged,
                      items: [
                        /// Home

                        /// Favourite
                        CrystalNavigationBarItem(
                          icon: Icons.wifi,
                          unselectedIcon: Icons.wifi,
                          selectedColor: ColorUtils.primaryColor,
                          notificationCount: 0,

                        ),

                        /// Add
                        CrystalNavigationBarItem(
                          // icon: Icons.file_copy,
                            icon: Icons.notifications,
                          unselectedIcon: Icons.notifications,
                          selectedColor:ColorUtils.primaryColor,
                            notificationCount: homeProvider.unreadNotificationCount,
                        ),

                        CrystalNavigationBarItem(
                          icon: Icons.home,
                          unselectedIcon: Icons.home_outlined,
                          selectedColor: ColorUtils.primaryColor,
                            notificationCount: 0
                        ),

                        /// Search
                        // CrystalNavigationBarItem(
                        //     icon: Icons.notifications,
                        //     unselectedIcon: Icons.notifications_none,
                        //     selectedColor: ColorUtils.primaryColor,
                        //     notificationCount: homeProvider.unreadNotificationCount,
                        // ),


                        /// create timeLine
                        CrystalNavigationBarItem(
                            icon:  Icons.feed_outlined,
                            unselectedIcon: Icons.feed_outlined,
                            selectedColor: ColorUtils.primaryColor,
                          notificationCount:0,
                        ),

                        /// Profile
                        CrystalNavigationBarItem(
                            icon: Icons.dashboard,
                            unselectedIcon: Icons.dashboard_outlined,
                            selectedColor: ColorUtils.primaryColor,
                            notificationCount: 0
                        ),
                      ],
                    ),
                  )

                ],
              ));
        }
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(bottom: 10),
      //   child: CrystalNavigationBar(
      //     enableFloatingNavBar: true,
      //     currentIndex: SelectedTab.values.indexOf(_selectedTab),
      //     // indicatorColor: Colors.white,
      //     unselectedItemColor: Colors.white70,
      //     backgroundColor: Colors.black.withOpacity(0.1),
      //     // outlineBorderColor: Colors.black.withOpacity(0.1),
      //     onTap: _handleIndexChanged,
      //     items: [
      //       /// Home
      //
      //
      //       /// Favourite
      //       CrystalNavigationBarItem(
      //         icon: Icons.heart_broken,
      //         unselectedIcon: Icons.heart_broken_outlined,
      //         selectedColor: ColorUtils.primaryColor,
      //       ),
      //
      //       /// Add
      //       CrystalNavigationBarItem(
      //         icon: Icons.add_a_photo_rounded,
      //         unselectedIcon: Icons.add_a_photo_outlined,
      //         selectedColor:ColorUtils.primaryColor,
      //       ),
      //
      //       CrystalNavigationBarItem(
      //         icon: Icons.home,
      //         unselectedIcon: Icons.home_outlined,
      //         selectedColor: ColorUtils.primaryColor,
      //       ),
      //
      //       /// Search
      //       CrystalNavigationBarItem(
      //           icon: Icons.search_off,
      //           unselectedIcon: Icons.search,
      //           selectedColor: ColorUtils.primaryColor),
      //
      //       /// Profile
      //       CrystalNavigationBarItem(
      //         icon: Icons.person,
      //         unselectedIcon: Icons.person_2_outlined,
      //         selectedColor: ColorUtils.primaryColor,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}


