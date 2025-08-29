import 'package:digitalsaathi/constants/components/pro_text.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:flutter/material.dart';
class AddTwitter extends StatefulWidget {
  const AddTwitter({super.key});

  @override
  State<AddTwitter> createState() => _AddTwitterState();
}

class _AddTwitterState extends State<AddTwitter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenHeight(context),
        width: screenWidth(context),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AssetUtils.screenBackgroundOne),
                fit: BoxFit.fill
            )
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(8),
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.2),
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
                    const CommonKhandText(
                      title: "TESTIMP WK2",
                      textColor: Color(0xffffffff),
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                    Container(width: 40,)
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
