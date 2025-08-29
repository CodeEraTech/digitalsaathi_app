
import 'dart:async';

import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/constants/components/wave_background.dart';
import 'package:digitalsaathi/provider/home_provider.dart';
import 'package:digitalsaathi/ui/authentication_screen/login_screen.dart';
import 'package:digitalsaathi/ui/botttom_bar/bottom_nav_bar.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:digitalsaathi/utils/connection_util.dart';
import 'package:digitalsaathi/utils/prefrence/pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ConnectionUtil().establishConnection();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child:  Image.asset(AssetUtils.logoPng,height: 150,),
      ),
    );
  }

  Future init() async {
    const _duration = Duration(milliseconds: 3000);
    return Timer(_duration, navigateToPage);
  }

  Future<void> navigateToPage() async {
    if (PrefUtils.getToken().isEmpty) {
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
            (Route<dynamic> route) => false,
      );
    } else {
      AppUrl.apiToken = PrefUtils.getToken();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar(),));
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => BottomNavBar(),
        ),
            (Route<dynamic> route) => false,
      );
    }
  }
}
