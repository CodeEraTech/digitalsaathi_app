import 'dart:io';

import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/constants/components/my_TextField.dart';
import 'package:digitalsaathi/data/model/leaders_response.dart';
import 'package:digitalsaathi/data/model/political_profile_response.dart';
import 'package:digitalsaathi/provider/poster_provider.dart';
import 'package:digitalsaathi/ui/more/poster/poster_profile/add_leader_profile.dart';
import 'package:digitalsaathi/ui/more/poster/poster_profile/add_symbol.dart';
import 'package:digitalsaathi/ui/more/poster/poster_profile/poster_profile.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../constants/components/pro_text.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utils/color_utils.dart';

class CreatePosterProfile extends StatefulWidget {
  final PoliticalProfileData? politicalProfileData;
  const CreatePosterProfile({super.key, this.politicalProfileData});

  @override
  State<CreatePosterProfile> createState() => _CreatePosterProfileState();
}

class _CreatePosterProfileState extends State<CreatePosterProfile> {


  final _formKey = GlobalKey<FormState>();
  String _name = '';
  void _submitForm() {
    if(widget.politicalProfileData == null) {
      if (Provider
          .of<PosterProvidder>(context, listen: false)
          .image == null) {
        Utils.toastMessage("Select Profile Image!!!".toString());
        return;
      }
    }
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with submission

      Provider.of<PosterProvidder>(context,listen: false).createPosterProfile(context,widget.politicalProfileData);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<PosterProvidder>(context,listen: false).onInitCreateProfileData(widget.politicalProfileData);
  }



  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        backgroundColor: themeProvider.darkTheme ?  ColorUtils.colorBlack: ColorUtils.lightTheme,
        appBar: AppBar(
          surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorBlack :  ColorUtils.appBarColor ,
          backgroundColor: themeProvider.darkTheme ? ColorUtils.colorBlack :  ColorUtils.appBarColor ,
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
            title: "Create Post Profile",
            textColor: ColorUtils.colorWhite,
            fontWeight: FontWeight.w300,
            fontSize: 17,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () { _submitForm();},
                child:  CommonKhandText(
                  title: widget.politicalProfileData==null?"Save":"Update",
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
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // === Profile Image Block ===
                              Container(
                                width: 164,
                                padding: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                                  image: const DecorationImage(
                                    image: AssetImage(AssetUtils.screenBackgroundFour),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Center(
                                        child: posterProvider.image != null
                                            ? Image.file(
                                          posterProvider.image!,
                                          height: 150,
                                          width: 150,
                                          fit: BoxFit.fill,
                                        )
                                            : (widget.politicalProfileData != null &&
                                            widget.politicalProfileData!.profileImg.isNotEmpty
                                            ? Image.network(
                                          widget.politicalProfileData!.profileImg,
                                          height: 150,
                                          width: 150,
                                          fit: BoxFit.fill,
                                        )
                                            : Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.2),
                                          ),
                                        )),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () => _showDialog(context, posterProvider),
                                          child: Container(
                                            width: 170,
                                            margin: const EdgeInsets.symmetric(horizontal: 8),
                                            padding: const EdgeInsets.symmetric(vertical: 3),
                                            decoration: BoxDecoration(
                                              image: const DecorationImage(
                                                image: AssetImage(AssetUtils.bgMlaFollow),
                                                fit: BoxFit.fill,
                                              ),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: const CommonKhandText(
                                              title: "Add Image",
                                              textAlign: TextAlign.center,
                                              textColor: ColorUtils.colorWhite,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        verticalSpace(7),
                                        GestureDetector(
                                          onTap: posterProvider.removeImage,
                                          child: Container(
                                            width: 170,
                                            margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                            padding: const EdgeInsets.symmetric(vertical: 3),
                                            decoration: BoxDecoration(
                                              image: const DecorationImage(
                                                image: AssetImage(AssetUtils.bgMlaFollow),
                                                fit: BoxFit.fill,
                                              ),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: const CommonKhandText(
                                              title: "Remove Image",
                                              textAlign: TextAlign.center,
                                              textColor: ColorUtils.colorWhite,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // === Party Logo Block ===
                              Container(
                                width: 164,
                                padding: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.1),
                                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                                  image: const DecorationImage(
                                    image: AssetImage(AssetUtils.screenBackgroundFour),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [


                                    Container(
                                      height: 170,
                                      width: 170,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                      ),
                                      child: Center(
                                        child: posterProvider.selectedLogo == -1
                                            ? Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(6)),
                                            color: Colors.black.withOpacity(0.2),
                                          ),
                                        )
                                            : Image.network(
                                          posterProvider.partySymbolData[posterProvider.selectedLogo].image,/// wahi selected image crop kiya gaya hai yaha dikhana hai
                                          height: 150,
                                          width: 150,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => AddSymbol()),
                                            );
                                          },
                                          child: Container(
                                            width: 170,
                                            margin: const EdgeInsets.symmetric(horizontal: 8),
                                            padding: const EdgeInsets.symmetric(vertical: 3),
                                            decoration: BoxDecoration(
                                              image: const DecorationImage(
                                                image: AssetImage(AssetUtils.bgMlaFollow),
                                                fit: BoxFit.fill,
                                              ),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: const CommonKhandText(
                                              title: "Party Logo",
                                              textAlign: TextAlign.center,
                                              textColor: ColorUtils.colorWhite,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        verticalSpace(7),
                                        InkWell(
                                          onTap: () {
                                            posterProvider.onLogoSelected(-1);
                                          },
                                          child: Container(
                                            width: 170,
                                            margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                            padding: const EdgeInsets.symmetric(vertical: 3),
                                            decoration: BoxDecoration(
                                              image: const DecorationImage(
                                                image: AssetImage(AssetUtils.bgMlaFollow),
                                                fit: BoxFit.fill,
                                              ),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: const CommonKhandText(
                                              title: "Remove Logo",
                                              textAlign: TextAlign.center,
                                              textColor: ColorUtils.colorWhite,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Container(
                          //       width: 164,
                          //       padding: const EdgeInsets.only(bottom: 10),
                          //       decoration: BoxDecoration(
                          //           color: Colors.black.withOpacity(0.1),
                          //           borderRadius: const BorderRadius.all(
                          //             Radius.circular(6),
                          //           ),
                          //           image: const DecorationImage(
                          //               image: AssetImage(AssetUtils.screenBackgroundFour),
                          //               fit: BoxFit.fill)),
                          //       child: Column(
                          //         mainAxisAlignment: MainAxisAlignment.start,
                          //         children: [
                          //           Padding(
                          //             padding: const EdgeInsets.all(10),
                          //             child: widget.politicalProfileData== null || widget.politicalProfileData!.profileImg.isEmpty?Center(
                          //               child: posterProvider.image == null
                          //                   ? Container(
                          //                 height: 150,
                          //                 width: 150,
                          //                 decoration:  BoxDecoration(
                          //                   color: Colors.black.withOpacity(0.2),
                          //                 ),
                          //               ) : Image.file(posterProvider.image!,height: 150,width: 150,fit: BoxFit.fill,
                          //               ),
                          //             ):Center(
                          //               child: Image.network(widget.politicalProfileData!.profileImg,height: 150,width: 150,fit: BoxFit.fill,
                          //               ),
                          //             ),
                          //           ),
                          //           Column(
                          //             mainAxisAlignment: MainAxisAlignment.start,
                          //             crossAxisAlignment: CrossAxisAlignment.start,
                          //             children: [
                          //               GestureDetector(
                          //                 onTap: ()=>_showDialog(context,posterProvider),
                          //                 child: Container(
                          //                   width: 170,
                          //                   margin:
                          //                   const EdgeInsets.only(left: 8, right: 8),
                          //                   padding:
                          //                   const EdgeInsets.only(top: 3, bottom: 3),
                          //                   decoration: BoxDecoration(
                          //                     image: const DecorationImage(
                          //                         image:
                          //                         AssetImage(AssetUtils.bgMlaFollow),
                          //                         fit: BoxFit.fill),
                          //                     borderRadius: BorderRadius.circular(4),
                          //                   ),
                          //                   child: const CommonKhandText(
                          //                     title: "Add Image",
                          //                     textAlign: TextAlign.center,
                          //                     textColor: ColorUtils.colorWhite,
                          //                     fontWeight: FontWeight.w400,
                          //                     fontSize: 15,
                          //                   ),
                          //                 ),
                          //               ),
                          //               verticalSpace(7),
                          //               GestureDetector(
                          //                 onTap: posterProvider.removeImage,
                          //                 child: Container(
                          //                   width: 170,
                          //                   padding:
                          //                   const EdgeInsets.only(top: 3, bottom: 3),
                          //                   margin: const EdgeInsets.only(
                          //                       left: 8, right: 8, bottom: 8),
                          //                   decoration: BoxDecoration(
                          //                     image: const DecorationImage(
                          //                         image:
                          //                         AssetImage(AssetUtils.bgMlaFollow),
                          //                         fit: BoxFit.fill),
                          //                     borderRadius: BorderRadius.circular(4),
                          //                   ),
                          //                   child: const CommonKhandText(
                          //                     title: "Remove Image",
                          //                     textAlign: TextAlign.center,
                          //                     textColor: ColorUtils.colorWhite,
                          //                     fontWeight: FontWeight.w400,
                          //                     fontSize: 15,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //     Container(
                          //       width: 164,
                          //       padding: const EdgeInsets.only(bottom: 10),
                          //       decoration: BoxDecoration(
                          //           color: Colors.black.withOpacity(0.1),
                          //           borderRadius: const BorderRadius.all(
                          //             Radius.circular(6),
                          //           ),
                          //           image: const DecorationImage(
                          //               image:
                          //               AssetImage(AssetUtils.screenBackgroundFour),
                          //               fit: BoxFit.fill)),
                          //       child: Column(
                          //         mainAxisAlignment: MainAxisAlignment.start,
                          //         children: [
                          //           Container(
                          //             height: 170,
                          //             width: 170,
                          //             decoration: const BoxDecoration(
                          //               borderRadius:
                          //               BorderRadius.all(Radius.circular(12)),
                          //             ),
                          //             child: Center(
                          //               child: posterProvider.selectedLogo==-1?Container(
                          //                 height: 150,
                          //                 width: 150,
                          //                 decoration:  BoxDecoration(
                          //                     borderRadius:
                          //                     BorderRadius.all(Radius.circular(6)),
                          //                     color: Colors.black.withOpacity(0.2),
                          //                   // image: DecorationImage(
                          //                   //     image: posterProvider.selectedLogo==-1?AssetImage(AssetUtils.bgMlaFollow):NetworkImage(posterProvider.partySymbolData[posterProvider.selectedLogo].image.replaceAll("newdgs.mydigitalsaathi.com", "newdgs.mydigitalsaathi.com")),
                          //                   //     fit: BoxFit.fill
                          //                   // )
                          //                 ),
                          //               ):Image.network(posterProvider.partySymbolData[posterProvider.selectedLogo].image,height: 150,width: 150,fit: BoxFit.fill,),
                          //             ),
                          //           ),
                          //           Column(
                          //             mainAxisAlignment: MainAxisAlignment.start,
                          //             crossAxisAlignment: CrossAxisAlignment.start,
                          //             children: [
                          //               GestureDetector(
                          //                 onTap: (){
                          //                   Navigator.push(context, MaterialPageRoute(builder: (context) => AddSymbol(),));
                          //                 },
                          //                 child: Container(
                          //                   width: 170,
                          //                   margin:
                          //                   const EdgeInsets.only(left: 8, right: 8),
                          //                   padding:
                          //                   const EdgeInsets.only(top: 3, bottom: 3),
                          //                   decoration: BoxDecoration(
                          //                     image: const DecorationImage(
                          //                         image:
                          //                         AssetImage(AssetUtils.bgMlaFollow),
                          //                         fit: BoxFit.fill),
                          //                     borderRadius: BorderRadius.circular(4),
                          //                   ),
                          //                   child: const CommonKhandText(
                          //                     title: "Party Logo",
                          //                     textAlign: TextAlign.center,
                          //                     textColor: ColorUtils.colorWhite,
                          //                     fontWeight: FontWeight.w400,
                          //                     fontSize: 15,
                          //                   ),
                          //                 ),
                          //               ),
                          //               verticalSpace(7),
                          //               InkWell(
                          //                 onTap: (){
                          //                   posterProvider.onLogoSelected(-1);
                          //                 },
                          //                 child: Container(
                          //                   width: 170,
                          //                   padding:
                          //                   const EdgeInsets.only(top: 3, bottom: 3),
                          //                   margin: const EdgeInsets.only(
                          //                       left: 8, right: 8, bottom: 8),
                          //                   decoration: BoxDecoration(
                          //                     image: const DecorationImage(
                          //                         image:
                          //                         AssetImage(AssetUtils.bgMlaFollow),
                          //                         fit: BoxFit.fill),
                          //                     borderRadius: BorderRadius.circular(4),
                          //                   ),
                          //                   child: const CommonKhandText(
                          //                     title: "Remove Logo",
                          //                     textAlign: TextAlign.center,
                          //                     textColor: ColorUtils.colorWhite,
                          //                     fontWeight: FontWeight.w400,
                          //                     fontSize: 15,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          verticalSpace(20),
                          InkWell(
                            onTap: (){
                              posterProvider.resetSelection();
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddLeaderProfile()));
                            },
                            child: Container(
                              width: 170,
                              padding:
                              const EdgeInsets.only(top: 3, bottom: 3),
                              margin: const EdgeInsets.only(
                                  left: 8, right: 8, bottom: 8),
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image:
                                    AssetImage(AssetUtils.bgMlaFollow),
                                    fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const CommonKhandText(
                                title: "Add Leaders",
                                textAlign: TextAlign.center,
                                textColor: ColorUtils.colorWhite,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            child: ListView.separated(
                              separatorBuilder: (context, index) => const VerticalDivider(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: posterProvider.partyLeadersData.where((element) => element.selected).toList().length,
                              // itemCount: posterProvider.selectedLeadersInOrder.length,
                              itemBuilder: (context, index) {
                                // LeaderData leader = posterProvider.partyLeadersData.where((element) => element.selected).toList()[index];
                                LeaderData leader = posterProvider.selectedLeadersInOrder[index];
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CircleAvatar(
                                    radius: 30,
                                    child: Image.network(leader.image),
                                  ),
                                );
                              },
                            ),
                          ),
                          verticalSpace(15),
                          Container(
                            width: screenWidth(context),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.all(Radius.circular(11)),
                              // image: DecorationImage(image: AssetImage(AssetUtils.posterCheck),fit: BoxFit.fill)
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  MyTextField(
                                    controller: posterProvider.nameCtr,
                                    labelText: "Name*",
                                    validation: _validateName,
                                    keyboardType: TextInputType.name,
                                    initialValue: _name,
                                    showBorders: true,
                                    onChanged: (value) {
                                      _name = value; // Update state with the current input
                                    },
                                  ),

                                  MyTextField(
                                    controller: posterProvider.positionAreaCtr,
                                    labelText: "Position & Area*",
                                    keyboardType: TextInputType.streetAddress,
                                    validation: _validatePositionArea,
                                    showBorders: true,
                                  ),

                                  MyTextField(
                                    controller: posterProvider.partyNameCtr,
                                    labelText: "Party Name*",
                                    keyboardType: TextInputType.name,
                                    validation: _validatePartyName,
                                    showBorders: true,
                                  ),

                                  MyTextField(
                                    controller: posterProvider.evmSerialNoCtr,
                                    labelText: "EVM Serial No (optional)*",
                                    keyboardType: TextInputType.numberWithOptions(),
                                    validation: _validateEVMSerialNumber,
                                    showBorders: true,
                                  ),

                                  MyTextField(
                                    controller: posterProvider.whatsappCtr,
                                    labelText: "WhatsApp (Optional)",
                                    keyboardType: TextInputType.number,
                                    inputFormatter: [CustomInputFormatter()],
                                    validation: _validateWhatsAppNumber,
                                    showBorders: true,
                                  ),

                                  MyTextField(
                                    controller: posterProvider.facebookCtr,
                                    labelText: "Facebook (Optional)",
                                    keyboardType: TextInputType.url,
                                    //validation: _validateFacebookInput,
                                    showBorders: true,
                                  ),

                                  MyTextField(
                                    controller: posterProvider.twitterIdCtr,
                                    labelText: "Twitter (Optional)",
                                    keyboardType: TextInputType.url,
                                    // validation: _validateTwitterUsername,
                                    showBorders: true,
                                  ),

                                ],
                              ),
                            ),
                          ),
                          verticalSpace(15),
                        ],
                      ),
                    ),
                  ),
                ),
                posterProvider.isLoading?const CustomLoader():const SizedBox.shrink()
              ],
            );
          }
        )
    );
  }

  void _showDialog(BuildContext context,PosterProvidder posterProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final themeProvider = Provider.of<DarkThemeProvider>(context);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          title: Align(
            alignment: Alignment.centerLeft,
            child: CommonKhandText(
              title: "Set Profile image",
              fontWeight: FontWeight.w300,
              textColor: themeProvider.darkTheme
                  ? ColorUtils.colorWhite
                  : ColorUtils.colorBlack,
              fontSize: 20,
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: ()=> posterProvider.pickImage(ImageSource.camera),
                    child: CommonKhandText(
                      title: "Take a Picture",
                      fontWeight: FontWeight.w300,
                      textColor: themeProvider.darkTheme
                          ? ColorUtils.colorWhite
                          : ColorUtils.colorBlack,
                      fontSize: 17,
                    ),
                  ),
                  verticalSpace(15),
                  GestureDetector(
                    onTap: ()=>posterProvider.pickImage(ImageSource.gallery),
                    child: CommonKhandText(
                      title: "Choose From gallery",
                      fontWeight: FontWeight.w300,
                      textColor: themeProvider.darkTheme
                          ? ColorUtils.colorWhite
                          : ColorUtils.colorBlack,
                      fontSize: 17,
                    ),
                  ),

                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String? _validateName(String? value) {
    // Regular expression for name validation (only letters and spaces)
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    } else if (!nameRegExp.hasMatch(value)) {
      return 'Please enter a valid name (letters and spaces only)';
    }
    return null; // Return null if validation passes
  }

  String? _validatePositionArea(String? value) {

    // Regular expression for position area validation (letters, numbers, and underscores)
    final RegExp positionAreaRegExp = RegExp(r'^[a-zA-Z0-9_ ]+$');

    if (value == null || value.isEmpty) {
      return 'Please enter a position area';
    } else if (!positionAreaRegExp.hasMatch(value)) {
      return 'Please enter a valid position area (letters, numbers, spaces, and underscores only)';
    }
    return null; // Return null if validation passes
  }

  String? _validatePartyName(String? value) {
    // Regular expression for party name validation (letters, numbers, spaces, and some special characters)
    final RegExp partyNameRegExp = RegExp(r'^[a-zA-Z0-9\s&-]+$');

    if (value == null || value.isEmpty) {
      return 'Please enter a party name';
    } else if (value.length < 3) {
      return 'Party name must be at least 3 characters long';
    } else if (!partyNameRegExp.hasMatch(value)) {
      return 'Please enter a valid party name (letters, numbers, spaces, ampersands, and hyphens only)';
    }
    return null; // Return null if validation passes
  }

  String? _validateWhatsAppNumber(String? value) {
    // Regular expression for WhatsApp number validation
   // final RegExp whatsAppRegExp = RegExp(r'^\+\d{1,3}\s?\d{1,14}$');

    // if (value == null || value.isEmpty) {
    //   return 'Please enter your WhatsApp number';
    // }
    // else if (!whatsAppRegExp.hasMatch(value)) {
    //   return 'Please enter a valid WhatsApp number (e.g., +123 4567890123)';
    // }
    return null; // Return null if validation passes
  }

  String? _validateFacebookInput(String? value) {
    // Regular expression for Facebook username or profile URL validation
    // final RegExp usernameRegExp = RegExp(r'^[a-zA-Z0-9._]+$');
    // final RegExp urlRegExp =
    //     RegExp(r'^https?:\/\/(www\.)?facebook\.com\/[a-zA-Z0-9._]+$');

    if (value == null || value.isEmpty) {
      return 'Please enter a Facebook username or profile link';
    }
    // else if (!usernameRegExp.hasMatch(value) && !urlRegExp.hasMatch(value)) {
    //   return 'Please enter a valid Facebook username or profile link';
    // }
    return null; // Return null if validation passes
  }

  String? _validateTwitterUsername(String? value) {
    // Regular expression for Twitter username validation
    //final RegExp usernameRegExp = RegExp(r'^@([A-Za-z0-9_]{1,15})$');

    if (value == null || value.isEmpty) {
      return 'Please enter a Twitter username';
    }
    // else if (!usernameRegExp.hasMatch(value)) {
    //   return 'Please enter a valid Twitter username (e.g., @username)';
    // }
    return null; // Return null if validation passes
  }

  String? _validateEVMSerialNumber(String? value) {
    // Regular expression for EVM serial number validation
   // final RegExp evmSerialRegExp = RegExp(r'^[A-Z0-9-]{10,15}$');

    // if (value == null || value.isEmpty) {
    //   return 'Please enter the EVM serial number';
    // }
    // else if (!evmSerialRegExp.hasMatch(value)) {
    //   return 'Please enter a valid EVM serial number (10-15 characters, letters, numbers, and hyphens)';
    // }
    return null; // Return null if validation passes
  }
}

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Example: Allow only numeric input
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
