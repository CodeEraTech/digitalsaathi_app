import 'dart:convert';

import 'package:digitalsaathi/constants/Api_Services/api_services.dart';
import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/data/model/assembly_model.dart';
import 'package:digitalsaathi/data/model/constituency_response.dart';
import 'package:digitalsaathi/data/model/district_response.dart';
import 'package:digitalsaathi/data/model/state_response.dart';
import 'package:digitalsaathi/provider/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../constants/components/my_TextField.dart';
import '../../constants/components/pro_text.dart';
import '../../provider/theme_provider.dart';
import '../../utils/app_utils.dart';
import '../../utils/color_utils.dart';


class RegistrationDone extends StatefulWidget {
  final name;

  final mobile;

  final email;

  final Dob;

  final gender;
  final userId;

  const RegistrationDone(
      {super.key, this.name, this.mobile, this.email, this.Dob, this.gender,required this.userId});

  @override
  State<RegistrationDone> createState() => _RegistrationDoneState();
}

class _RegistrationDoneState extends State<RegistrationDone> {
  TextEditingController referralCodeCtr = TextEditingController();
  TextEditingController relationNameCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();
  TextEditingController boothNoCtr = TextEditingController();

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<
      ScaffoldMessengerState>();


  @override
  void initState() {
    super.initState();
    Provider.of<RegisterProvider>(context,listen: false).resetData();
  }



  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: themeProvider.darkTheme
            ? ColorUtils.colorBlack
            : ColorUtils.lightTheme,
        body: Consumer<RegisterProvider>(
            builder: (context, registerProvider, _) {
              return Stack(
                children: [
                  Container(
                    height: screenHeight(context),
                    width: screenWidth(context),
                    decoration: const BoxDecoration(color: Colors.black),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SafeArea(
                          child: Column(
                            children: [
                              verticalSpace(20),
                              CommonKhandText(
                                title: "Hi ${widget.name}",
                                textColor: Colors.white,
                                fontSize: 25,
                              ),
                              CommonKhandText(
                                title: "We are almost done here!",
                                textColor: Colors.white,
                                fontSize: 18,
                              ),
                              verticalSpace(30),
                              // CSCPicker(
                              //   showStates: true,
                              //   showCities: true,
                              //   flagState: CountryFlag.ENABLE,
                              //   countrySearchPlaceholder: "Country*",
                              //   stateSearchPlaceholder: "State*",
                              //   citySearchPlaceholder: "City*",
                              //   countryDropdownLabel: "Country*",
                              //   stateDropdownLabel: "State*",
                              //   cityDropdownLabel: "City*",
                              //   selectedItemStyle: TextStyle(
                              //     color: Colors.white,
                              //     fontSize: 14,
                              //   ),
                              //   dropdownHeadingStyle: TextStyle(
                              //       color: Colors.white,
                              //       fontSize: 17,
                              //       fontWeight: FontWeight.bold),
                              //   dropdownItemStyle: TextStyle(
                              //     color: Colors.white,
                              //     fontSize: 14,
                              //   ),
                              //   dropdownDecoration: BoxDecoration(
                              //       borderRadius: BorderRadius.all(Radius.circular(10)),
                              //       color: Colors.black,
                              //       border: Border.all(
                              //           color: Colors.white.withOpacity(0.3), width: 1)),
                              //   disabledDropdownDecoration: BoxDecoration(
                              //       borderRadius: BorderRadius.all(Radius.circular(10)),
                              //       color: Colors.black,
                              //       border: Border.all(
                              //           color: Colors.white.withOpacity(0.2), width: 1)),
                              //   dropdownDialogRadius: 10.0,
                              //   searchBarRadius: 30,
                              //   onCountryChanged: (value) {
                              //     setState(() {
                              //       print("Selected country: ${value}");
                              //       countryValue = value!;
                              //     });
                              //   },
                              //   onStateChanged: (value) {
                              //     setState(() {
                              //       stateValue = value;
                              //     });
                              //   },
                              //   onCityChanged: (value) {
                              //     setState(() {
                              //       cityValue = value;
                              //     });
                              //   },
                              // ),
                              verticalSpace(10),
                              Container(
                                height: 55,
                                padding: EdgeInsets.fromLTRB(15, 2, 15, 5),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                // or screenWidth(context)
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black,
                                ),
                                child: DropdownButton<String>(
                                  iconSize: 30,
                                  isExpanded: true,
                                  iconEnabledColor: Colors.white,
                                  elevation: 4,
                                  underline: Container(),
                                  dropdownColor: Colors.black,
                                  // Adjust based on your theme
                                  style: GoogleFonts.playfairDisplay(
                                    textStyle: const TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                  hint: const Text(
                                    "Country",
                                    style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15),
                                  ),
                                  value: registerProvider.selectedCountry,
                                  items: ["India"].map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 15),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    registerProvider.onCountryChange(newValue!);
                                  },
                                ),
                              ),
                              verticalSpace(10),
                              Container(
                                height: 55,
                                padding: EdgeInsets.fromLTRB(15, 2, 15, 5),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                // or screenWidth(context)
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.3)),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black,
                                ),
                                child: DropdownButton<StateData>(
                                  iconSize: 30,
                                  isExpanded: true,
                                  iconEnabledColor: Colors.white,
                                  elevation: 4,
                                  underline: Container(),
                                  dropdownColor: Colors.black,
                                  // Adjust based on your theme
                                  style: GoogleFonts.playfairDisplay(
                                    textStyle: const TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                  hint: const Text(
                                    "State",
                                    style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15),
                                  ),
                                  value: registerProvider.selectedState,
                                  items: registerProvider.stateData.map((
                                      StateData item) {
                                    return DropdownMenuItem<StateData>(
                                      value: item,
                                      child: Text(
                                        item.StateName,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 15),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (StateData? newValue) {
                                    registerProvider.onStateChange(newValue!);
                                  },
                                ),
                              ),
                              verticalSpace(10),
                              Container(
                                height: 55,
                                padding: EdgeInsets.fromLTRB(15, 2, 15, 5),
                                width: screenWidth(context),
                                decoration: BoxDecoration(
                                    border:
                                    Border.all(
                                        color: Colors.white.withOpacity(0.3)),
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black),
                                child: DropdownButton<DistrictData>(
                                  iconSize: 30,
                                  isExpanded: true,
                                  iconEnabledColor: ColorUtils.colorWhite,
                                  //menuWidth: screenWidth(context) * 0.8,
                                  elevation: 4,
                                  underline: Container(),
                                  dropdownColor: themeProvider.darkTheme
                                      ? ColorUtils.colorBlack
                                      : ColorUtils.colorBlack,
                                  style: GoogleFonts.playfairDisplay(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        color: ColorUtils.colorWhite),
                                  ),
                                  hint: const CommonKhandText(
                                    title: "District*",
                                    textColor: ColorUtils.colorWhite,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                  ),
                                  value: registerProvider.selectedDistrict,
                                  items: registerProvider.districtData.map((
                                      DistrictData item) {
                                    return DropdownMenuItem<DistrictData>(
                                      value: item,
                                      child: CommonKhandText(
                                        title: item.name,
                                        textColor: ColorUtils.colorWhite,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (DistrictData? newValue) {
                                    registerProvider.onDistrictChange(
                                        newValue!);
                                  },
                                ),
                              ),
                              verticalSpace(10),
                              Container(
                                height: 55,
                                padding: EdgeInsets.fromLTRB(15, 2, 15, 5),
                                width: screenWidth(context),
                                decoration: BoxDecoration(
                                    border:
                                    Border.all(
                                        color: Colors.white.withOpacity(0.3)),
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black),
                                child: DropdownButton<ConstituencyData>(
                                  iconSize: 30,
                                  isExpanded: true,
                                  iconEnabledColor: ColorUtils.colorWhite,
                                  //menuWidth: screenWidth(context) * 0.8,
                                  elevation: 4,
                                  underline: Container(),
                                  dropdownColor: themeProvider.darkTheme
                                      ? ColorUtils.colorBlack
                                      : ColorUtils.colorBlack,
                                  style: GoogleFonts.playfairDisplay(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        color: ColorUtils.colorWhite),
                                  ),
                                  hint: const CommonKhandText(
                                    title: "MP Constituency*",
                                    textColor: ColorUtils.colorWhite,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                  ),
                                  value: registerProvider.selectConstituency,
                                  items: registerProvider.constituencyData.map((
                                      ConstituencyData item) {
                                    return DropdownMenuItem<ConstituencyData>(
                                      value: item,
                                      child: CommonKhandText(
                                        title: item.name,
                                        textColor: ColorUtils.colorWhite,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (ConstituencyData? newValue) {
                                    registerProvider.onConstituencyChange(
                                        newValue!);
                                  },
                                ),
                              ),
                              verticalSpace(10),

                              Container(
                                height: 55,
                                padding: EdgeInsets.fromLTRB(15, 2, 15, 5),
                                width: screenWidth(context),
                                decoration: BoxDecoration(
                                    border:
                                    Border.all(
                                        color: Colors.white.withOpacity(0.3)),
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black),
                                child: DropdownButton<AssemblyData>(
                                  iconSize: 30,
                                  isExpanded: true,
                                  iconEnabledColor: ColorUtils.colorWhite,
                                  //menuWidth: screenWidth(context) * 0.8,
                                  elevation: 4,
                                  underline: Container(),
                                  dropdownColor: themeProvider.darkTheme
                                      ? ColorUtils.colorBlack
                                      : ColorUtils.colorBlack,
                                  style: GoogleFonts.playfairDisplay(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        color: ColorUtils.colorWhite),
                                  ),
                                  hint: const CommonKhandText(
                                    title: "MLA Assembly*",
                                    textColor: ColorUtils.colorWhite,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                  ),
                                  value: registerProvider.selectedAssembly,
                                  items: registerProvider.assemblyData.map((
                                      AssemblyData item) {
                                    return DropdownMenuItem<AssemblyData>(
                                      value: item,
                                      child: CommonKhandText(
                                        title: item.name,
                                        textColor: ColorUtils.colorWhite,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (AssemblyData? newValue) {
                                    registerProvider.onAssemblyChange(
                                        newValue!);
                                  },
                                ),
                              ),
                              verticalSpace(10),

                              Container(
                                height: 55,
                                padding: EdgeInsets.fromLTRB(15, 2, 15, 5),
                                width: screenWidth(context),
                                decoration: BoxDecoration(
                                    border:
                                    Border.all(
                                        color: Colors.white.withOpacity(0.3)),
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black),
                                child: MyTextField(
                                  maxLines: 1,
                                  showBorders: false,
                                  controller: referralCodeCtr,
                                  hintText: "MLA Referral Code",
                                  keyboardType: TextInputType
                                      .numberWithOptions(),
                                ),
                              ),
                              verticalSpace(10),
                              Container(
                                height: 55,
                                padding: EdgeInsets.fromLTRB(15, 2, 15, 5),
                                width: screenWidth(context),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.3)),
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black),
                                child: MyTextField(
                                  showBorders: false,
                                  controller: relationNameCtr,
                                  maxLines: 1,
                                  hintText: "Enter Relation Name",
                                  keyboardType: TextInputType.name,
                                ),
                              ),
                              verticalSpace(10),
                              Container(
                                height: 55,
                                padding: const EdgeInsets.fromLTRB(
                                    15, 2, 15, 5),
                                width: screenWidth(context),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.3)),
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black),
                                child: MyTextField(
                                  showBorders: false,
                                  maxLines: 1,
                                  controller: addressCtr,
                                  hintText: "Enter Address",
                                  keyboardType: TextInputType.streetAddress,
                                ),
                              ),
                              verticalSpace(10),
                              Container(
                                height: 55,
                                padding: EdgeInsets.fromLTRB(15, 2, 15, 5),
                                width: screenWidth(context),
                                decoration: BoxDecoration(
                                    border:
                                    Border.all(
                                        color: Colors.white.withOpacity(0.3)),
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black),
                                child: MyTextField(
                                  showBorders: false,
                                  maxLines: 1,
                                  controller: boothNoCtr,
                                  hintText: "Enter Booth Number",
                                  keyboardType: TextInputType
                                      .numberWithOptions(),
                                ),
                              ),
                              verticalSpace(20),
                              GestureDetector(
                                onTap: ()=>_validateAndRegister(registerProvider),
                                child: Center(
                                  child: Container(
                                    height: 50,
                                    width: screenWidth(context),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white.withOpacity(0.1)),
                                      borderRadius: BorderRadius.circular(15),
                                      color: const Color(
                                          0xFF0093E9), // Solid background color
                                      gradient: const LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xFF0093E9), // Starting color
                                          Color(0xFF80D0C7), // Ending color
                                        ],
                                        stops: [0.0, 1.0],
                                        transform: GradientRotation(160 *
                                            (3.14159 /
                                                180)), // Rotate by 160 degrees
                                      ),
                                    ),
                                    child: const Center(
                                      child: CommonKhandText(
                                        title: "Done",
                                        textColor: ColorUtils.colorWhite,
                                        fontWeight: FontWeight.w200,
                                        fontSize: 18,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  registerProvider.isLoading ? CustomLoader() : SizedBox
                      .shrink()
                ],
              );
            }
        ),
      ),
    );
  }

  void _showSnackbar(String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        textAlign: TextAlign.center,
        borderRadius: BorderRadius.circular(8),
        message: message,
        textStyle: GoogleFonts.playfairDisplay(
            color: Colors.white, fontSize: 14),
      ),
    );
  }

  Future<void> _validateAndRegister(RegisterProvider rp) async {
    String referralCode = referralCodeCtr.text.trim().toString();
    String relationName = relationNameCtr.text.trim();
    String boothNumber = boothNoCtr.text.trim();
    String address = addressCtr.text.trim();

    if(rp.selectedCountry == null){
      _showSnackbar("Select Country");
      return;
    }
    if(rp.selectedState == null){
      _showSnackbar("Select State");
      return;
    }
    if(rp.selectedDistrict == null){
      _showSnackbar("Select District");
      return;
    }
    if(rp.selectConstituency == null){
      _showSnackbar("Select Constituency");
      return;
    }
     if(rp.selectedAssembly == null){
    _showSnackbar("Select Assembly");
    return;
    }
    // if (relationName.isEmpty) {
    //   _showSnackbar("Relation name cannot be empty.");
    //   return;
    // }

    // Validation for referral code
    // if (referralCode.isNotEmpty && referralCode.length < 5) {
    //   _showSnackbar("Referral code must be at least 5 characters long.");
    //   return;
    // }

    // Validation for relation name

    // Validation for address
    // if (address.isEmpty) {
    //   _showSnackbar("Address cannot be empty.");
    //   return;
    // } else if (address.length < 5) {
    //   _showSnackbar("Address must be at least 5 characters long.");
    //   return;
    // }

    // Validation for booth number
    // if (boothNumber.isEmpty) {
    //   _showSnackbar("Booth number cannot be empty.");
    //   return;
    // } else if (!RegExp(r'^[0-9]+$').hasMatch(boothNumber)) {
    //   _showSnackbar("Booth number must contain only digits.");
    //   return;
    // }




    var  body = {
      "address_line1": "",
      "address_line2": address,
      "booth_number": boothNumber,
      "country_id": "100",
      "date_of_birth": widget.Dob,
      "device_id": "${AppUrl.FCM_TOKEN}",
      "district_id": rp.selectedDistrict!.id.toString(),
      "email": widget.email,
      "facebook_profile_url": "",
      "gender": widget.gender??"",
      "instagram_profile_url": "",
      "mla_assembly_id": rp.selectedAssembly!.id.toString(),
      "mp_constituency_id": rp.selectConstituency!.id.toString(),
      "name": widget.name,
      "refrel_code": referralCode.toString(),
      "rname": relationName,
      "role_id": "3",
      "state_id": rp.selectedState!.id.toString(),
      "twitter_profile_url": "",
      "user_id": widget.userId,
      "youtube_profile_url": ""
    };
    print(body);

    rp.registerUser(context,body);
  }
}
