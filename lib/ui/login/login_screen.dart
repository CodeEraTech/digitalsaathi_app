import 'package:digitalsaathi/constants/components/wave_background.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       child: Stack(
         children: [
           Positioned.fill(
             child: CustomPaint(
               painter: WavePainter(),
             ),
           ),
           // Add other widgets here if needed
          Container(
            margin: EdgeInsets.only(top: 25),
            child: ListView(
              children: [
                Image.asset(AssetUtils.logoPng,color: ColorUtils.colorWhite,height: 150,)
              ],
            ),
          )
         ],
       ),
      ),
    );
  }
}
