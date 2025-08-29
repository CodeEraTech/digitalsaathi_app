import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/provider/meeeting_provider.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/components/pro_text.dart';
import '../../../../utils/color_utils.dart';
import '../../../provider/theme_provider.dart';

class MeetingReportScreen extends StatefulWidget {
  const MeetingReportScreen({super.key});

  @override
  State<MeetingReportScreen> createState() => _MeetingReportScreenState();
}

class _MeetingReportScreenState extends State<MeetingReportScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MeetingProvider>(context,listen: false).getMeetingReport();
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
          title: "Meeting Report",
          textColor:ColorUtils.colorWhite,
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),
      ),
      body: Consumer<MeetingProvider>(
        builder: (context,meetingProvider,_) {
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
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    verticalSpace(10),
                    Container(
                      width: screenWidth(context),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          image: const DecorationImage(image: AssetImage(AssetUtils.bgMlaFollow),fit:BoxFit.fill)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CommonKhandText(
                              title: "MEETING REPORT",
                              textColor:ColorUtils.colorWhite,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.zero,
                            elevation:3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              width: screenWidth(context),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  image: const DecorationImage(image: AssetImage(AssetUtils.bgMlaFollow),fit:BoxFit.fill)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const CommonKhandText(
                                        title: "Total",
                                        textColor:ColorUtils.colorWhite,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                      ),
                                      verticalSpace(10),
                                       CommonKhandText(
                                        title: meetingProvider.meetingReportResponse.isEmpty?"0":meetingProvider.meetingReportResponse[0].totalMeeting.toString(),
                                        textColor:ColorUtils.colorWhite,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const CommonKhandText(
                                        title: "Completed",
                                        textColor:ColorUtils.colorWhite,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                      ),
                                      verticalSpace(10),
                                       CommonKhandText(
                                        title: meetingProvider.meetingReportResponse.isEmpty?"0":meetingProvider.meetingReportResponse[0].totalCompleteMeeting.toString(),
                                        textColor:ColorUtils.colorWhite,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const CommonKhandText(
                                        title: "Pending",
                                        textColor:ColorUtils.colorWhite,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                      ),
                                      verticalSpace(10),
                                       CommonKhandText(
                                        title: meetingProvider.meetingReportResponse.isEmpty?"0":(meetingProvider.meetingReportResponse[0].totalMeeting - meetingProvider.meetingReportResponse[0].totalCompleteMeeting).toString(),
                                        textColor:ColorUtils.colorWhite,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
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
                    verticalSpace(15),
                    Container(
                      width: screenWidth(context),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          image: const DecorationImage(image: AssetImage(AssetUtils.bgMlaFollow),fit:BoxFit.fill)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CommonKhandText(
                              title: "PARTICIPANT REPORT",
                              textColor:ColorUtils.colorWhite,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.zero,
                            elevation:1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              width: screenWidth(context),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  image: const DecorationImage(image: AssetImage(AssetUtils.bgMlaFollow),fit:BoxFit.fill)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const CommonKhandText(
                                        title: "Total",
                                        textColor:ColorUtils.colorWhite,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                      ),
                                      verticalSpace(10),
                                       CommonKhandText(
                                        title: meetingProvider.meetingReportResponse.isEmpty?"0":meetingProvider.meetingReportResponse[0].totalParticipants.toString(),
                                        textColor:ColorUtils.colorWhite,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const CommonKhandText(
                                        title: "Present",
                                        textColor:ColorUtils.colorWhite,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                      ),
                                      verticalSpace(10),
                                       CommonKhandText(
                                        title: meetingProvider.meetingReportResponse.isEmpty?"0":meetingProvider.meetingReportResponse[0].totalPresent.toString(),
                                        textColor:ColorUtils.colorWhite,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const CommonKhandText(
                                        title: "Absent",
                                        textColor:ColorUtils.colorWhite,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                      ),
                                      verticalSpace(10),
                                       CommonKhandText(
                                        title: meetingProvider.meetingReportResponse.isEmpty?"0":meetingProvider.meetingReportResponse[0].totalAbsent.toString(),
                                        textColor:ColorUtils.colorWhite,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const CommonKhandText(
                                        title: "New",
                                        textColor:ColorUtils.colorWhite,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                      ),
                                      verticalSpace(10),
                                       CommonKhandText(
                                        title: meetingProvider.meetingReportResponse.isEmpty?"0":meetingProvider.meetingReportResponse[0].totalNewParticipants.toString(),
                                        textColor:ColorUtils.colorWhite,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              meetingProvider.isLoading?const CustomLoader():const SizedBox.shrink()
            ],
          );
        }
      ),
    );
  }
}
