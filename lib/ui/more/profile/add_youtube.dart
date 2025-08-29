import 'package:flutter/material.dart';
import '../../../constants/components/pro_text.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/asset_utils.dart';
import '../../../utils/color_utils.dart';

class AddYoutube extends StatefulWidget {
  const AddYoutube({super.key});

  @override
  State<AddYoutube> createState() => _AddYoutubeState();
}

class _AddYoutubeState extends State<AddYoutube> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:ColorUtils.appBarColor ,
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
        title:  const CommonKhandText(
          title: "NEWS YOUTUBEvO",
          textColor: Color(0xffffffff),
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),
      ),

      body: Container(
        height: screenHeight(context),
        width: screenWidth(context),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AssetUtils.screenBackgroundFour),
                fit: BoxFit.fill)
        ),
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
