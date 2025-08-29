import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/data/model/task_data_response.dart';
import 'package:digitalsaathi/provider/task_provider.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/date_formatter.dart';
import 'package:digitalsaathi/utils/social_type_enum.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../constants/components/pro_text.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utils/asset_utils.dart';
import '../../../../utils/color_utils.dart';

class TaskListTabView extends StatelessWidget {
  final Function(String) navigateTo;
  final Function(String) viewOnly;
  final Tasks taskData;

  const TaskListTabView({
    super.key,
    required this.navigateTo,required this.viewOnly, required this.taskData,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return Container(
      width: screenWidth(context),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        // image: const DecorationImage(
        //     image: AssetImage(AssetUtils.bgMlaFollow), fit: BoxFit.fill
        // )
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            themeProvider.darkTheme
                ? Color(0xff100C08)
                : const Color.fromRGBO(6, 108, 219, 0.8897934173669468),
            themeProvider.darkTheme ? Colors.grey
                : const Color.fromRGBO(216, 222, 218, 1),
          ],
          stops: const [0.0, 1.0], // Stops to match 0% and 100%
        ),

      ),
      child: taskData.socialType == "YOUTUBE"?getYoutubeWidget(themeProvider, context):taskData.socialType == "TWITTER" ? getTwitterWidget(
          themeProvider, context) : taskData.socialType == "FACEBOOK"
          ? getFaceBookWidget(themeProvider, context)
          : taskData.socialType == "INSTAGRAM" ? getInstagramWidget(
          themeProvider, context) : taskData.socialType == "WHATSAPP"
          ? getWhatsAppWidget(themeProvider, context)
          : taskData.socialType == "TWITTERTREND" ? getTwitterTrendWidget(
          themeProvider, context) : getOtherWidget(themeProvider, context),
    );
  }

  Widget getYoutubeWidget(DarkThemeProvider themeProvider,
      BuildContext context)
  {
    String title = "";
    String url = "";
    if (taskData.postPreviewData.description!.isNotEmpty) {
      title = taskData.postPreviewData.description!;
      if (taskData.postPreviewData.cover!.isNotEmpty) {
        url = taskData.postPreviewData.cover!;
      } else if (taskData.postPreviewData.images!.isNotEmpty) {
        url = taskData.postPreviewData.images![0].toString().replaceAll(
            "//", "/");
      }
    } else {
      title = taskData.postMessage;
    }
    return GestureDetector(
      onTap: (){
        navigateTo("YOUTUBE");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CommonKhandText(
                    title: taskData.userName,
                    textColor: const Color(0xffffffff),
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                  ),
                ),
                CommonKhandText(
                  title: DateFormatter.getFormattedDateTime(taskData.postCreatedTime.toString()),
                  textColor: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.zero,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            child: Container(
              // padding: const EdgeInsets.all(8),
              width: screenWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                // image: const DecorationImage(
                //     image: AssetImage(AssetUtils.bgMlaFollow),
                //     fit: BoxFit.fill
                // )
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

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(9),
                        image: DecorationImage(
                            image: NetworkImage(url),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Container(
                      width: screenWidth(context),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        // image: const DecorationImage(
                        //     image: AssetImage(AssetUtils.bgMlaFollow),
                        //     fit: BoxFit.fill
                        // )
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(9, 9, 9, 1)
                                : const Color.fromRGBO(
                                6, 108, 219, 0.8897934173669468),
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(63, 61, 61, 1)
                                : const Color.fromRGBO(216, 222, 218, 1),
                          ],
                          stops: const [0.0, 1.0], // Stops to match 0% and 100%
                        ),
                      ),
                      child: Column(
                        children: [
                          CommonKhandText(
                            title: title,
                            textColor: Color(0xffffffff),
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),

                          verticalSpace(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   CommonKhandText(
                                    title: DateFormatter.getTimeDifference(taskData.endDate),
                                    textColor: ColorUtils.errorColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                                               ),

                                   CommonKhandText(
                                     title: taskData.points.toString()+" Points",
                                     textColor: ColorUtils.colorBlack,
                                     fontWeight: FontWeight.w300,
                                     fontSize: 15,
                                   ),
                                 ],
                               ),


                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      navigateTo("YOUTUBE");
                                    },
                                    child: Card(
                                      elevation: 2,
                                      // margin: EdgeInsets.only(top: 12,bottom: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),

                                      ),
                                      child: Container(
                                        height: 30,
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, top: 3, bottom: 3),
                                        // width: MediaQuery.of(context).size.width*0.9,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: taskData.showDone==1?ColorUtils.orangeAccent:Color(0xff3cb371)),
                                        child:  Center(
                                            child: CommonKhandText(
                                              title: taskData.showDone==1?"Confirm":"Share On Youtube",
                                              fontWeight: FontWeight.w300,
                                              textColor: ColorUtils.colorWhite,
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  horizontalSpace(6),
                                  Visibility(
                                    visible: taskData.showDone==1,
                                    child: GestureDetector(
                                      onTap: () {
                                        viewOnly("YOUTUBE-VIEW");
                                      },
                                      child: Card(
                                        elevation: 2,
                                        // margin: EdgeInsets.only(top: 12,bottom: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),

                                        ),
                                        child: Container(
                                          height: 30,
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, top: 3, bottom: 3),
                                          // width: MediaQuery.of(context).size.width*0.9,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              color: Colors.green),
                                          child:  Center(
                                              child: CommonKhandText(
                                                title: "View",
                                                fontWeight: FontWeight.w300,
                                                textColor: ColorUtils.colorWhite,
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getInstagramWidget(DarkThemeProvider themeProvider,
      BuildContext context)
  {
    bool isShare = false;
    print("instagram ${taskData.postImg}");
    return GestureDetector(
      onTap: (){
        navigateTo("INSTAGRAM");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CommonKhandText(
                    title: taskData.userName,
                    textColor: const Color(0xffffffff),
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                  ),
                ),
                CommonKhandText(
                  title: DateFormatter.getFormattedDateTime(taskData.postCreatedTime.toString()),
                  textColor: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.zero,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            child: Container(
              // padding: const EdgeInsets.all(8),
              width: screenWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                // image: const DecorationImage(
                //     image: AssetImage(AssetUtils.bgMlaFollow),
                //     fit: BoxFit.fill
                // )
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

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(9),
                        image: DecorationImage(
                            image: taskData.postImg.toString().isEmpty?AssetImage(AssetUtils.Instagram):NetworkImage(taskData.postImg),
                            fit: taskData.postImg.toString().isEmpty?BoxFit.contain:BoxFit.cover
                        )
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Container(
                      width: screenWidth(context),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        // image: const DecorationImage(
                        //     image: AssetImage(AssetUtils.bgMlaFollow),
                        //     fit: BoxFit.fill
                        // )
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(9, 9, 9, 1)
                                : const Color.fromRGBO(
                                6, 108, 219, 0.8897934173669468),
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(63, 61, 61, 1)
                                : const Color.fromRGBO(216, 222, 218, 1),
                          ],
                          stops: const [0.0, 1.0], // Stops to match 0% and 100%
                        ),
                      ),
                      child: Column(
                        children: [
                          CommonKhandText(
                            title: taskData.postLink.toString(),
                            textColor: Color(0xffffffff),
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),


                          verticalSpace(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   CommonKhandText(
                                    title: DateFormatter.getTimeDifference(taskData.endDate),
                                    textColor:ColorUtils.errorColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                                               ),
                                   CommonKhandText(
                                     title: taskData.points.toString()+" Points",
                                     textColor: ColorUtils.colorBlack,
                                     fontWeight: FontWeight.w300,
                                     fontSize: 15,
                                   ),
                                 ],
                               ),

                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      navigateTo("INSTAGRAM");
                                    },
                                    child: Card(
                                      elevation: 2,
                                      // margin: EdgeInsets.only(top: 12,bottom: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),

                                      ),
                                      child: Container(
                                        height: 30,
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, top: 3, bottom: 3),
                                        // width: MediaQuery.of(context).size.width*0.9,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: taskData.showDone==1?ColorUtils.orangeAccent:Color(0xff3cb371)),
                                        child:  Center(
                                            child: CommonKhandText(
                                              title: taskData.showDone==1?"Confirm":"Like & Share",
                                              fontWeight: FontWeight.w300,
                                              textColor: ColorUtils.colorWhite,
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  horizontalSpace(6),
                                  Visibility(
                                    visible: taskData.showDone==1,
                                    child: GestureDetector(
                                      onTap: () {
                                        viewOnly("INSTAGRAM-VIEW");
                                      },
                                      child: Card(
                                        elevation: 2,
                                        // margin: EdgeInsets.only(top: 12,bottom: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),

                                        ),
                                        child: Container(
                                          height: 30,
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, top: 3, bottom: 3),
                                          // width: MediaQuery.of(context).size.width*0.9,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              color: Colors.green),
                                          child:  Center(
                                              child: CommonKhandText(
                                                title: "View",
                                                fontWeight: FontWeight.w300,
                                                textColor: ColorUtils.colorWhite,
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getFaceBookWidget(DarkThemeProvider themeProvider,
      BuildContext context)
  {
    return GestureDetector(
      onTap: (){
        navigateTo("FACEBOOK");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CommonKhandText(
                    title: taskData.userName,
                    textColor: const Color(0xffffffff),
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                  ),
                ),
                CommonKhandText(
                  title: DateFormatter.getFormattedDateTime(taskData.postCreatedTime.toString()),
                  textColor: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.zero,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            child: Container(
              // padding: const EdgeInsets.all(8),
              width: screenWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                // image: const DecorationImage(
                //     image: AssetImage(AssetUtils.bgMlaFollow),
                //     fit: BoxFit.fill
                // )
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

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(9),
                        image: DecorationImage(
                            image: taskData.postImg.isEmpty ? AssetImage(
                                AssetUtils.Facebook) : NetworkImage(
                                taskData.postImg),
                            fit: taskData.postImg.isEmpty?BoxFit.contain:BoxFit.cover
                        )
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Container(
                      width: screenWidth(context),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        // image: const DecorationImage(
                        //     image: AssetImage(AssetUtils.bgMlaFollow),
                        //     fit: BoxFit.fill
                        // )
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(9, 9, 9, 1)
                                : const Color.fromRGBO(
                                6, 108, 219, 0.8897934173669468),
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(63, 61, 61, 1)
                                : const Color.fromRGBO(216, 222, 218, 1),
                          ],
                          stops: const [0.0, 1.0], // Stops to match 0% and 100%
                        ),
                      ),
                      child: Column(
                        children: [
                          CommonKhandText(
                            title: taskData.postLink.toString(),
                            textColor: Color(0xffffffff),
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),

                          verticalSpace(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonKhandText(
                                    title: DateFormatter.getTimeDifference(taskData.endDate),
                                    textColor: ColorUtils.errorColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                  ),

                                  CommonKhandText(
                                    title: taskData.points.toString()+" Points",
                                    textColor: ColorUtils.colorBlack,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      navigateTo("FACEBOOK");
                                    },
                                    child: Card(
                                      elevation: 2,
                                      // margin: EdgeInsets.only(top: 12,bottom: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),

                                      ),
                                      child: Container(
                                        height: 30,
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, top: 3, bottom: 3),
                                        // width: MediaQuery.of(context).size.width*0.9,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: taskData.showDone==1?ColorUtils.orangeAccent:Color(0xff3cb371)),
                                        child:  Center(
                                            child: CommonKhandText(
                                              title: taskData.showDone==1?"Confirm":"Like & Share",
                                              fontWeight: FontWeight.w300,
                                              textColor: ColorUtils.colorWhite,
                                            )
                                        ),
                                      ),
                                    ),
                                  ),

                                  horizontalSpace(6),
                                  Visibility(
                                    visible: taskData.showDone==1,
                                    child: GestureDetector(
                                      onTap: () {
                                        viewOnly("FACEBOOK-VIEW");
                                      },
                                      child: Card(
                                        elevation: 2,
                                        // margin: EdgeInsets.only(top: 12,bottom: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),

                                        ),
                                        child: Container(
                                          height: 30,
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, top: 3, bottom: 3),
                                          // width: MediaQuery.of(context).size.width*0.9,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              color: Colors.green),
                                          child:  Center(
                                              child: CommonKhandText(
                                                title: "View",
                                                fontWeight: FontWeight.w300,
                                                textColor: ColorUtils.colorWhite,
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getWhatsAppWidget(DarkThemeProvider themeProvider,
      BuildContext context)
  {
    return GestureDetector(
      onTap: (){
        navigateTo("WHATSAPP");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CommonKhandText(
                    title: taskData.userName,
                    textColor: const Color(0xffffffff),
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                  ),
                ),
                CommonKhandText(
                  title: DateFormatter.getFormattedDateTime(taskData.postCreatedTime.toString()),
                  textColor: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.zero,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            child: Container(
              // padding: const EdgeInsets.all(8),
              width: screenWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                // image: const DecorationImage(
                //     image: AssetImage(AssetUtils.bgMlaFollow),
                //     fit: BoxFit.fill
                // )
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

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(9),
                        image: DecorationImage(
                          image: taskData.postMedia.isEmpty ? AssetImage(
                              AssetUtils.Whatsapp) : NetworkImage(
                              AppUrl.BASE_SOCIAL_MEDIAATTACHMENT_W +
                                  taskData.postMedia),
                          //fit: BoxFit.fill
                        )
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Container(
                      width: screenWidth(context),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        // image: const DecorationImage(
                        //     image: AssetImage(AssetUtils.bgMlaFollow),
                        //     fit: BoxFit.fill
                        // )
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(9, 9, 9, 1)
                                : const Color.fromRGBO(
                                6, 108, 219, 0.8897934173669468),
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(63, 61, 61, 1)
                                : const Color.fromRGBO(216, 222, 218, 1),
                          ],
                          stops: const [0.0, 1.0], // Stops to match 0% and 100%
                        ),
                      ),
                      child: Column(
                        children: [


                          verticalSpace(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonKhandText(
                                    title: DateFormatter.getTimeDifference(taskData.endDate),
                                    textColor: ColorUtils.errorColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                  ),

                                  CommonKhandText(
                                    title: taskData.points.toString()+" Points",
                                    textColor: ColorUtils.colorBlack,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () async {
                                  navigateTo("WHATSAPP");
                                },
                                child: Card(
                                  elevation: 2,
                                  // margin: EdgeInsets.only(top: 12,bottom: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),

                                  ),
                                  child: Container(
                                    height: 30,
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 3, bottom: 3),
                                    // width: MediaQuery.of(context).size.width*0.9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: taskData.showDone==1?ColorUtils.orangeAccent:Color(0xff3cb371)),
                                    child:  Center(
                                        child: CommonKhandText(
                                          title: taskData.showDone==1?"Confirm":"Share On Whatsapp",
                                          fontWeight: FontWeight.w300,
                                          textColor: ColorUtils.colorWhite,
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getTwitterWidget(DarkThemeProvider themeProvider,
      BuildContext context)
  {
    String title = "";
    String url = "";
    if (taskData.postPreviewData.description!.isNotEmpty) {
      title = taskData.postPreviewData.description!;
      if (taskData.postPreviewData.cover!.isNotEmpty) {
        url = taskData.postPreviewData.cover!;
      } else if (taskData.postPreviewData.images!.isNotEmpty) {
        url = taskData.postPreviewData.images![0].toString().replaceAll(
            "//", "/");
      }
    } else {
      title = taskData.postMessage;
      url = taskData.postImg;
    }
    return GestureDetector(
      onTap: (){
        navigateTo("TWITTER");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CommonKhandText(
                    title: taskData.userName,
                    textColor: const Color(0xffffffff),
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                  ),
                ),
                CommonKhandText(
                  title: DateFormatter.getFormattedDateTime(taskData.postCreatedTime.toString()),
                  textColor: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.zero,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            child: Container(
              // padding: const EdgeInsets.all(8),
              width: screenWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                // image: const DecorationImage(
                //     image: AssetImage(AssetUtils.bgMlaFollow),
                //     fit: BoxFit.fill
                // )
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

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(9),
                        image: DecorationImage(
                          image: url.isEmpty
                              ? AssetImage(AssetUtils.Twitter)
                              : NetworkImage(url),
                          //fit: BoxFit.cover
                        )
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Container(
                      width: screenWidth(context),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        // image: const DecorationImage(
                        //     image: AssetImage(AssetUtils.bgMlaFollow),
                        //     fit: BoxFit.fill
                        // )
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(9, 9, 9, 1)
                                : const Color.fromRGBO(
                                6, 108, 219, 0.8897934173669468),
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(63, 61, 61, 1)
                                : const Color.fromRGBO(216, 222, 218, 1),
                          ],
                          stops: const [0.0, 1.0], // Stops to match 0% and 100%
                        ),
                      ),
                      child: Column(
                        children: [
                          CommonKhandText(
                            title: title,
                            textColor: Color(0xffffffff),
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),

                          verticalSpace(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonKhandText(
                                    title: DateFormatter.getTimeDifference(taskData.endDate),
                                    textColor: ColorUtils.errorColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                  ),

                                  CommonKhandText(
                                    title: taskData.points.toString()+" Points",
                                    textColor: ColorUtils.colorBlack,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      navigateTo("TWITTER");
                                    },
                                    child: Card(
                                      elevation: 2,
                                      // margin: EdgeInsets.only(top: 12,bottom: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),

                                      ),
                                      child: Container(
                                        height: 30,
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, top: 3, bottom: 3),
                                        // width: MediaQuery.of(context).size.width*0.9,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: taskData.showDone==1?ColorUtils.orangeAccent:Color(0xff3cb371)),
                                        child:  Center(
                                            child: CommonKhandText(
                                              title: taskData.showDone==1?"Confirm":"Like & Tweet",
                                              fontWeight: FontWeight.w300,
                                              textColor: ColorUtils.colorWhite,
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  horizontalSpace(6),
                                  Visibility(
                                    visible: taskData.showDone==1,
                                    child: GestureDetector(
                                      onTap: () {
                                        viewOnly("TWITTER-VIEW");
                                      },
                                      child: Card(
                                        elevation: 2,
                                        // margin: EdgeInsets.only(top: 12,bottom: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),

                                        ),
                                        child: Container(
                                          height: 30,
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, top: 3, bottom: 3),
                                          // width: MediaQuery.of(context).size.width*0.9,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              color: Colors.green),
                                          child:  Center(
                                              child: CommonKhandText(
                                                title: "View",
                                                fontWeight: FontWeight.w300,
                                                textColor: ColorUtils.colorWhite,
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getTwitterTrendWidget(DarkThemeProvider themeProvider,
      BuildContext context)
  {
    return GestureDetector(
      onTap: (){
        navigateTo("TWITTERTREND");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CommonKhandText(
                    title: taskData.userName,
                    textColor: const Color(0xffffffff),
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                  ),
                ),
                CommonKhandText(
                  title: DateFormatter.getFormattedDateTime(taskData.postCreatedTime.toString()),
                  textColor: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.zero,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            child: Container(
              // padding: const EdgeInsets.all(8),
              width: screenWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                // image: const DecorationImage(
                //     image: AssetImage(AssetUtils.bgMlaFollow),
                //     fit: BoxFit.fill
                // )
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

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(9),
                        image: DecorationImage(
                          image: taskData.postImg.isEmpty ? AssetImage(
                              AssetUtils.Twitter) : NetworkImage(
                              taskData.postImg),
                          //fit: BoxFit.cover
                        )
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Container(
                      width: screenWidth(context),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        // image: const DecorationImage(
                        //     image: AssetImage(AssetUtils.bgMlaFollow),
                        //     fit: BoxFit.fill
                        // )
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(9, 9, 9, 1)
                                : const Color.fromRGBO(
                                6, 108, 219, 0.8897934173669468),
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(63, 61, 61, 1)
                                : const Color.fromRGBO(216, 222, 218, 1),
                          ],
                          stops: const [0.0, 1.0], // Stops to match 0% and 100%
                        ),
                      ),
                      child: Column(
                        children: [
                          CommonKhandText(
                            title: taskData.postMessage,
                            textColor: Color(0xffffffff),
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),

                          verticalSpace(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonKhandText(
                                    title: DateFormatter.getTimeDifference(taskData.endDate),
                                    textColor: ColorUtils.errorColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                  ),

                                  CommonKhandText(
                                    title: taskData.points.toString()+" Points",
                                    textColor: ColorUtils.colorBlack,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      navigateTo("TWITTERTREND");
                                    },
                                    child: Card(
                                      elevation: 2,
                                      // margin: EdgeInsets.only(top: 12,bottom: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),

                                      ),
                                      child: Container(
                                        height: 30,
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, top: 3, bottom: 3),
                                        // width: MediaQuery.of(context).size.width*0.9,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: taskData.showDone==1?ColorUtils.orangeAccent:Color(0xff3cb371)),
                                        child:  Center(
                                            child: CommonKhandText(
                                              title: taskData.showDone==1?"Confirm":"Like and Tweet",
                                              fontWeight: FontWeight.w300,
                                              textColor: ColorUtils.colorWhite,
                                            )
                                        ),
                                      ),
                                    ),
                                  ),

                                  horizontalSpace(6),
                                  Visibility(
                                    visible: taskData.showDone==1,
                                    child: GestureDetector(
                                      onTap: () {
                                        viewOnly("TWITTERTREND-VIEW");
                                      },
                                      child: Card(
                                        elevation: 2,
                                        // margin: EdgeInsets.only(top: 12,bottom: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),

                                        ),
                                        child: Container(
                                          height: 30,
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, top: 3, bottom: 3),
                                          // width: MediaQuery.of(context).size.width*0.9,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              color: Colors.green),
                                          child:  Center(
                                              child: CommonKhandText(
                                                title: "View",
                                                fontWeight: FontWeight.w300,
                                                textColor: ColorUtils.colorWhite,
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getOtherWidget(DarkThemeProvider themeProvider, BuildContext context) {
    return GestureDetector(
      onTap: (){
        navigateTo("OTHER");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CommonKhandText(
                    title: taskData.userName,
                    textColor: const Color(0xffffffff),
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                  ),
                ),
                CommonKhandText(
                  title: DateFormatter.getFormattedDateTime(taskData.postCreatedTime.toString()),
                  textColor: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.zero,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            child: Container(
              // padding: const EdgeInsets.all(8),
              width: screenWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                // image: const DecorationImage(
                //     image: AssetImage(AssetUtils.bgMlaFollow),
                //     fit: BoxFit.fill
                // )
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

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(9),
                        image: DecorationImage(
                            image: AssetImage(AssetUtils.logoPng),
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Container(
                      width: screenWidth(context),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        // image: const DecorationImage(
                        //     image: AssetImage(AssetUtils.bgMlaFollow),
                        //     fit: BoxFit.fill
                        // )
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(9, 9, 9, 1)
                                : const Color.fromRGBO(
                                6, 108, 219, 0.8897934173669468),
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(63, 61, 61, 1)
                                : const Color.fromRGBO(216, 222, 218, 1),
                          ],
                          stops: const [0.0, 1.0], // Stops to match 0% and 100%
                        ),
                      ),
                      child: Column(
                        children: [
                          CommonKhandText(
                            title: taskData.postMessage,
                            textColor: Color(0xffffffff),
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),

                          verticalSpace(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonKhandText(
                                    title: DateFormatter.getTimeDifference(taskData.endDate),
                                    textColor: ColorUtils.errorColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                  ),

                                  CommonKhandText(
                                    title: taskData.points.toString()+" Points",
                                    textColor: ColorUtils.colorBlack,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      navigateTo("OTHER");
                                    },
                                    child: Card(
                                      elevation: 2,
                                      // margin: EdgeInsets.only(top: 12,bottom: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),

                                      ),
                                      child: Container(
                                        height: 30,
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, top: 3, bottom: 3),
                                        // width: MediaQuery.of(context).size.width*0.9,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: taskData.showDone==1?ColorUtils.orangeAccent:Color(0xff3cb371)),
                                        child:  Center(
                                            child: CommonKhandText(
                                              title: taskData.showDone==1?"Confirm":"Share",
                                              fontWeight: FontWeight.w300,
                                              textColor: ColorUtils.colorWhite,
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  horizontalSpace(6),
                                  Visibility(
                                    visible: taskData.showDone==1,
                                    child: GestureDetector(
                                      onTap: () {
                                        viewOnly("OTHER-VIEW");
                                      },
                                      child: Card(
                                        elevation: 2,
                                        // margin: EdgeInsets.only(top: 12,bottom: 10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),

                                        ),
                                        child: Container(
                                          height: 30,
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, top: 3, bottom: 3),
                                          // width: MediaQuery.of(context).size.width*0.9,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              color: Colors.green),
                                          child:  Center(
                                              child: CommonKhandText(
                                                title: "View",
                                                fontWeight: FontWeight.w300,
                                                textColor: ColorUtils.colorWhite,
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
