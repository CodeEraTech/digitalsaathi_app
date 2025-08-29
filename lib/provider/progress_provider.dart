import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/data/app_excaptions.dart';
import 'package:digitalsaathi/data/model/common_response.dart';
import 'package:digitalsaathi/data/model/meeting_detail_response.dart';
import 'package:digitalsaathi/data/model/meeting_list_response.dart';
import 'package:digitalsaathi/data/model/meeting_report_response.dart';
import 'package:digitalsaathi/data/model/task_data_response.dart';
import 'package:digitalsaathi/data/model/user_progress_model.dart';
import 'package:digitalsaathi/model/feedmodel.dart';
import 'package:digitalsaathi/provider/theme_provider.dart';
import 'package:digitalsaathi/ui/botttom_bar/bottom_nav_bar.dart';
import 'package:digitalsaathi/ui/home/widgets/ReelModel.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:digitalsaathi/utils/connection_util.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProgressProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  initInitialValue(){
    selectedDateFromData = null;
    selectedDateToData = null;
  }

  onClearFilter(){
    initInitialValue();
    notifyListeners();
  }

  List<String> _socialFilter = [
    "ALL",
    "TWITTERTREND",
    "WHATSAPP",
    "FACEBOOK",
    "TWITTER",
    "INSTAGRAM",
    "YOUTUBE",
    "POSTER",
    "OTHER",
  ];

  List<String> get socialFilter => _socialFilter;


  DateTime? selectedDateFromData;
  DateTime? selectedDateToData;
  Future<void> selectDateFrom(BuildContext context,String platform,bool isAll) async {
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
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              headerHeadlineStyle: GoogleFonts.playfairDisplay(
                fontSize: 35,
                fontWeight: FontWeight.w400,
              ),
              headerBackgroundColor: ColorUtils.appBarColor,
              // backgroundColor: Colors.red,
              dayStyle: GoogleFonts.playfairDisplay(fontSize: 17),
              weekdayStyle: GoogleFonts.playfairDisplay(fontSize: 17),
              yearStyle: GoogleFonts.playfairDisplay(fontSize: 17),
              cancelButtonStyle: ButtonStyle(
                  textStyle: WidgetStatePropertyAll(GoogleFonts.playfairDisplay(
                    fontSize: 18, // Adjust font size
                    fontWeight: FontWeight.w400,
                  ))),
              confirmButtonStyle: ButtonStyle(
                textStyle: WidgetStateProperty.all(
                  GoogleFonts.playfairDisplay(
                    fontSize: 18, // Adjust font size
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
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
    if (picked != null) {

        selectedDateFromData = picked;
        if(selectedDateToData != null){
          getUserPerformance("${formatDate(selectedDateFromData)} to ${formatDate(selectedDateToData)}", platform, isAll,needUpdate: true);
        }else{
          getUserPerformance("${formatDate(selectedDateFromData)}", platform, isAll,needUpdate: true);
        }
      notifyListeners();
    }
  }

  Future<void> selectDateTo(BuildContext context,String platform,bool isAll) async {
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
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              headerHeadlineStyle: GoogleFonts.playfairDisplay(
                fontSize: 35,
                fontWeight: FontWeight.w400,
              ),
              headerBackgroundColor: ColorUtils.appBarColor,
              // backgroundColor: Colors.red,
              dayStyle: GoogleFonts.playfairDisplay(fontSize: 17),
              weekdayStyle: GoogleFonts.playfairDisplay(fontSize: 17),
              yearStyle: GoogleFonts.playfairDisplay(fontSize: 17),
              cancelButtonStyle: ButtonStyle(
                  textStyle: WidgetStatePropertyAll(GoogleFonts.playfairDisplay(
                    fontSize: 18, // Adjust font size
                    fontWeight: FontWeight.w400,
                  ))),
              confirmButtonStyle: ButtonStyle(
                textStyle: WidgetStateProperty.all(
                  GoogleFonts.playfairDisplay(
                    fontSize: 18, // Adjust font size
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
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
    if (picked != null) {
        selectedDateToData = picked;
        if(selectedDateFromData != null){
          getUserPerformance("${formatDate(selectedDateFromData)} to ${formatDate(selectedDateToData)}", platform, isAll,needUpdate: true);
        }else{
          getUserPerformance("${formatDate(selectedDateToData)}", platform, isAll,needUpdate: true);
        }
        notifyListeners();
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'Select date';
    return DateFormat('yyyy-MM-dd').format(date); // Format date to dd/mm/yyyy
  }




  List<UserProgressData> _userProgressData = [];

  List<UserProgressData> get userProgressData => _userProgressData;

  Future getUserPerformance(
      String date,String platform,bool isAll,{bool needUpdate = false,String nameSearch = ""}) async {
    _isLoading = true;
    if(needUpdate)
    notifyListeners();
    // try {

    var body = {
      "api_token": AppUrl.apiToken,
      "date":date,
      "hierarchy_status": "true",
      "limit": "10000",
      "name": nameSearch,
      "page": "1",
      "search": "",
      "social_filter": platform == "ALL"?"":platform,
      "tab":isAll?"all":""
    };

    http.Response response =
        await http.post(Uri.parse(AppUrl.getUserPerformance), body: body);

    Utils.printConsoleData(AppUrl.getUserPerformance);
    Utils.printConsoleData(body.toString());
    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status_code'] == 200) {
        UserProgressResponse userProgressResponse =
        UserProgressResponse.fromJson(jsonDecode(response.body));
        _userProgressData = userProgressResponse.data;
        _isLoading = false;
        notifyListeners();
      } else if (jsonDecode(response.body)['status_code'] == 400) {
        _isLoading = false;
        notifyListeners();
      } else {
        EasyLoading.showError(
            "${jsonDecode(response.body)['status_code']} - ${jsonDecode(response.body)['status_text']}");
        _isLoading = false;
        notifyListeners();
      }
    } else {
      EasyLoading.showError("${response.statusCode}");
      _isLoading = false;
      notifyListeners();
    }

    log(response.body);
    // } on SocketException {
    //   _isLoading = false;
    //   notifyListeners();
    //   throw FetchDataException('No Internet Connection');
    // } catch (e) {
    //   EasyLoading.showError("Something went wrong. Please try again!!!");
    //   _isLoading = false;
    //   notifyListeners();
    // }
  }
}
