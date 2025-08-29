import 'package:digitalsaathi/constants/components/pro_text.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/components/common_button.dart';
import '../../../utils/string_utils.dart';
import '../../../utils/style_utils.dart';
import '../../utils/prefrence/pref_utils.dart';

class ExitPopUp extends StatefulWidget {
  const ExitPopUp({Key? key}) : super(key: key);

  @override
  State<ExitPopUp> createState() => _ExitPopUpState();
}

class _ExitPopUpState extends State<ExitPopUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorUtils.backgroundColor,
      actions:  [
        verticalSpace(30),
        Container(
            alignment: Alignment.center,
            child:ProText(StringUtil.exitapp,style: StyleUtils.t600_20.copyWith(color: ColorUtils.primaryColor),)),
        verticalSpace(10),
        Center(child: ProText(StringUtil.exitmsg,style: StyleUtils.t500_18.copyWith(color: ColorUtils.primaryColor),)),
        verticalSpace(20),
        Divider(thickness: 1,color: ColorUtils.primaryColor,),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            horizontalSpace(10),
            CommonButton(
              title: StringUtil.cancel,
              onPressed: (){
                Navigator.of(context).pop();

              },
            ),
            horizontalSpace(10),
            CommonButton(
              title: StringUtil.exit,
              onPressed: (){
                SystemNavigator.pop();

              },
            ),
            horizontalSpace(10),
          ],
        )

      ],
    );
  }
}
