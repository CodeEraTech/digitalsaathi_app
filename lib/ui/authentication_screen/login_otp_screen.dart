import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/provider/login_provider.dart';
import 'package:digitalsaathi/ui/authentication_screen/registration_screen.dart';
import 'package:digitalsaathi/ui/botttom_bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:provider/provider.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../constants/Api_Services/api_services.dart';
import '../../constants/components/pro_text.dart';
import '../../provider/theme_provider.dart';
import '../../utils/app_utils.dart';
import '../../utils/color_utils.dart';
class LoginOtpScreen extends StatefulWidget {
  final userId;
  final mobileNo;
  const LoginOtpScreen({super.key, this.userId, this.mobileNo});

  @override
  State<LoginOtpScreen> createState() => _LoginOtpScreenState();
}

class _LoginOtpScreenState extends State<LoginOtpScreen> {
  final OtpFieldController _otpController = OtpFieldController();
  String _enteredOTP = "";
  String defaultOtp = "1234";
  String manualOtp = "";
  bool isLoading = false;

  final ApiServices apiServices = ApiServices();

  Future<void> verifyOtp(LoginProvider login) async {

      if (_enteredOTP.isEmpty || _enteredOTP.length != 4) {
        _showSnackbar("OTP must be 4 digits long");
        return;
      }

    login.loginUser(context, widget.mobileNo, _enteredOTP);

  }

  void _showSnackbar(String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        textAlign: TextAlign.center,
        borderRadius: BorderRadius.circular(8),
        message: message,
        textStyle:
        GoogleFonts.playfairDisplay(color: Colors.white, fontSize: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.darkTheme
          ? ColorUtils.colorBlack
          : ColorUtils.lightTheme,
      body: Consumer<LoginProvider>(
        builder: (context,loginProvider,_) {
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                height: screenHeight(context),
                width: screenWidth(context),
                decoration: const BoxDecoration(color: Colors.black),
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding:
                    EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.top),
                    // reverse: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        verticalSpace(20),
                        // const Image(image:AssetImage("assets/images/login_image.png"),height: 250,),
                        verticalSpace(20),
                        const CommonKhandText(
                          title: "Mobile Verification",
                          textColor: ColorUtils.colorWhite,
                          fontWeight: FontWeight.w200,
                          fontSize: 30,
                          textAlign: TextAlign.center,
                        ),
                        verticalSpace(20),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                'Please enter the verification code sent to +91 ${widget.mobileNo}',
                                style: GoogleFonts.playfairDisplay(
                                    textStyle: const TextStyle(
                                      fontSize: 17,
                                      // fontWeight: FontWeight.w100,
                                      color: ColorUtils.colorWhite,
                                    )),
                              ),
                              // TextSpan(
                              //   text: '(change)',
                              //   style: GoogleFonts.playfairDisplay(
                              //       textStyle: const TextStyle(
                              //         fontSize: 17,
                              //         fontWeight: FontWeight.w700,
                              //         color: Color(0xFF0093E9),
                              //       )),
                              // ),
                            ],
                          ),
                        ),
                        verticalSpace(20),
                        SizedBox(
                          height: 60,
                          child: OTPTextField(
                              length: 4,
                              fieldWidth: 60,
                              width: screenWidth(context),
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldStyle: FieldStyle.box,
                              controller: _otpController,
                              keyboardType: TextInputType.number,
                              outlineBorderRadius: 10,
                              style: GoogleFonts.montserratAlternates(
                                textStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: ColorUtils.colorWhite,
                                ),
                              ),
                              otpFieldStyle: OtpFieldStyle(
                                borderColor: ColorUtils.colorWhite,
                                focusBorderColor: ColorUtils.primaryColor,
                                enabledBorderColor: ColorUtils.colorWhite,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              onCompleted: (pin) {
                                _enteredOTP = pin;
                                print("Completed: " + pin);
                              },
                              onChanged: (value) {
                                print("Value changed: $value");
                                manualOtp = value; // Capture manual OTP input
                              }),
                        ),
                        verticalSpace(25),

                        GestureDetector(
                          onTap: ()=>verifyOtp(loginProvider),
                          child: Container(
                            height: 55,
                            width: screenWidth(context) * 0.6,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white.withOpacity(0.4)),
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
                                transform: GradientRotation(
                                    160 * (3.14159 / 180)), // Rotate by 160 degrees
                              ),
                            ),
                            child: Center(
                              child: const CommonKhandText(
                                title: "Verify OTP",
                                textColor: ColorUtils.colorWhite,
                                fontWeight: FontWeight.w200,
                                fontSize: 18,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        verticalSpace(20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Didn\'t get the code?  ',
                                  style: GoogleFonts.playfairDisplay(
                                      textStyle: TextStyle(
                                        fontSize: 17,
                                        // fontWeight: FontWeight.w100,
                                        color: ColorUtils.colorWhite,
                                      )),
                                ),
                                TextSpan(
                                  text: 'Resend Code',
                                  style: GoogleFonts.playfairDisplay(
                                      textStyle: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF0093E9),
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
              loginProvider.isLoading?CustomLoader():SizedBox.shrink()
            ],
          );
        }
      ),
    );
  }
}
