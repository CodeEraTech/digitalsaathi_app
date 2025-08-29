import 'package:digitalsaathi/ui/notification/notification_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants/components/pro_text.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/color_utils.dart';
class NotificationDetailsScreen extends StatefulWidget {
  final String imagePath;
  final String message;
  final String fromName;
  final String createdAt;
  final notificationenum  notificationType ;
  final String? popupimage ;
  final String? type ;
  final String? event ;
  const NotificationDetailsScreen({super.key, required this.imagePath, required this.message, required this.fromName, required this.createdAt, required this.notificationType, this.popupimage,required this.type,required this.event});

  @override
  State<NotificationDetailsScreen> createState() => _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
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
        title: CommonKhandText(
          title: "Notification Details",
          textColor: Color(0xffffffff),
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),
      ),
      body: Container(
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
              Color(0xFF606060),
            ],
          ),
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  // padding: const EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(
                    top: 23,
                    left: 10,right: 10,bottom: 10
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: ColorUtils.colorWhite
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: ColorUtils.colorBlack,
                              child: Image.asset(
                                widget.imagePath ,
                                height: 50,
                                color: ColorUtils.colorWhite,
                              ),
                            ),
                          ),
                          horizontalSpace(8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.fromName}",
                                style: const TextStyle(fontSize: 14,fontWeight:FontWeight.w600,color: ColorUtils.colorBlack),
                              ),
                              Text(
                                "${widget.createdAt}",
                                style: const TextStyle(fontSize: 13,fontWeight:FontWeight.w500,color: ColorUtils.colorBlack),
                              ),
                            ],
                          )
                        ],
                      ),
                      verticalSpace(10),
                      // Text.rich(
                      //   TextSpan(
                      //     children: [
                      //       TextSpan(
                      //         text: "${widget.message}",
                      //         style: TextStyle(
                      //           fontSize: 15,
                      //           fontWeight: FontWeight.w400,
                      //           color: ColorUtils.colorBlack,
                      //         ),
                      //       ),
                      //       if(widget.notificationType == notificationenum.popupNotification)
                      //       TextSpan(
                      //         text: 'Popup Event',
                      //         style: TextStyle(
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.bold,
                      //           color: ColorUtils.errorColor,
                      //         ),
                      //       ),
                      //       if(widget.notificationType == notificationenum.customNotification)
                      //         TextSpan(
                      //           text: 'Custom',
                      //           style: TextStyle(
                      //             fontSize: 15,
                      //             fontWeight: FontWeight.bold,
                      //             color: ColorUtils.errorColor,
                      //           ),
                      //         ),
                      //     ],
                      //   ),
                      // ),
                      if(widget.type.toString() == "special")
                        widget.event!.isNotEmpty?Row(
                          children: [
                            Text(
                              "Event : ",
                              style: TextStyle(
                                  fontSize: 14, color: ColorUtils.primaryColor),
                            ),
                            Text(
                              "${widget.event}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: ColorUtils.colorBlack),
                            ),
                          ],
                        ):SizedBox.square(),
                      Text(
                        "${widget.message}",
                        style: const TextStyle(fontSize: 15,fontWeight:FontWeight.w400,color: ColorUtils.colorBlack),
                      ),
                      verticalSpace(10),
                      if(widget.notificationType == notificationenum.popupNotification)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            widget.popupimage.toString(),
                            // width: 200,
                            // height: 200,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Text(
                                "Loading...",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: ColorUtils.colorBlack),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.error);
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 7,bottom: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: ColorUtils.colorBlack
                  ),
                  child: Column(
                    children: [
                      if(widget.notificationType == notificationenum.popupNotification)
                        CommonKhandText(
                          title: "Popup Event",
                          textColor: Color(0xffffffff),
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      if(widget.notificationType == notificationenum.customNotification)
                        CommonKhandText(
                          title: "Custom",
                          textColor: Color(0xffffffff),
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
