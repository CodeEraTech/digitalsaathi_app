import 'dart:developer';

import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/ui/authentication_screen/login_otp_screen.dart';
import 'package:digitalsaathi/ui/authentication_screen/signup_screen.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../constants/Api_Services/api_services.dart';
import '../../constants/components/my_TextField.dart';
import '../../constants/components/pro_text.dart';
import '../../provider/theme_provider.dart';
import '../../utils/app_utils.dart';
import '../../utils/color_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileCtr = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  bool isLoading = false;

  void _validateAndLogin() async {
    String mobileNumber = mobileCtr.text.trim();

    // Validation
    if (mobileNumber.isEmpty) {
      _showSnackbar("Mobile number cannot be empty.");
      return;
    } else if (mobileNumber.length != 10) {
      _showSnackbar("Please enter a valid 10-digit mobile number.");
      return;
    } else if (!RegExp(r'^[0-9]+$').hasMatch(mobileNumber)) {
      _showSnackbar("Mobile number must contain only digits.");
      return;
    }
    // Call the login API
    try {
      setState(() {
        isLoading = true;
      });
      final apiService = ApiServices();
      final response = await apiService.loginUser(mobileNumber);
      var userId = response["user_id"];

      // log(response['body']);
      if (response['status_code'] == 200) {
        setState(() {
          isLoading = false;
        });// Adjust based on your API response structure
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>LoginOtpScreen(
            userId: userId,
            mobileNo: mobileNumber,
          )),
        );
      } else {
        setState(() {
          isLoading = false;
        });
        _showSnackbar("Login failed: ${response['message']}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showSnackbar("An error occurred: $e");
    }
  }

  void _showSnackbar(String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        textAlign: TextAlign.center,
        borderRadius: BorderRadius.circular(8),
        message: message,
        textStyle: GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontSize: 14
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: themeProvider.darkTheme ?  ColorUtils.colorBlack: ColorUtils.lightTheme,

            body: Container(
              padding: const EdgeInsets.only(left: 20,right: 20),
              height: screenHeight(context),
              width: screenWidth(context),
              decoration: const BoxDecoration(
                  color: Colors.black
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.top),
                  // reverse: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      verticalSpace(20),
                       Image(image: AssetImage(AssetUtils.logoPng),height: 250,),
                      verticalSpace(20),
                      const CommonKhandText(
                        title: "Login",
                        textColor: ColorUtils.colorWhite,
                        fontWeight: FontWeight.w300,
                        fontSize: 40,
                      ),
                      verticalSpace(20),
                      Container(
                        height: 55,
                        padding: EdgeInsets.fromLTRB(15, 2,15, 5),
                        width: screenWidth(context),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.black
                        ),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CommonKhandText(
                                title: "+91",
                                textColor: ColorUtils.colorWhite,
                                fontSize: 14,
                                textAlign: TextAlign.center,
                              ),
                              horizontalSpace(10),
                              SizedBox(
                                width: screenWidth(context)*0.65,
                                child: MyTextField(
                                  showBorders: false,
                                  controller: mobileCtr,
                                  hintText: "Enter Phone Number",
                                  keyboardType: TextInputType.number,
                                  inputFormatter: [
                                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                    LengthLimitingTextInputFormatter(10)
                                  ],
                                 // maxLength: 10,
                                  // validation: _validateHouseNo,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      verticalSpace(10),
                      CommonKhandText(
                        title: "OTP will be sent on this number for\n authentication",
                        textColor: ColorUtils.colorWhite.withOpacity(0.8),
                        fontSize: 14,
                        textAlign: TextAlign.center,
                      ),
                      verticalSpace(20),
                      GestureDetector(
                        onTap:_validateAndLogin,
                        child: Container(
                          height: 50,
                          width: screenWidth(context)*0.6,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black.withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(25),
                            color: const Color(0xFF0093E9), // Solid background color
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xFF0093E9), // Starting color
                                Color(0xFF80D0C7), // Ending color
                              ],
                              stops: [0.0, 1.0],
                              transform: GradientRotation(160 * (3.14159 / 180)), // Rotate by 160 degrees
                            ),
                          ),
                          child: const Center(
                            child: CommonKhandText(
                              title: "Get OTP",
                              textColor: ColorUtils.colorWhite,
                              fontWeight: FontWeight.w200,
                              fontSize: 18,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      verticalSpace(10),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Dont\'t have an account yet? ',
                                style: GoogleFonts.playfairDisplay(
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      color: ColorUtils.colorWhite.withOpacity(0.8),
                                    )),
                              ),
                              TextSpan(
                                text: 'Signup',
                                style: GoogleFonts.playfairDisplay(
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color:Color(0xFF0093E9),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          isLoading?CustomLoader():SizedBox.shrink()
        ],
      ),
    );
  }
}
