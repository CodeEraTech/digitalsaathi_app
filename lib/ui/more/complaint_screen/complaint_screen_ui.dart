import 'dart:core';
import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/data/model/complaint_list_response.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/components/pro_text.dart';
import '../../../provider/theme_provider.dart';
import '../../../utils/color_utils.dart';

class ComplaintScreenUi extends StatelessWidget {
  final ComplaintData cData;
  final VoidCallback delete ;
  final VoidCallback pendingFunction ;

  const ComplaintScreenUi(
      {super.key,
      required this.cData,
      required this.delete, required this.pendingFunction});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: Container(
        width: screenWidth(context),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
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
            // image: const DecorationImage(
            //     image: AssetImage(AssetUtils.bgMlaFollow), fit: BoxFit.fill
            // )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Container(
              width: screenWidth(context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
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
                  // image: const DecorationImage(
                  //     image: AssetImage(AssetUtils.bgMlaFollow),
                  //     fit: BoxFit.fill
                  // )
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          height: 44,
                          width: 45,
                          decoration:  BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: cData.userProfilePicture.isEmpty?AssetImage(AssetUtils.profilePng):NetworkImage(AppUrl.BASE_IMAGE_URL+cData.userProfilePicture),
                                  fit: BoxFit.fill)),
                        ),
                        horizontalSpace(15),
                        Container(
                          padding: const EdgeInsets.only(bottom: 7),
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CommonKhandText(
                                title: cData.createdbyuser,
                                textColor: ColorUtils.colorWhite,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                              CommonKhandText(
                                title: cData.createdAt,
                                textColor: ColorUtils.colorWhite,
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                         Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: (){delete();},
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            CommonKhandText(
                              title: cData.complaintNo,
                              textColor: ColorUtils.colorWhite,
                              fontWeight: FontWeight.w400,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: screenWidth(context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          themeProvider.darkTheme
                              ? const Color.fromRGBO(9, 9, 9, 1)
                              : const Color.fromRGBO(6, 108, 219, 0.8897934173669468),
                          themeProvider.darkTheme
                              ? const Color.fromRGBO(63, 61, 61, 1)
                              : const Color.fromRGBO(216, 222, 235, 1),
                        ],
                        stops: const [0.0, 1.0], // Stops to match 0% and 100%
                      ),
                        // image: const DecorationImage(
                        //     image: AssetImage(AssetUtils.bgMlaFollow),
                        //     fit: BoxFit.fill
                        // )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CommonKhandText(
                                    title: cData.subject,
                                    textColor: ColorUtils.colorWhite,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                  ),
                                  Visibility(
                                    visible: cData.highSeverity == "Yes",
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(15, 3,15,3),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffFF0000),
                                          borderRadius: BorderRadius.circular(3)
                                      ),
                                      child: const Center(
                                        child:  CommonKhandText(
                                          title:"High Severity",
                                          textColor: ColorUtils.colorWhite,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(6),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: CommonKhandText(
                                  title: cData.description,
                                  textColor: ColorUtils.colorWhite,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: screenWidth(context),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
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
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                           Icon(
                                            Icons.privacy_tip_outlined,
                                            color: ColorUtils.colorWhite,
                                            size: 18,
                                          ),
                                          horizontalSpace(5),
                                          CommonKhandText(
                                            title:cData.firstName,
                                            textColor: ColorUtils.colorWhite,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const CommonKhandText(
                                          title: "Status :",
                                          textColor: ColorUtils.colorWhite,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                        ),
                                        horizontalSpace(8),
                                        GestureDetector(
                                          onTap: (){
                                            pendingFunction();
                                          },
                                          child: Container(
                                            height: 23,
                                            padding: const EdgeInsets.fromLTRB(12,3,12,3 ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(3),
                                                image: const DecorationImage(
                                                    image: AssetImage(AssetUtils.screenBackgroundFive),
                                                    fit: BoxFit.fill
                                                )
                                            ),
                                            child:  Center(
                                              child: CommonKhandText(
                                                title: cData.statusId=="1"?"Pending":cData.statusId=="2"?"In Progress":cData.statusId=="3"?"Closed":"Re-Open",
                                                textColor: ColorUtils.colorWhite,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
    );
  }
}
