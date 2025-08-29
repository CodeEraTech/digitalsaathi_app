import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/provider/poster_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../constants/components/pro_text.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/color_utils.dart';


class AddLeaderProfile extends StatefulWidget {
  const AddLeaderProfile({super.key});

  @override
  State<AddLeaderProfile> createState() => _AddLeaderProfileState();
}

class _AddLeaderProfileState extends State<AddLeaderProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<PosterProvidder>(context,listen: false).getLeaders();
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
            child: const Center(  // Center the Icon widget here
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title:   CommonKhandText(
          title: "Party Leader",
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
                    itemCount: posterProvider.partyLeadersData.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          posterProvider.onLeaderSelected(index);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            // side: BorderSide(color: posterProvider.partyLeadersData[index].selected?ColorUtils.colorGreen:ColorUtils.colorBlack, width: posterProvider.partyLeadersData[index].selected?3:1),
                            side: BorderSide(
                              color: posterProvider.partyLeadersData[index].selected
                                  ? ColorUtils.colorGreen
                                  : ColorUtils.colorBlack,
                              width: posterProvider.partyLeadersData[index].selected ? 3 : 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CircleAvatar(
                                    radius: 60,
                                    child: Image.network(posterProvider.partyLeadersData[index].image),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  width: screenWidth(context),
                                  decoration: const BoxDecoration(
                                    color: ColorUtils.colorBlack,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                  ),
                                  child: CommonKhandText(
                                    title: "${posterProvider.partyLeadersData[index].name}",
                                    textColor: ColorUtils.colorWhite,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                posterProvider.isLoading?const CustomLoader():const SizedBox.shrink()
              ],
            );
          }
      ),
    );
  }
}