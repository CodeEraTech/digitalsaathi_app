import 'dart:developer';

import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/ui/authentication_screen/SignUp_Otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:digitalsaathi/ui/authentication_screen/login_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../constants/Api_Services/api_services.dart';
import '../../constants/components/my_TextField.dart';
import '../../constants/components/pro_text.dart';
import '../../provider/theme_provider.dart';
import '../../utils/app_utils.dart';
import '../../utils/color_utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  ApiServices apiServices = ApiServices();
  TextEditingController mobileCtr = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  bool isLoading = false;
  Future<void> _validateAndSignUp() async {
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

    // Call the signup API

    try {
      setState(() {
        isLoading = true;
      });
      final apiService = ApiServices();
      final response = await apiService.signupUser(mobileNumber);
     //
      log("$response");
      // Check the response and navigate if successful
      if (response['status_code'] == 200) {
        var userId = response["userdata"]['user_id'];
        setState(() {
          isLoading = false;
        });// Adjust this based on your API response structure
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpOtpScreen(
            userId : userId,
            mobileNo : mobileNumber
          )),
        );
      } else {
        setState(() {
          isLoading = false;
        });
        _showSnackbar("Signup failed: ${response['message']??"User already exists!!"}");
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
      child: Scaffold(
        backgroundColor: themeProvider.darkTheme ? ColorUtils.colorBlack : ColorUtils.lightTheme,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: screenHeight(context),
              width: screenWidth(context),
              decoration: const BoxDecoration(color: Colors.black),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(image: AssetImage("assets/images/logo.png"), height: 250),
                      verticalSpace(20),
                      const CommonKhandText(
                        title: "Sign Up",
                        textColor: ColorUtils.colorWhite,
                        fontWeight: FontWeight.w300,
                        fontSize: 40,
                      ),
                      verticalSpace(20),
                      Container(
                        height: 55,
                        padding: EdgeInsets.fromLTRB(15, 2, 15, 5),
                        width: screenWidth(context),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black,
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
                                width: screenWidth(context) * 0.65,
                                child: MyTextField(
                                  showBorders: false,
                                  controller: mobileCtr,
                                  hintText: "Enter Phone Number",
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      verticalSpace(20),
                      GestureDetector(
                        onTap: _validateAndSignUp,
                        child: Container(
                          height: 50,
                          width: screenWidth(context),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black.withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xFF0093E9),
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xFF0093E9),
                                Color(0xFF80D0C7),
                              ],
                              stops: [0.0, 1.0],
                              transform: GradientRotation(160 * (3.14159 / 180)),
                            ),
                          ),
                          child: Center(
                            child: const CommonKhandText(
                              title: "Sign Up",
                              textColor: ColorUtils.colorWhite,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      verticalSpace(20),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'By signing up you agree to the  ',
                              style: GoogleFonts.playfairDisplay(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  color: ColorUtils.colorWhite.withOpacity(0.8),
                                ),
                              ),
                            ),
                            TextSpan(
                              text: '\nTerm and Conditions ',
                              style: GoogleFonts.playfairDisplay(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF0093E9),
                                ),
                              ),
                            ),
                            TextSpan(
                              text: 'and ',
                              style: GoogleFonts.playfairDisplay(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  color: ColorUtils.colorWhite.withOpacity(0.8),
                                ),
                              ),
                            ),
                            TextSpan(
                              text: 'privacy and Policy ',
                              style: GoogleFonts.playfairDisplay(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF0093E9),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(150),
                      GestureDetector(
                        onTap: () {
                          // apiServices.getRoleList();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Are you an existing user? ',
                                style: GoogleFonts.playfairDisplay(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    color: ColorUtils.colorWhite.withOpacity(0.8),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: 'Login ',
                                style: GoogleFonts.playfairDisplay(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF0093E9),
                                  ),
                                ),
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
            isLoading?CustomLoader():SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
