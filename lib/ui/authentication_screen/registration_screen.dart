import 'package:digitalsaathi/ui/authentication_screen/registration_done.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../constants/components/my_TextField.dart';
import '../../constants/components/pro_text.dart';
import '../../provider/theme_provider.dart';
import '../../utils/app_utils.dart';
import '../../utils/color_utils.dart';

class RegistrationScreen extends StatefulWidget {
  final String mobile;
  final String userId;
  const RegistrationScreen({super.key,required this.mobile,required this.userId});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController mobileCtr = TextEditingController();
  String _selectedWorkerValue = 'Worker'; // Default selection
  String? genderSelectedValue;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mobileCtr.text=widget.mobile;
  }


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: themeProvider.darkTheme ?  ColorUtils.colorBlack: ColorUtils.lightTheme,
        appBar: AppBar(
          surfaceTintColor: themeProvider.darkTheme ? ColorUtils.colorBlack :  ColorUtils.appBarColor ,
          backgroundColor: themeProvider.darkTheme ? ColorUtils.colorBlack :  ColorUtils.appBarColor ,        centerTitle: true,
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
            title: "Registration",
            textColor: Color(0xffffffff),
            fontWeight: FontWeight.w300,
            fontSize: 20,
          ),
        ),

        body: Container(
          height: screenHeight(context),
          width: screenWidth(context),
          padding: EdgeInsets.only(left: 15,right: 15),
          decoration: const BoxDecoration(
              color: Colors.black
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Image(image: AssetImage("assets/images/registration.png"),height: 200,),
                Row(
                  children: [
                    Radio<String>(
                      activeColor: _selectedWorkerValue == 'Worker' ? Colors.blue : Colors.grey,
                      value: 'Worker',
                      groupValue: _selectedWorkerValue,
                      onChanged: (String? value) {
                        if (value != null) {
                          _toggleSelection(value);
                        }
                      },
                    ),
                    CommonKhandText(
                      title: "Worker",
                      textColor: Colors.white,
                      // fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                  ],
                ),
                Container(
                  height: 55,
                  padding: EdgeInsets.fromLTRB(15, 2,15, 5),
                  width: screenWidth(context),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black
                  ),
                  child: MyTextField(
                    showBorders: false,
                    controller: nameCtr,
                    hintText: "Name",
                    keyboardType: TextInputType.name,
                  ),
                ),
                verticalSpace(10),
                Container(
                  height: 55,
                  padding: EdgeInsets.fromLTRB(15, 2,15, 5),
                  width: screenWidth(context),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(15),
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
                            readOnly: true,
                            showBorders: false,
                            maxLines: 1,
                            controller: mobileCtr,
                            hintText: "Enter Phone Number",
                            keyboardType: TextInputType.number,
                            // validation: _validateHouseNo,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpace(10),
                Container(
                  height: 55,
                  padding: EdgeInsets.fromLTRB(15, 2,15, 5),
                  width: screenWidth(context),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black
                  ),
                  child: MyTextField(
                    maxLines: 1,
                    showBorders: false,
                    controller: emailCtr,
                    hintText: "Email ID (not mendatory)",
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                verticalSpace(10),
                GestureDetector(
                  onTap: ()=>_selectDate(context),
                  child: Container(
                    height: 55,
                    padding: EdgeInsets.fromLTRB(15, 2,15, 5),
                    width: screenWidth(context),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black
                    ),
                    child:Row(
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
                ),
                verticalSpace(10),
                Container(
                  height: 55,
                  padding: EdgeInsets.fromLTRB(15, 2,15, 5),
                  width: screenWidth(context),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black
                  ),
                  child:DropdownButton<String>(
                    iconSize: 30,
                    isExpanded: true,
                    iconEnabledColor: ColorUtils.colorWhite,
                   /// menuWidth: screenWidth(context) * 0.8,
                    elevation: 4,
                    underline: Container(),
                    dropdownColor: themeProvider.darkTheme
                        ? ColorUtils.colorBlack
                        : ColorUtils.colorBlack,
                    style: GoogleFonts.playfairDisplay(
                      textStyle: const TextStyle(fontSize: 14, color: ColorUtils.colorWhite),
                    ),
                    hint: const CommonKhandText(
                      title: "Select Gender*",
                      textColor: ColorUtils.colorWhite,
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                    value: genderSelectedValue,
                    items: genderItems.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: CommonKhandText(
                          title: item,
                          textColor: ColorUtils.colorWhite,
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        genderSelectedValue = newValue;
                      });
                    },
                  ),
                ),
                verticalSpace(10),

                GestureDetector(
                  onTap:_validateAndRegister,
                  child: Center(
                    child: Container(
                      height: 50,
                      width: screenWidth(context),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(15),
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
                          title: "NEXT",
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
    );
  }
  List<String> genderItems = [
    'Male',
    "Female",
    "Other"
  ];

  void _validateAndRegister() {
    String name = nameCtr.text.trim();
    String mobileNumber = mobileCtr.text.trim();
    String email = emailCtr.text.trim();


    // Validation for name
    if (name.isEmpty) {
      _showSnackbar("Name cannot be empty.");
      return;
    } else if (name.length < 2) {
      _showSnackbar("Name must be at least 2 characters long.");
      return;
    }

    // Validation for mobile number
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
    // else if (!['7', '8', '9'].contains(mobileNumber[0])) {
    //   _showSnackbar("Mobile number must start with 7, 8, or 9.");
    //   return;
    // }

    // Validation for email
    // if (email.isEmpty) {
    //   _showSnackbar("Email cannot be empty.");
    //   return;
    // } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
    //   _showSnackbar("Please enter a valid email address.");
    //   return;
    // }

    //Validation dob
    if(selectedDate == null){
      _showSnackbar("Please select DOB.");
      return;
    }

    if(genderSelectedValue == null){
      _showSnackbar("Please select gender.");
      return;
    }

    // Navigate to the next screen if validation passes
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
           RegistrationDone(
             name : nameCtr.text.trim(),
             mobile:mobileCtr.text.trim(),
             email : emailCtr.text.trim(),
             Dob : formatSelectedDate(selectedDate),
             gender : genderSelectedValue,
             userId: widget.userId,
          )
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
            color: Colors.white,
            fontSize: 14
        ),
      ),
    );
  }

  void _toggleSelection(String value) {
    setState(() {
      _selectedWorkerValue = value;
    });
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

