import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/data/model/political_profile_response.dart';
import 'package:digitalsaathi/provider/poster_provider.dart';
import 'package:digitalsaathi/ui/more/poster/poster_profile/edit_create_poster_profile.dart';
import 'package:digitalsaathi/ui/more/poster/poster_profile/poster_profile_ui.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../../constants/components/pro_text.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utils/color_utils.dart';
import 'create_poster_profile.dart';

class ProfilePoster extends StatefulWidget {
  const ProfilePoster({super.key});

  @override
  State<ProfilePoster> createState() => _ProfilePosterState();
}

class _ProfilePosterState extends State<ProfilePoster> {
  int? selectedButton;

  void toggleButton(PosterProvidder posterProvider,String id) {
   posterProvider.changePoliticalChange(context, id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PosterProvidder>(context,listen: false).getPoliticalProfile();
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
              color: Colors.black.withOpacity(0.2), shape: BoxShape.circle),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Center(
              // Center the Icon widget here
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: const CommonKhandText(
          title: "My Poster Profile",
          textColor: Color(0xffffffff),
          fontWeight: FontWeight.w300,
          fontSize: 17,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreatePosterProfile(),
                    )).then((onValue){
                  if(onValue != null){
                    Provider.of<PosterProvidder>(context,listen: false).getPoliticalProfile();
                  }
                });
              },
              child: const CommonKhandText(
                title: "Create",
                textColor: ColorUtils.colorWhite,
                fontWeight: FontWeight.w300,
                fontSize: 17,
              ),
            ),
          ),
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
                child: ListView.builder(
                  itemCount: posterProvider.politicalProfileData.length,
                    itemBuilder: (context,index){
                    PoliticalProfileData p = posterProvider.politicalProfileData[index];
                  return MyPosterProfileUi(
                    politicalProfileData: p,
                    editFunction: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              duration: const Duration(milliseconds: 800),
                              reverseDuration: const Duration(milliseconds: 400),
                              type: PageTransitionType.bottomToTop,
                              child:  CreatePosterProfile(politicalProfileData: p,))).then((onValue){
                                if(onValue != null){
                                  posterProvider.getPoliticalProfile();
                                }
                      });
                    },
                    selectFunction: () => toggleButton(posterProvider,p.id.toString()),
                    deleteFunction: () {
                      _showDialog(context,posterProvider, index,p.id.toString());
                    },

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

  void _showDialog(BuildContext context,PosterProvidder posterProvider,int index,String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final themeProvider = Provider.of<DarkThemeProvider>(context);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          title: CommonKhandText(
            title: "Are you sure you want to delete?",
            fontWeight: FontWeight.w300,
            textColor: themeProvider.darkTheme
                ? ColorUtils.colorWhite
                : ColorUtils.colorBlack,
            fontSize: 17,
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // Close dialog on "No"
                    },
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: AssetImage(AssetUtils.bgMlaFollow),
                              fit: BoxFit.fill)),
                      child: Center(
                        child: CommonKhandText(
                          title: "No",
                          fontWeight: FontWeight.w300,
                          textColor: themeProvider.darkTheme
                              ? ColorUtils.colorWhite
                              : ColorUtils.colorBlack,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: GestureDetector(
                    onTap: () {

                      Navigator.of(context).pop();
                      posterProvider.deletePosterProfile(id, index);// Close dialog after removal
                    },
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                            image: AssetImage(AssetUtils.bgMlaFollow),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: CommonKhandText(
                          title: "Yes",
                          fontWeight: FontWeight.w300,
                          textColor: themeProvider.darkTheme
                              ? ColorUtils.colorWhite
                              : ColorUtils.colorBlack,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _navigateToCreatePosterProfile() {
    Navigator.push(
        context,
        PageTransition(
            duration: const Duration(milliseconds: 800),
            reverseDuration: Duration(milliseconds: 400),
            type: PageTransitionType.bottomToTop,
            child: const EditCreatePosterProfile()));
  }
}
