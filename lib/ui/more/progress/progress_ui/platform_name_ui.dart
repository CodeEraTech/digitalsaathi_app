import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../constants/components/pro_text.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/asset_utils.dart';
import '../../../../provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../../utils/color_utils.dart';
class PlatformNameUi extends StatefulWidget {
  final String? platformName;
  final Widget? searchField;
  const PlatformNameUi({super.key,this.platformName, this.searchField, });

  @override
  State<PlatformNameUi> createState() => _PlatformNameUiState();
}

class _PlatformNameUiState extends State<PlatformNameUi> {
  DateTime? selectedDateFromData;
  DateTime? selectedDateToData;
  Future<void> _selectDateFrom(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateFromData ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        final themeProvider = Provider.of<DarkThemeProvider>(context);
        return Theme(
          data: ThemeData.light().copyWith(
            datePickerTheme: DatePickerThemeData(
              headerHelpStyle: GoogleFonts.playfairDisplay(
                  fontSize:17,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
              ),
              headerHeadlineStyle: GoogleFonts.playfairDisplay(
                fontSize: 35,
                fontWeight: FontWeight.w400,
              ),
              headerBackgroundColor: ColorUtils.appBarColor,
              // backgroundColor: Colors.red,
              dayStyle: GoogleFonts.playfairDisplay(fontSize: 17),
              weekdayStyle:GoogleFonts.playfairDisplay(fontSize: 17) ,
              yearStyle:GoogleFonts.playfairDisplay(fontSize: 17) ,
              cancelButtonStyle: ButtonStyle(
                  textStyle:WidgetStatePropertyAll(
                      GoogleFonts.playfairDisplay(
                        fontSize: 18, // Adjust font size
                        fontWeight: FontWeight.w400,
                      )
                  )
              ),
              confirmButtonStyle: ButtonStyle(
                textStyle: WidgetStateProperty.all(
                  GoogleFonts.playfairDisplay(
                    fontSize: 18, // Adjust font size
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
            ),
            primaryColor: Colors.blue,
            hintColor: Colors.blue,
            colorScheme: ColorScheme.light(primary: Colors.blue),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDateFromData) {
      setState(() {
        selectedDateFromData = picked;
      });
    }
  }
  Future<void> _selectDateTo(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateToData ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        final themeProvider = Provider.of<DarkThemeProvider>(context);
        return Theme(
          data: ThemeData.light().copyWith(
            datePickerTheme: DatePickerThemeData(
              headerHelpStyle: GoogleFonts.playfairDisplay(
                  fontSize:17,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
              ),
              headerHeadlineStyle: GoogleFonts.playfairDisplay(
                fontSize: 35,
                fontWeight: FontWeight.w400,
              ),
              headerBackgroundColor: ColorUtils.appBarColor,
              // backgroundColor: Colors.red,
              dayStyle: GoogleFonts.playfairDisplay(fontSize: 17),
              weekdayStyle:GoogleFonts.playfairDisplay(fontSize: 17) ,
              yearStyle:GoogleFonts.playfairDisplay(fontSize: 17) ,
              cancelButtonStyle: ButtonStyle(
                  textStyle:WidgetStatePropertyAll(
                      GoogleFonts.playfairDisplay(
                        fontSize: 18, // Adjust font size
                        fontWeight: FontWeight.w400,
                      )
                  )
              ),
              confirmButtonStyle: ButtonStyle(
                textStyle: WidgetStateProperty.all(
                  GoogleFonts.playfairDisplay(
                    fontSize: 18, // Adjust font size
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
            ),
            primaryColor: Colors.blue,
            hintColor: Colors.blue,
            colorScheme: const ColorScheme.light(primary: Colors.blue),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDateToData) {
      setState(() {
        selectedDateToData = picked;
      });
    }
  }
  String _formatDateFrom(DateTime? date) {
    if (date == null) return 'Select From';
    return DateFormat('dd/MM/yyyy').format(date); // Format date to dd/mm/yyyy
  }

  String _formatDateTo(DateTime? date) {
    if (date == null) return 'Select To';
    return DateFormat('dd/MM/yyyy').format(date); // Format date to dd/mm/yyyy
  }
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return Container(
      width: screenWidth(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        gradient:  LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            themeProvider.darkTheme ? Color(0xff181818): Color.fromRGBO(13, 125, 246, 1) ,
            themeProvider.darkTheme ?Color.fromRGBO(63, 61, 61, 1): Color.fromRGBO(222, 230, 225, 1),
          ],
          stops: [0.0, 1.0], // Stops to match 0% and 100%
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonKhandText(
              title: "${widget.platformName}",
              textColor:themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorWhite,
              fontWeight: FontWeight.w300,
              fontSize: 16,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            width: screenWidth(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              gradient:  LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  themeProvider.darkTheme
                      ? const Color.fromRGBO(9, 9, 9, 1)
                      : const Color.fromRGBO(6, 108, 219, 0.8897934173669468),
                  themeProvider.darkTheme
                      ? const Color.fromRGBO(63, 61, 61, 1)
                      : const Color.fromRGBO(216, 222, 218, 1),
                ],
                stops: const [0.0, 1.0], // Stops to match 0% and 100%
              ),
              // image: const DecorationImage(image: AssetImage(AssetUtils.bgMlaFollow),fit:BoxFit.fill)
            ),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: GestureDetector(
                          onTap: ()=>_selectDateFrom(context),
                          child: Container(
                            height: 40,
                            padding:
                            const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              // color: Colors.red,
                                border: Border.all(
                                  width: 0.5,
                                  color:themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorWhite,
                                ),
                                borderRadius: BorderRadius.circular(6)),
                            child:  Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                CommonKhandText(
                                  title: _formatDateFrom(selectedDateFromData),
                                  textColor:themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorWhite,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                                Icon(
                                  Icons.calendar_month,
                                  color:themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorWhite,
                                )
                              ],
                            ),
                          ),
                        )),
                    horizontalSpace(10),
                    Expanded(
                        child: GestureDetector(
                          onTap: ()=>_selectDateTo(context),
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              // color: Colors.red,
                                border: Border.all(
                                  width: 0.5,
                                  color:themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorWhite,
                                ),
                                borderRadius: BorderRadius.circular(6)),
                            child:  Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                CommonKhandText(
                                  title: _formatDateTo(selectedDateToData),
                                  textColor:themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorWhite,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                                Icon(
                                  Icons.calendar_month,
                                  color:themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorWhite,
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                verticalSpace(5),
                if (widget.searchField != null) widget.searchField!,
                verticalSpace(5),
                GestureDetector(
                  onTap: () {},
                  child:  CommonKhandText(
                    title: "Clear",
                    textColor:themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorWhite,
                    fontWeight: FontWeight.w300,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
