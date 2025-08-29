import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/data/model/meeting_list_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import '../../../../../constants/components/pro_text.dart';
import '../../../../utils/color_utils.dart';
class MeetingScreenUi extends StatelessWidget {
  final MeetingData meetingData;
  final VoidCallback function;
  const MeetingScreenUi({super.key, required this.meetingData,required this.function,});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return GestureDetector(
      onTap: ()=>function(),
      child: Card(
        margin: const EdgeInsets.only(left:10,right:10,bottom: 20,top: 10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        elevation: 5,
        child: Container(
          width: screenWidth(context),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     image:  DecorationImage(image: meetingData.meetingBannerImage.isEmpty?AssetImage(AssetUtils.logoPng):NetworkImage(AppUrl.meettingBaseImageUrl+meetingData.meetingBannerImage),fit: BoxFit.fill)
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height:screenHeight(context)*0.35,
                margin: const EdgeInsets.all(5),
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)
                    ),
                    image: DecorationImage(image: meetingData.meetingBannerImage.isEmpty?AssetImage(AssetUtils.logoPng):NetworkImage(AppUrl.meettingBaseImageUrl+meetingData.meetingBannerImage),fit: BoxFit.fill)
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  gradient:  LinearGradient(
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
                    // image: const DecorationImage(image: AssetImage(AssetUtils.bgMlaFollow),fit: BoxFit.cover)
                ),
                child: Column(
                  children: [
                     CommonKhandText(
                      title: meetingData.meetingAgenda,
                       textColor: ColorUtils.colorWhite ,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                     CommonKhandText(
                      title:meetingData.description,
                       textColor: ColorUtils.colorWhite ,
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                    verticalSpace(10),
                     const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonKhandText(
                          title: "Meeting Date",
                          textColor: ColorUtils.colorWhite ,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                        CommonKhandText(
                          title: "Meeting Time",
                          textColor: ColorUtils.colorWhite ,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ],
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonKhandText(
                          title: meetingData.meetingDate,
                          textColor: ColorUtils.primaryColor ,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        CommonKhandText(
                          title: meetingData.meetingTime,
                          textColor: ColorUtils.primaryColor ,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
