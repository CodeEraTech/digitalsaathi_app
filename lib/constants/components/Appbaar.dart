import 'package:digitalsaathi/constants/components/pro_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/color_utils.dart';
import '../../utils/style_utils.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backArrow;
  const AppBarWidget({super.key,required this.title,this.backArrow=true});



  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(
          margin :const EdgeInsets.only(left:10),
          child: Visibility(
            visible: backArrow,
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
                child: const Icon(Icons.arrow_back,size:28,color:ColorUtils.primaryColor)),
          )),
      centerTitle: true,
      title: ProText(title,
        style: StyleUtils.t700_18.copyWith(color: ColorUtils.primaryColor),textAlign: TextAlign.left,),
      backgroundColor:  ColorUtils.backgroundColor,
      bottomOpacity: 0.0,
      elevation: 0.0,);
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);//
}
