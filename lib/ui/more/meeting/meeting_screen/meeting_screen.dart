import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/provider/meeeting_provider.dart';
import 'package:digitalsaathi/ui/more/meeting/meeting_screen/meeting_details_screen.dart';
import 'package:digitalsaathi/ui/more/meeting/meeting_screen_ui/meeting_screen_ui.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utils/app_utils.dart';
import '../../../../../constants/components/pro_text.dart';
import 'meeting_model.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({super.key});

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<MeetingProvider>(context,listen: false).getAllMeetings();
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
          child: Consumer<MeetingProvider>(
            builder: (context,meetingProvider,_) {
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Center(  // Center the Icon widget here
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              );
            }
          ),
        ),
        title:  const CommonKhandText(
          title: "Meeting List",
          textColor: ColorUtils.colorWhite ,
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
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: meetingProvider.meetingListData.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final meeting = meetingProvider.meetingListData[index]; // Get the meeting for this index
                          return MeetingScreenUi(
                              meetingData: meeting,
                              function: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MeetingDetailsScreen(meetingData: meeting),
                                  ),
                                );
                              },
                          );
                        },
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
