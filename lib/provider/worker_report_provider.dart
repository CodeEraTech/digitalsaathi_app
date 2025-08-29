import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/data/app_excaptions.dart';
import 'package:digitalsaathi/data/model/common_response.dart';
import 'package:digitalsaathi/data/model/meeting_detail_response.dart';
import 'package:digitalsaathi/data/model/meeting_list_response.dart';
import 'package:digitalsaathi/data/model/meeting_report_response.dart';
import 'package:digitalsaathi/data/model/survey_report_su.dart';
import 'package:digitalsaathi/data/model/survey_response.dart';
import 'package:digitalsaathi/data/model/task_data_response.dart';
import 'package:digitalsaathi/data/model/user_progress_model.dart';
import 'package:digitalsaathi/data/model/voter_report_response.dart';
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

class WorkerReportProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;







  DateTime? selectedDateFromData;
  DateTime? selectedDateToData;
  Future<void> selectDateFrom(BuildContext context,int index) async {
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
        if(index  == 0){
          getSurveyReport(needUpdate: true);
        }else{
          getVoterReport(needUpdate: true);
        }
        // if(selectedDateToData != null){
        //   getUserPerformance("${formatDate(selectedDateFromData)} to ${formatDate(selectedDateToData)}", platform, isAll,needUpdate: true);
        // }else{
        //   getUserPerformance("${formatDate(selectedDateFromData)}", platform, isAll,needUpdate: true);
        // }
      notifyListeners();
    }
  }

  Future<void> selectDateTo(BuildContext context,int index) async {
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
        if(index  == 0){
          getSurveyReport(needUpdate: true);
        }else{
          getVoterReport(needUpdate: true);
        }
        // if(selectedDateFromData != null){
        //   getUserPerformance("${formatDate(selectedDateFromData)} to ${formatDate(selectedDateToData)}", platform, isAll,needUpdate: true);
        // }else{
        //   getUserPerformance("${formatDate(selectedDateToData)}", platform, isAll,needUpdate: true);
        // }
        notifyListeners();
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'Select date';
    return DateFormat('yyyy-MM-dd').format(date); // Format date to dd/mm/yyyy
  }

  onClear(int index){
    selectedDateToData = null;
    selectedDateFromData = null;
    if(index  == 0){
      getSurveyReport(needUpdate: true);
    }else{
      getVoterReport(needUpdate: true);
    }
  }




  List<SurveyReportResponseCustom> _surveyData = [];

  List<SurveyReportResponseCustom> get surveyData => _surveyData;

  Future getSurveyReport({bool needUpdate = false,String nameSearch = ""}) async
  {
    _isLoading = true;
    if(needUpdate)
    notifyListeners();
    // try {

    var body = {
      "api_token":
          AppUrl.apiToken,
      "limit": "10000",
      "page": "1",
      "from_date": selectedDateFromData==null?"":"${formatDate(selectedDateFromData)}",
      "to_date": selectedDateToData==null?"":"${formatDate(selectedDateToData)}",
    };

    http.Response response =
        await http.post(Uri.parse(AppUrl.getSurveyReport), body: body);

    Utils.printConsoleData(AppUrl.getSurveyReport);
    Utils.printConsoleData(body.toString());
    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status_code'] == 200) {
        SurveyResponse surveyResponse =
        SurveyResponse.fromJson(jsonDecode(response.body));
        _surveyData.clear();
        for(int i=0;i<surveyResponse.data.length;i++){

          for(int j=0;j<surveyResponse.data[i].worker.length;j++){
            //  sur = SurveyReportResponseCustom.Worker
            SurveyReportResponseCustom sur =  SurveyReportResponseCustom();

            sur.surveyName = surveyResponse.data[i].surveyName.toString();
            sur.firstName = surveyResponse.data[i].worker[j].firstName.toString();
            sur.lastName = surveyResponse.data[i].worker[j].lastName.toString();
            sur.totalVoters = surveyResponse.data[i].worker[j].totalVoters;
            sur.todayVoters = surveyResponse.data[i].worker[j].todayVoters;

            _surveyData.add(sur);
          }
        }
      //  _surveyData = surveyResponse.data;
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


  List<VoterReportData> _voterDataList =  [];

  List<VoterReportData> get voterDataList => _voterDataList;

  Future getVoterReport({bool needUpdate = false,String nameSearch = ""}) async
  {
    _isLoading = true;
    if(needUpdate)
    notifyListeners();
    // try {

    var body = {
      "api_token":
          AppUrl.apiToken,
      "limit": "10000",
      "page": "1",
      "from_date": selectedDateFromData==null?"":"${formatDate(selectedDateFromData)}",
      "to_date": selectedDateToData==null?"":"${formatDate(selectedDateToData)}",
    };

    http.Response response =
        await http.post(Uri.parse(AppUrl.getVoterReport), body: body);

    Utils.printConsoleData(AppUrl.getVoterReport);
    Utils.printConsoleData(body.toString());
    Utils.printConsoleData(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status_code'] == 200) {
        VoterReportModel voterReportModel =
        VoterReportModel.fromJson(jsonDecode(response.body));
        _voterDataList = voterReportModel.data;
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
