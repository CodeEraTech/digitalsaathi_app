import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static void hideKeyBoard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static double averageRating(List<int> rating){
    var avgRating = 0;
    for(int i = 0 ; i< rating.length ; i++){
      avgRating = avgRating + rating[i];
    }
    return double.parse((avgRating/rating.length).toStringAsFixed(1)) ;
  }

  static void fieldFocusChange(BuildContext context , FocusNode current , FocusNode nextFocus){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }


  static printConsoleData(String message){
    if(!kReleaseMode) {
      log(message.toString());
    }
  }


  static toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
    backgroundColor:ColorUtils.primaryColor,
      textColor: ColorUtils.secondaryColor,

    );
  }


  static void flushBarErrorMessage(String message, BuildContext context){
    showFlushbar(context: context,
        flushbar: Flushbar(
          forwardAnimationCurve:Curves.decelerate,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.all(15),
          message: message,
          duration: Duration(seconds: 3),
          borderRadius: BorderRadius.circular(8),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.red,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: Icon(Icons.error , size: 28 , color: Colors.white,),
        )..show(context),

    );

  }

  static snackBar(String message, BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message ))
    );
  }

  static Widget loader(){
    return Container(
      color: Colors.black26,
      height: double.maxFinite,
      width: double.maxFinite,
      child: const Center(child: CircularProgressIndicator(color: ColorUtils.primaryColor,
      strokeWidth: 2.0,backgroundColor: ColorUtils.backgroundColor,
      ))
    );
  }


  static launchDialPad(String m) async {
    String url = "tel:$m";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



}

class DateChanger{
String monthDateFormate(String date){
  print("getnew ${date.toString()}");
  var inputFormat = DateFormat('yyyy-MM-dd');
  var date1 = inputFormat.parse(date.toString());
  var outputFormat = DateFormat('MM-dd-yyyy');
  var date2 = outputFormat.format(date1);
  return date2.toString();
}




}