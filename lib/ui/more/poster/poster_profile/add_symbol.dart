import 'dart:io';

import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/provider/poster_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../../../constants/components/pro_text.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/color_utils.dart';
import 'package:http/http.dart'as http;

class AddSymbol extends StatefulWidget {
  const AddSymbol({super.key});

  @override
  State<AddSymbol> createState() => _AddSymbolState();
}

class _AddSymbolState extends State<AddSymbol> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<PosterProvidder>(context,listen: false).getPartyLogo();
  }


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.darkTheme
          ? ColorUtils.colorBlack
          : ColorUtils.lightTheme,
      appBar: AppBar(
        surfaceTintColor: themeProvider.darkTheme
            ? ColorUtils.colorBlack
            : ColorUtils.appBarColor,
        backgroundColor: themeProvider.darkTheme
            ? ColorUtils.colorBlack
            : ColorUtils.appBarColor,
        centerTitle: true,
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
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title:   CommonKhandText(
          title: "Party Symbol",
          textColor: Color(0xffffffff),
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),

        actions: [
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: CommonKhandText(
              title: "DONE",
              textColor: ColorUtils.errorColor,
              fontWeight: FontWeight.w300,
              fontSize: 18,
            ),
          ),
          
          horizontalSpace(8)
        ],
      ),

      body: Consumer<PosterProvidder>(
        builder: (context,posterProvider,_) {
          return Stack(
            children: [
              Container(
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
                child: GridView.builder(
                  itemCount: posterProvider.partySymbolData.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisExtent: 150),
                    itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      posterProvider.onLogoSelected(index);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: posterProvider.selectedLogo==index?ColorUtils.colorGreen:ColorUtils.colorBlack, width: posterProvider.selectedLogo==index?3:1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          ClipRRect(
                            child: CircleAvatar(
                              radius: 40,
                                child: Image.network(posterProvider.partySymbolData[index].image)),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              width:screenWidth(context),
                              decoration: BoxDecoration(
                                color: ColorUtils.colorBlack,
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))
                              ),
                              child: CommonKhandText(
                                title: posterProvider.partySymbolData[index].name,
                                textColor: ColorUtils.colorWhite,
                                fontSize:18,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                    }),
              ),
              posterProvider.isLoading?const CustomLoader():const SizedBox.shrink()
            ],
          );
        }
      ),
    );
  }
}
