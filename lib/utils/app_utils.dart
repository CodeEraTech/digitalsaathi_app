import 'dart:math';

import 'package:flutter/material.dart';


    Widget verticalSpace(double height) => SizedBox(height: height);

    Widget horizontalSpace(double width) => SizedBox(width: width);

    double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

    double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

    double screenWidthFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0, double max = 3000}) =>
        min((screenWidth(context) - offsetBy) / dividedBy, max);

    double halfScreenWidth(BuildContext context) =>
        screenWidthFraction(context, dividedBy: 2);

    double thirdScreenWidth(BuildContext context) =>
        screenWidthFraction(context, dividedBy: 3);

    double quarterScreenWidth(BuildContext context) =>
        screenWidthFraction(context, dividedBy: 4);
