import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/provider/content_provider.dart';
import 'package:digitalsaathi/ui/more/content/content_ui.dart';
import 'package:digitalsaathi/ui/more/content/creatives_content.dart';
import 'package:digitalsaathi/ui/more/content/video_creative_content.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../constants/components/pro_text.dart';
import '../../../provider/theme_provider.dart';
import '../../../utils/asset_utils.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<ContentProvider>(context,listen: false).getAllContent();
  }
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.darkTheme ?  ColorUtils.colorBlack: ColorUtils.lightTheme,
      appBar: AppBar(
        surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorBlack :  ColorUtils.appBarColor ,
        backgroundColor: themeProvider.darkTheme ? ColorUtils.colorBlack :  ColorUtils.appBarColor ,        centerTitle: true,
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
          title: "Creative-Videos-Media Links",
          textColor: Color(0xffffffff),
          fontWeight: FontWeight.w300,
          fontSize: 16,
        ),
      ),
      body: Consumer<ContentProvider>(
        builder: (context,content_provider,_) {
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: screenHeight(context),
                width: screenWidth(context),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.112, 0.789, 1.0],
                    colors: [
                      Color(0xFF000000), // Black
                      Color(0xFF3F3D3D), // Dark Grey
                      Color(0xFF606060), // Medium Grey
                    ],
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(10),
                       CommonKhandText(
                        title: "Creatives",
                        textColor:ColorUtils.colorWhite,
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                      ),
                      ContentUi(
                        creativeImage: AssetUtils.creatives,
                        navigateTo: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CreativeContentScreen(),));
                        },
                      ),
                      verticalSpace(10),
                       CommonKhandText(
                        title: "Videos",
                        textColor:ColorUtils.colorWhite,
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                      ),
                      ContentUi(
                        creativeImage: AssetUtils.videos,
                        navigateTo: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VideoCreativeContent(),));
                        },
                      ),
                    ],
                  ),
                ),
              ),

              content_provider.isLoading?CustomLoader():SizedBox.shrink()
            ],
          );
        }
      ),
    );
  }
}
