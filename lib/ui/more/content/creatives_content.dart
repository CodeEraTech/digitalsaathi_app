import 'dart:io';
import 'dart:typed_data';

import 'package:digitalsaathi/constants/Api_Services/api_services.dart';
import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/provider/content_provider.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../constants/components/pro_text.dart';
import '../../../data/model/content_post_model.dart';
import '../../../provider/theme_provider.dart';
import '../../../utils/color_utils.dart';
import 'package:http/http.dart' as http;

import 'creatives_content_ui.dart';

class CreativeContentScreen extends StatefulWidget {
  const CreativeContentScreen({Key? key}) : super(key: key);

  @override
  State<CreativeContentScreen> createState() => _CreativeContentScreenState();
}

class _CreativeContentScreenState extends State<CreativeContentScreen> {
   //  int _downloadCount = 0;
  // int shareCount = 0;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);



    return Scaffold(
      backgroundColor: themeProvider.darkTheme ? ColorUtils.colorBlack : ColorUtils.lightTheme,
      appBar: AppBar(
        surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorBlack : ColorUtils.appBarColor,
        backgroundColor: themeProvider.darkTheme ? ColorUtils.colorBlack : ColorUtils.appBarColor,
        centerTitle: true,
        elevation: 4,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: 30,
            width: 30,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: const CommonKhandText(
          title: "Creative Content",
          textColor: Color(0xffffffff),
          fontWeight: FontWeight.w300,
          fontSize: 16,
        ),
      ),
      body: Consumer<ContentProvider>(
        builder: (context,contentProvider,_) {
          return Stack(
            children: [
              Container(
                height: screenHeight(context),
                width: screenWidth(context),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                child: ListView.builder(
                  itemCount: contentProvider.imageContent.length,
                  itemBuilder: (context, index) {
                    ContentData postData = contentProvider.imageContent[index];
                    return Column(
                      children: [
                        CreativesContentUi(
                          shareData: "${postData.share}",
                          downloadData: "${postData.download}",
                          downloadFunction: () => contentProvider.downloadImage(postData.postUrl ?? postData.postUrl ?? '', "${postData.id}",index,"image"),
                          // downloadFunction: () => downloadImage(postData.file ?? postData.postUrl ?? ''),
                          shareFunction: () => contentProvider.shareContentInit(postData.postUrl ?? postData.postUrl ?? '', "${postData.id}",index,"image"),
                          creativeImage: postData.file ?? AssetUtils.creatives, // Use the file or a placeholder
                        ),
                        verticalSpace(15),
                      ],
                    );
                  },
                ),
              ),

              contentProvider.isLoading?CustomLoader():SizedBox.shrink()
            ],
          );
        }
      ),
    );
  }







}


