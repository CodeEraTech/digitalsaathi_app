import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../constants/components/pro_text.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utils/color_utils.dart';

class ProfileUi extends StatelessWidget {
  final VoidCallback navigateTo;
  final String contentImage ;
  final String contentName ;
  final Color? opacityColor ;
  const ProfileUi({super.key, required this.navigateTo, required this.contentImage, required this.contentName, this.opacityColor});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return GestureDetector(
      onTap: (){
        navigateTo();
      },
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.darkTheme,
        margin: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            image:  const DecorationImage(image: AssetImage(AssetUtils.bgMlaFollow),fit: BoxFit.fill)
          ),
          child: Column(
            children: [
              Container(
                height: 105,
                width: 155,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(image: AssetImage(AssetUtils.screenBackgroundOne),fit: BoxFit.fill)
                ),
                child:Container(
                  height: 105,
                  width: 155,
                  decoration: BoxDecoration(
                    color: opacityColor,
                    borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: AssetImage(contentImage),fit: BoxFit.fill)
                  ),
                ),
              ),
              verticalSpace(2),
              CommonKhandText(
                title: contentName,
                textColor: themeProvider.darkTheme ? ColorUtils.colorWhite : ColorUtils.colorBlack ,
                fontWeight: FontWeight.w400,
                fontSize:16,
                textAlign: TextAlign.center,
              ),
              verticalSpace(2),
            ],
          ),
        ),
      ),
    );
  }
}
