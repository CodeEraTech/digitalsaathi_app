import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/components/pro_text.dart';
import '../../../provider/theme_provider.dart';

class CreativesContentUi extends StatelessWidget {
  final VoidCallback? downloadFunction ;
  final VoidCallback? shareFunction ;
  final String downloadData ;
  final String shareData ;
  final String creativeImage ;

  const CreativesContentUi({super.key, required this.downloadFunction, required this.shareFunction, required this.downloadData, required this.shareData, required this.creativeImage});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      margin: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(image: AssetImage(AssetUtils.bgCardThree),fit: BoxFit.fill)
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 245,
                  width: screenWidth(context),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          themeProvider.darkTheme ? Color.fromRGBO(6, 108, 219, 0.8897934173669468):Color.fromRGBO(6, 108, 219, 0.8897934173669468),
                          themeProvider.darkTheme ? Color.fromRGBO(216, 222, 218, 1):Color.fromRGBO(216, 222, 218, 1),
                        ],
                        stops: const [0.0, 1.0], // Stops to match 0% and 100%
                      ),
                      borderRadius: BorderRadius.circular(10),
                      image:  DecorationImage(
                          image: NetworkImage("https://newdgs.mydigitalsaathi.com/public/$creativeImage"),fit: BoxFit.fill
                      )
                  ),
                ),
                verticalSpace(10),
                Container(
                  padding: const EdgeInsets.only(
                      left: 20,right: 20,top: 15,bottom: 10
                  ),
                  width: screenWidth(context),
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Center(
                          child:  CommonKhandText(
                            title: downloadData,
                            textColor: const Color(0xffffffff),
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: Center(
                          child:  CommonKhandText(
                            title: shareData,
                            textColor:const Color(0xffffffff),
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 213,
                  left: 20,
                  right: 20
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        downloadFunction!();
                        },
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            // color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                              image: const DecorationImage(image: AssetImage(AssetUtils.bgCardOne),fit: BoxFit.fill)

                          ),
                          child: Center(
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CommonKhandText(
                                  title: "Download",
                                  // textColor:ColorUtils.colorWhite,
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                ),
                                horizontalSpace(5),
                                const Icon(Icons.download,color: Colors.white,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  horizontalSpace(10),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        shareFunction!();
                      },
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            // color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              image: const DecorationImage(image: AssetImage(AssetUtils.bgCardOne),fit: BoxFit.fill)

                          ),
                          child: Center(
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CommonKhandText(
                                  title: "Share",
                                  // textColor:ColorUtils.colorWhite,
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                ),
                                horizontalSpace(5),
                                Image(image: AssetImage(AssetUtils.shareIconWhite),height: 30,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

