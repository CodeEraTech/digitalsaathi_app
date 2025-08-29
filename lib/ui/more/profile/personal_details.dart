import 'dart:convert';
import 'dart:io';
import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/constants/components/my_TextField.dart';
import 'package:digitalsaathi/data/model/profile_model.dart';
import 'package:digitalsaathi/provider/profile_provider.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../constants/components/pro_text.dart';
import '../../../provider/theme_provider.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/asset_utils.dart';
import '../../../utils/color_utils.dart';
import 'dart:typed_data' as my_bytes;

class PersonalDetails extends StatefulWidget {
  final ProfileData profileData;
  const PersonalDetails({super.key,required this.profileData});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData(widget.profileData);
  }

  TextEditingController myEpicCtr = TextEditingController();
  TextEditingController boothCtr = TextEditingController();
  TextEditingController nameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController dobCtr = TextEditingController();
  TextEditingController referralCodeCtr = TextEditingController();
  TextEditingController houseNoCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();
  TextEditingController pollingStationNameCtr = TextEditingController();
  TextEditingController facebookProfileUrlCtr = TextEditingController();
  TextEditingController twitterProfileUrlCtr = TextEditingController();
  TextEditingController instagramProfileUrlCtr = TextEditingController();
  TextEditingController youtubeProfileUrlCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String base64Image = "";
  File? _image;
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        cropStyle: CropStyle.circle,
        compressFormat: ImageCompressFormat.png,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor:Color(0xff28B3D5),
            toolbarWidgetColor:Color(0xffffffff),
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            activeControlsWidgetColor: ColorUtils.primaryColor,
            backgroundColor: ColorUtils.darkTheme,
            showCropGrid: false,
            cropFrameColor: Colors.transparent
          ),
          IOSUiSettings(
            title: 'Crop Image',

          ),
          WebUiSettings(
            context: context,

          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _image = File(croppedFile.path);
          getBase64Image();
        });
      }
    }
  }

  getBase64Image() {
    if (_image != null) {
      List<int> imageBytes = _image!.readAsBytesSync();
      print(imageBytes);
      base64Image = "/9j/" + base64Encode(imageBytes);
      print('Base64 Image: $base64Image');
    }
  }
  // String base64Image = "";
  // File? _image;
  // Future<void> _pickImage(ImageSource source) async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: source);
  //
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //       getBase64Image();
  //     });
  //   }
  // }
  // getBase64Image(){
  //   List<int> imageBytes = _image!.readAsBytesSync();
  //   print(imageBytes);
  //    base64Image = "/9j/"+base64Encode(imageBytes);
  // }





  Future<void> _submitData(ProfileProvider profileProvider) async {
    if (_formKey.currentState!.validate()) {


      final data = {
        "api_token":AppUrl.apiToken,
        'id_card_no': myEpicCtr.text,
        'booth_number': boothCtr.text,
        'full_name': nameCtr.text,
        'email': emailCtr.text,
        'dob': selectedDate==null?"":formatSelectedDate(selectedDate),
        'referral_code': "",
        'marriage_anniversary': "",
        'relation_with_worker': "",
        'category': "",
        'rname': "",
        'rtype': "",
        'sno': "",
        'age': "",
        'house_no': houseNoCtr.text,
        'address': addressCtr.text,
        'pooling_station_name': pollingStationNameCtr.text,
        'facebook_profile_url': facebookProfileUrlCtr.text,
        'twitter_profile_url': twitterProfileUrlCtr.text,
        'instagram_profile_url': instagramProfileUrlCtr.text,
        'youtube_profile_url': youtubeProfileUrlCtr.text,
      };

      print(data);

     profileProvider.updateProfile(data,context,_image);
    }
  }

  setData(ProfileData data){
    myEpicCtr.text = data.idCardNo.toString();
    boothCtr.text = data.boothNumber.toString();
    nameCtr.text = data.fullName.toString();
    emailCtr.text = data.email.toString();
    //dobCtr.text = data.dateOfBirth.toString();
    referralCodeCtr.text = data.referralCode.isNotEmpty?data.referralCode[0].referralCode.toString():"";
    houseNoCtr.text = data.houseNo.toString();
    addressCtr.text = data.address.toString();
    pollingStationNameCtr.text = data.poolingStationName.toString();
    facebookProfileUrlCtr.text = data.facebookProfileUrl.toString();
    twitterProfileUrlCtr.text = data.twitterProfileUrl.toString();
    instagramProfileUrlCtr.text = data.instagramProfileUrl.toString();
    youtubeProfileUrlCtr.text = data.youtubeProfileUrl.toString();

    if(data.dateOfBirth.toString().isEmpty || data.dateOfBirth.toString() == "0000-00-00"){

    }else{
      DateFormat format = DateFormat("yyyy-MM-dd");
      DateTime ct = format.parse(data.dateOfBirth.toString());

      selectedDate = ct;
    }
  }




  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeProvider.darkTheme ?  ColorUtils.darkTheme: ColorUtils.lightTheme,
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
        title:  CommonKhandText(
          title: widget.profileData.fullName,
          textColor: Color(0xffffffff),
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context,profileProvider,_) {
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
                  padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
                  reverse: true,
                  child: Column(
                    children: [
                      verticalSpace(10),
                      Card(
                        elevation: 5,
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        child: Container(
                          width: screenWidth(context),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage(AssetUtils.screenBackgroundSix),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100)),
                                    child: SizedBox(
                                      height: 110,
                                      width: 110,
                                      // color: Colors.red,
                                      child: (widget.profileData.userProfilePicture.toString().isNotEmpty && _image == null)? Center(
                                        child: Container(
                                          height: 120,
                                          width: 120,
                                          decoration:  BoxDecoration(
                                            color: Colors.black.withOpacity(0.2),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: NetworkImage(AppUrl.BASE_IMAGE_URL+widget.profileData.userProfilePicture.toString()),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ):Center(
                                        child:
                                        Container(
                                          height: 120,
                                          width: 120,
                                          decoration:  BoxDecoration(
                                            color: _image == null ? Colors.black.withOpacity(0.2) : null,
                                            shape: BoxShape.circle,
                                              image: _image == null
                                                  ? null
                                                  : DecorationImage(
                                                image: FileImage(_image!),
                                                fit: BoxFit.cover,
                                              ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                   onTap: ()=>_pickImage(ImageSource.gallery),
                                    child: Container(
                                      transform: Matrix4.translationValues(0.0, -5.0, 0.0),
                                      child: const Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    // onTap: (){
                                    //   showDialog(
                                    //     context: context,
                                    //     builder: (context) => Dialog(
                                    //       shape: RoundedRectangleBorder(
                                    //         borderRadius: BorderRadius.circular(10),
                                    //       ),
                                    //       alignment: Alignment.topCenter,
                                    //       insetPadding: EdgeInsets.only(top: 60),
                                    //       child: Container(
                                    //         height: screenHeight(context),
                                    //         width: screenWidth(context),
                                    //         child: Column(
                                    //           children: [
                                    //             Card(
                                    //
                                    //               elevation: 5,
                                    //               // margin: const EdgeInsets.only(left: 8, right: 8),
                                    //               child: Container(
                                    //                 width: screenWidth(context),
                                    //                 padding: const EdgeInsets.all(10),
                                    //                 decoration: BoxDecoration(
                                    //                     image: const DecorationImage(
                                    //                         image: AssetImage(AssetUtils.screenBackgroundSix),
                                    //                         fit: BoxFit.fill),
                                    //                     borderRadius: BorderRadius.circular(10)),
                                    //                 child: Column(
                                    //                   children: [
                                    //                     Card(
                                    //                       elevation: 5,
                                    //                       shape: RoundedRectangleBorder(
                                    //                           borderRadius: BorderRadius.circular(100)),
                                    //                       child: SizedBox(
                                    //                         height: 110,
                                    //                         width: 110,
                                    //                         // color: Colors.red,
                                    //                         child: (widget.profileData.userProfilePicture.toString().isNotEmpty && _image == null)? Center(
                                    //                           child: Container(
                                    //                             height: 120,
                                    //                             width: 120,
                                    //                             decoration:  BoxDecoration(
                                    //                               color: Colors.black.withOpacity(0.2),
                                    //                               shape: BoxShape.circle,
                                    //                               image: DecorationImage(
                                    //                                 image: NetworkImage(AppUrl.BASE_IMAGE_URL+widget.profileData.userProfilePicture.toString()),
                                    //                                 fit: BoxFit.fill,
                                    //                               ),
                                    //                             ),
                                    //                           ),
                                    //                         ):Center(
                                    //                           child:
                                    //                           Container(
                                    //                             height: 120,
                                    //                             width: 120,
                                    //                             decoration:  BoxDecoration(
                                    //                               color: _image == null ? Colors.black.withOpacity(0.2) : null,
                                    //                               shape: BoxShape.circle,
                                    //                               image: _image == null
                                    //                                   ? null
                                    //                                   : DecorationImage(
                                    //                                 image: FileImage(_image!),
                                    //                                 fit: BoxFit.fill,
                                    //                               ),
                                    //                             ),
                                    //                           ),
                                    //                         ),
                                    //                       ),
                                    //                     ),
                                    //                     verticalSpace(10),
                                    //                     Row(
                                    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //                       children: [
                                    //                         CommonKhandText(
                                    //                           title: "Mobile: ${widget.profileData.mobile}",
                                    //                           textColor: Color(0xffffffff),
                                    //                           fontWeight: FontWeight.w300,
                                    //                           fontSize: 16,
                                    //                         ),
                                    //                         CommonKhandText(
                                    //                           title: "${widget.profileData.gender}",
                                    //                           textColor: Color(0xffffffff),
                                    //                           fontWeight: FontWeight.w300,
                                    //                           fontSize: 16,
                                    //                         ),
                                    //                       ],
                                    //                     ),
                                    //                     verticalSpace(10),
                                    //                     Card(
                                    //                       elevation: 5,
                                    //                       shape: RoundedRectangleBorder(
                                    //                           borderRadius: BorderRadius.circular(10)),
                                    //                       child: Container(
                                    //                         padding: const EdgeInsets.only(
                                    //                             left: 20, right: 20, top: 5, bottom: 5),
                                    //                         width: screenWidth(context),
                                    //                         decoration: BoxDecoration(
                                    //                             color: Colors.white.withOpacity(0.2),
                                    //                             image: const DecorationImage(
                                    //                                 image: AssetImage(
                                    //                                     AssetUtils.screenBackgroundFive),
                                    //                                 fit: BoxFit.fill),
                                    //                             borderRadius: BorderRadius.circular(10)),
                                    //                         child:  Row(
                                    //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //                           children: [
                                    //                             Column(
                                    //                               mainAxisAlignment: MainAxisAlignment.start,
                                    //                               crossAxisAlignment: CrossAxisAlignment.center,
                                    //                               children: [
                                    //                                 CommonKhandText(
                                    //                                   title: "${widget.profileData.following}",
                                    //                                   textColor: Color(0xffffffff),
                                    //                                   fontWeight: FontWeight.w300,
                                    //                                   fontSize: 13,
                                    //                                 ),
                                    //                                 CommonKhandText(
                                    //                                   title: "Following",
                                    //                                   textColor: Color(0xffffffff),
                                    //                                   fontWeight: FontWeight.w300,
                                    //                                   fontSize: 14,
                                    //                                 ),
                                    //                               ],
                                    //                             ),
                                    //                             Column(
                                    //                               mainAxisAlignment: MainAxisAlignment.start,
                                    //                               crossAxisAlignment: CrossAxisAlignment.center,
                                    //                               children: [
                                    //                                 CommonKhandText(
                                    //                                   title: "${widget.profileData.followers}",
                                    //                                   textColor: Color(0xffffffff),
                                    //                                   fontWeight: FontWeight.w300,
                                    //                                   fontSize: 13,
                                    //                                 ),
                                    //                                 CommonKhandText(
                                    //                                   title: "Followers",
                                    //                                   textColor: Color(0xffffffff),
                                    //                                   fontWeight: FontWeight.w300,
                                    //                                   fontSize: 14,
                                    //                                 ),
                                    //                               ],
                                    //                             ),
                                    //                             Column(
                                    //                               mainAxisAlignment: MainAxisAlignment.start,
                                    //                               crossAxisAlignment: CrossAxisAlignment.center,
                                    //                               children: [
                                    //                                 CommonKhandText(
                                    //                                   title: "${widget.profileData.todayCount}",
                                    //                                   textColor: Color(0xffffffff),
                                    //                                   fontWeight: FontWeight.w300,
                                    //                                   fontSize: 13,
                                    //                                 ),
                                    //                                 CommonKhandText(
                                    //                                   title: "Total EPIC",
                                    //                                   textColor: Color(0xffffffff),
                                    //                                   fontWeight: FontWeight.w300,
                                    //                                   fontSize: 14,
                                    //                                 ),
                                    //                               ],
                                    //                             ),
                                    //                           ],
                                    //                         ),
                                    //                       ),
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //             // Container(
                                    //             //   height: 350,
                                    //             //   width: screenWidth(context),
                                    //             //   color: Colors.black,
                                    //             //   padding: const EdgeInsets.all(25),
                                    //             //   child: Column(
                                    //             //     children: [
                                    //             //       Row(
                                    //             //         children: [
                                    //             //           const Icon(Icons.remove, color: Colors.white),
                                    //             //           const SizedBox(width: 8),
                                    //             //           const Text("Select", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16)),
                                    //             //           const SizedBox(width: 4),
                                    //             //           const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                                    //             //           const Spacer(),
                                    //             //           const Text("Done", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w300, fontSize: 18)),
                                    //             //         ],
                                    //             //       ),
                                    //             //       const SizedBox(height: 20),
                                    //             //       Container(
                                    //             //         height: 250,
                                    //             //         width: 250,
                                    //             //         padding: const EdgeInsets.all(15),
                                    //             //         decoration: const BoxDecoration(
                                    //             //           color: Colors.white,
                                    //             //           shape: BoxShape.circle,
                                    //             //         ),
                                    //             //         child: selectedImageBytes != null
                                    //             //             ? ClipOval(
                                    //             //           child: Image.memory(
                                    //             //             selectedImageBytes!,
                                    //             //             fit: BoxFit.cover,
                                    //             //           ),
                                    //             //         )
                                    //             //             : const Center(
                                    //             //           child: Text("No Image", style: TextStyle(color: Colors.black)),
                                    //             //         ),
                                    //             //       ),
                                    //             //     ],
                                    //             //   ),
                                    //             // ),
                                    //             Expanded(
                                    //               child: Container(
                                    //                 color: Colors.grey[200],
                                    //                 padding: const EdgeInsets.all(8),
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     ),
                                    //       // child: Container(
                                    //       //   height: screenHeight(context),
                                    //       //   width: screenWidth(context),
                                    //       //   // padding: EdgeInsets.all(20),
                                    //       //   child: Column(
                                    //       //     mainAxisSize: MainAxisSize.min,
                                    //       //     crossAxisAlignment: CrossAxisAlignment.center,
                                    //       //     children: [
                                    //       //       Container(
                                    //       //         height: 350,
                                    //       //         width: screenWidth(context),
                                    //       //         color: ColorUtils.colorBlack,
                                    //       //         padding: EdgeInsets.all(25),
                                    //       //         child: Column(
                                    //       //           children: [
                                    //       //             Row(
                                    //       //
                                    //       //               children: [
                                    //       //                 Icon(Icons.remove,color: ColorUtils.colorWhite,),
                                    //       //                 horizontalSpace(8),
                                    //       //                 Row(
                                    //       //                   children: [
                                    //       //                     CommonKhandText(
                                    //       //                       title: "Select ",
                                    //       //                       textColor: Color(0xffffffff),
                                    //       //                       fontWeight: FontWeight.w300,
                                    //       //                       fontSize: 16,
                                    //       //                     ),
                                    //       //                     horizontalSpace(4),
                                    //       //                     Icon(Icons.keyboard_arrow_down,color: ColorUtils.colorWhite,)
                                    //       //                   ],
                                    //       //                 ),
                                    //       //                 Spacer(),
                                    //       //                 CommonKhandText(
                                    //       //                   title: "Done",
                                    //       //                   textColor: Colors.blue,
                                    //       //                   fontWeight: FontWeight.w300,
                                    //       //                   fontSize: 18,
                                    //       //                 ),
                                    //       //               ],
                                    //       //
                                    //       //             ),
                                    //       //             verticalSpace(20),
                                    //       //             Container(
                                    //       //               height: 250,
                                    //       //               width: 250,
                                    //       //               padding: EdgeInsets.all(15),
                                    //       //               decoration:  BoxDecoration(
                                    //       //                 color: ColorUtils.colorWhite,
                                    //       //                 shape: BoxShape.circle
                                    //       //               ),
                                    //       //               /// image dikhana hai is me
                                    //       //             ),
                                    //       //           ],
                                    //       //         ),
                                    //       //       ),
                                    //       //       Expanded(
                                    //       //           // flex: 2,
                                    //       //           child: Container(color: Colors.red,)
                                    //       //               /// is container me mujhe mobile ka galley me jitna bhi photo o mujhe is container me dikhna hai
                                    //       //         /// or selected image ko dikhana hai
                                    //       //       ),
                                    //       //
                                    //       //     ],
                                    //       //   ),
                                    //       // ),
                                    //   );
                                    // },
                                  )
                                ],
                              ),
                              verticalSpace(10),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CommonKhandText(
                                    title: "Mobile: ${widget.profileData.mobile}",
                                    textColor: Color(0xffffffff),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                  ),
                                  CommonKhandText(
                                    title: "${widget.profileData.gender}",
                                    textColor: Color(0xffffffff),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                  ),
                                ],
                              ),
                              verticalSpace(10),
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 5, bottom: 5),
                                  width: screenWidth(context),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              AssetUtils.screenBackgroundFive),
                                          fit: BoxFit.fill),
                                      borderRadius: BorderRadius.circular(10)),
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CommonKhandText(
                                            title: "${widget.profileData.following}",
                                            textColor: Color(0xffffffff),
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13,
                                          ),
                                          CommonKhandText(
                                            title: "Following",
                                            textColor: Color(0xffffffff),
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CommonKhandText(
                                            title: "${widget.profileData.followers}",
                                            textColor: Color(0xffffffff),
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13,
                                          ),
                                          CommonKhandText(
                                            title: "Followers",
                                            textColor: Color(0xffffffff),
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CommonKhandText(
                                            title: "${widget.profileData.todayCount}",
                                            textColor: Color(0xffffffff),
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13,
                                          ),
                                          CommonKhandText(
                                            title: "Total EPIC",
                                            textColor: Color(0xffffffff),
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: MyTextField(
                                      controller: myEpicCtr,
                                      labelText: "MY EPIC",
                                      maxLines: 1,
                                      keyboardType: TextInputType.name,
                                      validation: _validateMyEpic,
                                      showBorders: true,
                                    ),
                                  ),

                                  Container(
                                    height: 30,
                                    child: ElevatedButton(

                                        onPressed: (){
                                          if(myEpicCtr.text.toString().isEmpty){
                                            Utils.toastMessage("Please enter EPIC number!!!");
                                            return;
                                          }
                                          profileProvider.getEPICNumber(myEpicCtr.text.toString(),myEpicDataCallBack);
                                        }, child: Text("Update",style: TextStyle(color: ColorUtils.colorBlack),)),
                                  )
                                ],
                              ),

                              verticalSpace(10),

                              MyTextField(
                                showBorders: true,
                                controller: boothCtr,
                                maxLines: 1,
                                labelText: "Booth No.",
                                keyboardType: TextInputType.number,
                                validation: _validateBoothNo,
                              ),

                              verticalSpace(10),
                              MyTextField(
                                showBorders: true,
                                controller: nameCtr,
                                labelText: "Name",
                                maxLines: 1,
                                keyboardType: TextInputType.name,
                                validation: _validateMyName,
                              ),

                              verticalSpace(8),
                              MyTextField(
                                showBorders: true,
                                controller: emailCtr,
                                labelText: "Email ID",
                                maxLines: 1,
                                keyboardType: TextInputType.emailAddress,
                                validation: _validateEmail,
                              ),
                              verticalSpace(15),

                              GestureDetector(
                                onTap: ()=>_selectDate(context),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CommonKhandText(
                                      title: formatSelectedDate(selectedDate),
                                      textColor: Color(0xffffffff),
                                      // fontWeight: FontWeight.w300,
                                      fontSize: 15,
                                    ),
                                    Icon(Icons.calendar_month,color: ColorUtils.colorWhite,)
                                  ],
                                ),
                              ),
                              verticalSpace(10),
                              Container(height: 1,width: screenWidth(context),color: Colors.white.withOpacity(0.9),),
                              MyTextField(
                                controller: referralCodeCtr,
                                labelText: "Referral Code",
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                validation: _validateReferralCode, showBorders: true,
                              ),
                              verticalSpace(10),

                              MyTextField(
                                showBorders: true,
                                controller: houseNoCtr,
                                labelText: "House No",
                                maxLines: 1,
                                keyboardType: TextInputType.streetAddress,
                                validation: _validateHouseNo,
                              ),

                              verticalSpace(10),
                              MyTextField(
                                showBorders: true,
                                controller: addressCtr,
                                labelText: "Address",
                                maxLines: 1,
                                keyboardType: TextInputType.streetAddress,
                                validation: _validateAddress,
                              ),
                              verticalSpace(10),

                              MyTextField(
                                showBorders: true,
                                controller: pollingStationNameCtr,
                                maxLines: 1,
                                labelText: "Polling Station Name",
                                keyboardType: TextInputType.name,
                                validation: _validatePollingStationName,
                              ),
                              verticalSpace(10),
                              MyTextField(
                                showBorders: true,
                                controller: facebookProfileUrlCtr,
                                labelText: "Facebook Profile Url",
                                maxLines: 1,
                                keyboardType: TextInputType.url,
                                validation: _validateFacebookProfileUrl,
                              ),
                              verticalSpace(10),
                              MyTextField(
                                showBorders: true,
                                controller: twitterProfileUrlCtr,
                                maxLines: 1,
                                labelText: "Twitter Profile Url",
                                keyboardType: TextInputType.url,
                                validation: _validateTwitterProfileUrl,
                              ),
                              verticalSpace(10),
                              MyTextField(
                                showBorders: true,
                                controller: instagramProfileUrlCtr,
                                maxLines: 1,
                                labelText: "Instagram Profile Url",
                                keyboardType: TextInputType.url,
                                validation: _validateInstagramProfileUrl,
                              ),
                              verticalSpace(10),
                              MyTextField(
                                showBorders: true,
                                controller: youtubeProfileUrlCtr,
                                labelText: "Youtube Profile Url",
                                maxLines: 1,
                                keyboardType: TextInputType.url,
                                validation: _validateYoutubeProfileUrl,
                              ),
                              verticalSpace(25),
                              GestureDetector(
                                onTap: ()=>_submitData(profileProvider),
                                child: Container(
                                  height: 55,
                                  width: screenWidth(context),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.16),
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                        image:
                                            AssetImage(AssetUtils.screenBackgroundFive),
                                        fit: BoxFit.fill),
                                  ),
                                  child: const Center(
                                    child: CommonKhandText(
                                      title: "Update Profile",
                                      textColor: Color(0xffffffff),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              verticalSpace(25),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              profileProvider.isLoading?CustomLoader():SizedBox.shrink()
            ],
          );
        }
      ),
    );
  }

  myEpicDataCallBack(var epic){
    if(epic != null){
      boothCtr.text = epic.boothNumber.toString();
      houseNoCtr.text = epic.houseNo.toString();
      addressCtr.text = epic.address.toString();
      pollingStationNameCtr.text = epic.poolingStationName.toString();
      nameCtr.text = epic.firstName.toString();
      setState(() {

      });
    }
  }

  String? _validateMyEpic(String? value) {
    // if (value == null || value.isEmpty) {
    //   return 'Please enter your epic';
    // }
    // Additional checks can go here
    return null; // valid
  }

  String? _validateBoothNo(String? value) {
   // if (value == null || value.isEmpty) {
    //   return 'Please enter your booth number';
    // }
    // if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    //   return 'Booth number must be numeric';
    // }
    return null; // valid
  }

  String? _validateMyName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null; // valid
  }

  String? _validateEmail(String? value) {
    // if (value == null || value.isEmpty) {
    //   return 'Please enter your email';
    // }
    // if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    //   return 'Please enter a valid email address';
    // }
    return null; // valid
  }

  String? _validateDOB(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your date of birth';
    }
    // You can add more specific checks for date format here
    return null; // valid
  }

  String? _validateReferralCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a referral code';
    }
    return null; // valid
  }

  String? _validateHouseNo(String? value) {
    // if (value == null || value.isEmpty) {
    //   return 'Please enter your house number';
    // }
    // if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    //   return 'House number must be numeric';
    // }
    return null; // valid
  }

  String? _validateAddress(String? value) {
    // if (value == null || value.isEmpty) {
    //   return 'Please enter your address';
    // }
    return null; // valid
  }

  String? _validatePollingStationName(String? value) {
    // if (value == null || value.isEmpty) {
    //   return 'Please enter polling station name';
    // }
    return null; // valid
  }

  String? _validateFacebookProfileUrl(String? value) {
    // if (value != null && value.isNotEmpty && !Uri.tryParse(value)!.isAbsolute) {
    //   return 'Please enter a valid URL';
    // }
    return null; // valid
  }

  String? _validateTwitterProfileUrl(String? value) {
    // if (value != null && value.isNotEmpty && !Uri.tryParse(value)!.isAbsolute) {
    //   return 'Please enter a valid URL';
    // }
    return null; // valid
  }

  String? _validateInstagramProfileUrl(String? value) {
    // if (value != null && value.isNotEmpty && !Uri.tryParse(value)!.isAbsolute) {
    //   return 'Please enter a valid URL';
    // }
    return null; // valid
  }

  String? _validateYoutubeProfileUrl(String? value) {
    // if (value != null && value.isNotEmpty && !Uri.tryParse(value)!.isAbsolute) {
    //   return 'Please enter a valid URL';
    // }
    return null; // valid
  }

  void _showSnackbar(String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        textAlign: TextAlign.center,
        borderRadius: BorderRadius.circular(8),
        message: message,
        textStyle: GoogleFonts.playfairDisplay(color: Colors.white, fontSize: 14),
      ),
    );
  }

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            datePickerTheme: DatePickerThemeData(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                )
            ),
            primaryColor: Colors.blue, // Header color
            hintColor: Colors.blue,   // Selected date color
            colorScheme: ColorScheme.light(primary: Colors.blue),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },

    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String formatSelectedDate(DateTime? date) {
    if (date == null) {
      return 'Date Of Birth*';
    }
    return DateFormat('yyyy-MM-dd').format(date);
  }

}

