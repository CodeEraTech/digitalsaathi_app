// import 'package:digitalsaathi/constants/components/loader.dart';
// import 'package:digitalsaathi/provider/notification_provider.dart';
// import 'package:digitalsaathi/ui/more/meeting/meeting_screen/meeting_screen.dart';
// import 'package:digitalsaathi/ui/more/poster/poster.dart';
// import 'package:digitalsaathi/ui/more/task/task.dart';
// import 'package:digitalsaathi/ui/notification/notification_details_screen.dart';
// import 'package:digitalsaathi/utils/asset_utils.dart';
// import 'package:digitalsaathi/utils/date_formatter.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:screenshot/screenshot.dart';
//
// import '../../../../constants/components/pro_text.dart';
// import '../../../../provider/theme_provider.dart';
// import '../../../../utils/app_utils.dart';
// import '../../../../utils/color_utils.dart';
//
// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});
//
//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Provider.of<NotificationProvider>(context, listen: false).getAllNotification();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<DarkThemeProvider>(context);
//     return Scaffold(
//       backgroundColor: themeProvider.darkTheme
//           ? ColorUtils.colorBlack
//           : ColorUtils.lightTheme,
//       appBar: AppBar(
//         surfaceTintColor: themeProvider.darkTheme
//             ? ColorUtils.colorBlack
//             : ColorUtils.appBarColor,
//         backgroundColor: themeProvider.darkTheme
//             ? ColorUtils.colorBlack
//             : ColorUtils.appBarColor,
//         centerTitle: true,
//         elevation: 4,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//              InkWell(
//                onTap: (){
//                  Provider.of<NotificationProvider>(context, listen: false)
//                      .deleteAllNotification();
//                },
//                child: CommonKhandText(
//                 title: "CLEAR ALL",
//                 textColor: ColorUtils.errorColor,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 12,
//                            ),
//              ),
//             const CommonKhandText(
//               title: "Notifications",
//               textColor: Color(0xffffffff),
//               fontWeight: FontWeight.w300,
//               fontSize: 18,
//             ),
//              InkWell(
//                  onTap: (){
//                    Provider.of<NotificationProvider>(context, listen: false)
//                        .readAllNotification();
//                  },
//                child: CommonKhandText(
//                 title: "READ ALL",
//                 textColor: ColorUtils.colorGreen,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 12,
//                            ),
//              ),
//           ],
//         ),
//       ),
//       body:
//           Consumer<NotificationProvider>(builder: (context, notifyProvider, _) {
//         return Stack(
//           children: [
//             Container(
//               height: screenHeight(context),
//               width: screenWidth(context),
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   stops: [0.112, 0.789, 1.0],
//                   colors: [
//                     Color(0xFF000000), // Black
//                     Color(0xFF3F3D3D), // Dark Grey
//                     Color(0xFF606060), // Medium Grey
//                   ],
//                 ),
//               ),
//               child: Container(
//                 padding: EdgeInsets.all(4),
//                 child: ListView.builder(
//                     itemCount: notifyProvider.notificationData.length,
//                     itemBuilder: (context, index) {
//                       return Stack(
//                         children: [
//                           Card(
//                             child: ListTile(
//                               onTap: () {
//                                 notifyProvider.markAsRead(notifyProvider.notificationData[index], index).then((val){
//                                   onCardTap(notifyProvider
//                                       .notificationData[index].type.type
//                                       .toString(),notifyProvider
//                                       .notificationData[index].type.role_id
//                                       .toString()
//                                   );
//                                 });
//
//                               },
//                               leading: ClipRRect(
//                                 borderRadius: BorderRadius.circular(100),
//                                 child: CircleAvatar(
//                                     radius: 20,
//                                     backgroundColor: ColorUtils.colorBlack,
//                                     child: Image.asset(
//                                       AssetUtils.logoPng,
//                                       height: 50,
//                                       color: ColorUtils.colorWhite,
//                                     )),
//                               ),
//                               title: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       "${notifyProvider.notificationData[index].msg}",
//                                       style: TextStyle(fontSize: 14),
//                                     ),
//                                   ),
//
//                                   InkWell(
//                                       onTap: (){
//                                         notifyProvider.deleteOneNotification(notifyProvider.notificationData[index].notificationId.toString(), index);
//                                       },
//                                       child: Icon(Icons.delete,color: ColorUtils.errorColor,size: 20,))
//                                 ],
//                               ),
//                               subtitle: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   RichText(
//                                       text: TextSpan(
//                                           text: "SENDER : ",
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               color: ColorUtils.primaryColor),
//                                           children: [
//                                         TextSpan(
//                                           text:
//                                               "${notifyProvider.notificationData[index].fromName}",
//                                           style: TextStyle(
//                                               fontSize: 12,
//                                               color: ColorUtils.colorBlack),
//                                         )
//                                       ])),
//                                   Text(
//                                     DateFormatter.getTimeAgo(
//                                         DateFormat("yyyy-MM-dd HH:mm:ss").parse(
//                                             notifyProvider
//                                                 .notificationData[index]
//                                                 .createdAt)),
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.grey),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           notifyProvider.notificationData[index].readStatus.toString() ==
//                                   "0"
//                               ? Image.asset(
//                                   "assets/images/new.png",
//                                   height: 20,
//                                 )
//                               : SizedBox.shrink()
//                         ],
//                       );
//                     }),
//               ),
//             ),
//             notifyProvider.isLoading
//                 ? const CustomLoader()
//                 : const SizedBox.shrink()
//           ],
//         );
//       }),
//     );
//   }
//
//   onCardTap(String value,String roleId) {
//
//     switch (value) {
//       case "POSTER":
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => PosterScreen())).then((v){
//           Provider.of<NotificationProvider>(context, listen: false)
//               .getAllNotification();
//         });
//         break;
//
//       case "Meeting":
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => MeetingScreen())).then((v){
//           Provider.of<NotificationProvider>(context, listen: false)
//               .getAllNotification();
//         });
//         break;
//
//       case "Custom":
//         break;
//
//       case "custom":
//         Navigator.push(context, MaterialPageRoute(builder: (context) =>NotificationDetailsScreen() ,));
//
//         break;
//
//       default:
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => TaskScreen(initialTabIndex: int.parse(roleId),))).then((v){
//           Provider.of<NotificationProvider>(context, listen: false)
//               .getAllNotification();
//         });
//         break;
//
//     }
//   }
// }


import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/provider/notification_provider.dart';
import 'package:digitalsaathi/ui/more/meeting/meeting_screen/meeting_screen.dart';
import 'package:digitalsaathi/ui/more/poster/poster.dart';
import 'package:digitalsaathi/ui/more/task/task.dart';
import 'package:digitalsaathi/ui/notification/notification_details_screen.dart';
import 'package:digitalsaathi/ui/notification/notification_enum.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:digitalsaathi/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../constants/components/pro_text.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/color_utils.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NotificationProvider>(context, listen: false).getAllNotification();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.darkTheme
          ? ColorUtils.colorBlack
          : ColorUtils.lightTheme,
      appBar: AppBar(
        surfaceTintColor: themeProvider.darkTheme
            ? ColorUtils.colorBlack
            : ColorUtils.appBarColor,
        backgroundColor: themeProvider.darkTheme
            ? ColorUtils.colorBlack
            : ColorUtils.appBarColor,
        centerTitle: true,
        elevation: 4,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Provider.of<NotificationProvider>(context, listen: false).deleteAllNotification();
              },
              child: CommonKhandText(
                title: "CLEAR ALL",
                textColor: ColorUtils.errorColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const CommonKhandText(
              title: "Notifications",
              textColor: Color(0xffffffff),
              fontWeight: FontWeight.w300,
              fontSize: 18,
            ),
            InkWell(
              onTap: () {
                Provider.of<NotificationProvider>(context, listen: false)
                    .readAllNotification();
              },
              child: CommonKhandText(
                title: "READ ALL",
                textColor: ColorUtils.colorGreen,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, notifyProvider, _) {
          return Stack(
            children: [
              Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: ListView.builder(
                    itemCount: notifyProvider.notificationData.length,
                    itemBuilder: (context, index) {
                      final notification = notifyProvider.notificationData[index];
                      return Stack(
                        alignment: Alignment.topLeft,

                        children: [
                          Card(
                            child: ListTile(
                              onTap: () {
                                // notifyProvider.markAsRead(notifyProvider.notificationData[index], index).then((val){
                                //   onCardTap(
                                //       notifyProvider.notificationData[index].type.type.toString(),
                                //       notifyProvider.notificationData[index].type.role_id.toString()
                                //   );
                                // });

                                notifyProvider.markAsRead(notification, index).then((val) {
                                  onCardTap(notification, index);
                                });


                              },
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: ColorUtils.colorBlack,
                                  child: Image.asset(
                                    AssetUtils.logoPng,
                                    height: 50,
                                    color: ColorUtils.colorWhite,
                                  ),
                                ),
                              ),
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${notification.msg}",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      notifyProvider.deleteOneNotification(
                                          notification.notificationId.toString(), index);
                                    },
                                    child: Icon(Icons.delete, color: ColorUtils.errorColor, size: 20),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: "SENDER : ",
                                          style: TextStyle(
                                              fontSize: 12, color: ColorUtils.primaryColor),
                                          children: [
                                            TextSpan(
                                              text: "${notification.fromName}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: ColorUtils.colorBlack),
                                            )
                                          ],
                                        ),
                                      ),
                                      Text(
                                        DateFormatter.getTimeAgo(
                                          DateFormat("yyyy-MM-dd HH:mm:ss")
                                              .parse(notification.createdAt),
                                        ),
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  if(notification.type.type.toString() == "special")
                                    notification.event_name.isNotEmpty?Row(
                                    children: [
                                      Text(
                                        "Event : ",
                                        style: TextStyle(
                                            fontSize: 14, color: ColorUtils.primaryColor),
                                      ),
                                      Text(
                                        "${notification.event_name}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: ColorUtils.colorBlack),
                                      ),
                                    ],
                                  ):SizedBox.square(),
                                  if(notification.type.type.toString() == "custom")
                                    Row(
                                      children: [
                                        Text(
                                          "Type : ",
                                          style: TextStyle(
                                              fontSize: 12, color: ColorUtils.primaryColor),
                                        ),
                                        Text(
                                          "Custom",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: ColorUtils.colorBlack),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                          notification.readStatus.toString() == "0"
                              ? Image.asset(
                                "assets/images/new.png",
                                height: 20,
                              )
                              : const SizedBox.shrink(),
                        ],
                      );
                    },
                  ),
                ),
              ),
              notifyProvider.isLoading
                  ? const CustomLoader()
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }

  // onCardTap(String value,String roleId) {
  //
  //   switch (value) {
  //     case "POSTER":
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => PosterScreen())).then((v){
  //         Provider.of<NotificationProvider>(context, listen: false)
  //             .getAllNotification();
  //       });
  //       break;
  //
  //     case "Meeting":
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => MeetingScreen())).then((v){
  //         Provider.of<NotificationProvider>(context, listen: false)
  //             .getAllNotification();
  //       });
  //       break;
  //
  //     case "Custom":
  //       break;
  //
  //     case "custom":
  //       // Navigator.push(context, MaterialPageRoute(builder: (context) =>NotificationDetailsScreen() ,));
  //       break;
  //
  //     default:
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => TaskScreen(initialTabIndex: int.parse(roleId),))).then((v){
  //         Provider.of<NotificationProvider>(context, listen: false)
  //             .getAllNotification();
  //       });
  //       break;
  //
  //   }
  // }


  void onCardTap(var notification, int index) {
    String value = notification.type.type.toString();
    String roleId = notification.type.role_id.toString();

    switch (value) {
      case "POSTER":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PosterScreen()),
        ).then((v) {
          Provider.of<NotificationProvider>(context, listen: false)
              .getAllNotification();
        });
        break;

      case "Meeting":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MeetingScreen()),
        ).then((v) {
          Provider.of<NotificationProvider>(context, listen: false)
              .getAllNotification();
        });
        break;

      case "Custom":
        break;

      case "custom":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationDetailsScreen(
              imagePath: AssetUtils.logoPng,
              message: notification.msg,
              fromName: notification.fromName,
              createdAt : notification.createdAt,
              notificationType: notificationenum.customNotification,
              type: notification.type.type.toString(),
              event: notification.event_name,
            ),
          ),
        );
        break;
      case "special":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationDetailsScreen(
              notificationType:notificationenum.popupNotification,
                imagePath: AssetUtils.logoPng,
                message: notification.msg,
                fromName: notification.fromName,
                createdAt : notification.createdAt,
                popupimage :  notification.imagelink,
              type: notification.type.type.toString(),
              event: notification.event_name,
            ),
          ),
        );
        break;

      default:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TaskScreen(initialTabIndex: int.parse(roleId)),
          ),
        ).then((v) {
          Provider.of<NotificationProvider>(context, listen: false)
              .getAllNotification();
        });
        break;
    }
  }
}
