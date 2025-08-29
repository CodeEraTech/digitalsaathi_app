import 'package:data_table_2/data_table_2.dart';
import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/provider/worker_report_provider.dart';
import 'package:digitalsaathi/ui/more/worker_report/survey_ui/survey_ui.dart';
import 'package:digitalsaathi/ui/more/worker_report/worker_ui/worker_ui.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../constants/components/pro_text.dart';

import '../../../../utils/color_utils.dart';
import '../../../provider/theme_provider.dart';

class WorkerReportScreen extends StatefulWidget {
  const WorkerReportScreen({super.key});

  @override
  State<WorkerReportScreen> createState() => _WorkerReportScreenState();
}

class _WorkerReportScreenState extends State<WorkerReportScreen>with SingleTickerProviderStateMixin {
  TextEditingController searchCtr = TextEditingController();
  late TabController _tabController;



  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    Provider.of<WorkerReportProvider>(context,listen: false).getSurveyReport();
    Provider.of<WorkerReportProvider>(context,listen: false).getVoterReport();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
              color: Colors.black.withOpacity(0.2),
              shape: BoxShape.circle
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Center(  // Center the Icon widget here
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title:  const CommonKhandText(
          title: "Worker Report",
          textColor: Color(0xffffffff),
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),
      ),
      body: Consumer<WorkerReportProvider>(
        builder: (context,reportProvider,_) {
          return Stack(
            children: [
              Container(
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
                height: screenHeight(context),
                width: screenWidth(context),
                child: Column(
                  children: [
                    Container(
                      width: screenWidth(context),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                        gradient:  LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(9, 9, 9, 1)
                                : const Color.fromRGBO(6, 108, 219, 0.8897934173669468),
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(63, 61, 61, 1)
                                : const Color.fromRGBO(236, 245, 239, 1),
                          ],
                          stops: [0.0, 1.0], // Stops to match 0% and 100%
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 45,
                            margin: const EdgeInsets.all(8),
                            child: TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              isScrollable: false, // Make it not scrollable for equal spacing
                              unselectedLabelColor: Colors.white,
                              controller: _tabController,
                              dividerHeight: 0,
                              labelPadding: const EdgeInsets.symmetric(
                                  horizontal: 20), // Add horizontal padding
                              labelStyle: GoogleFonts.playfairDisplay(
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white
                                ),
                              ),
                              indicator: BoxDecoration(
                                // color: ColorUtils.appBarColor,
                                  borderRadius: BorderRadius.circular(7),
                                // gradient: LinearGradient(
                                //   begin: Alignment.topCenter,
                                //   end: Alignment.bottomCenter,
                                //   colors: [
                                //     themeProvider.darkTheme ? Color.fromRGBO(6, 108, 219, 0.8897934173669468):Color.fromRGBO(6, 108, 219, 0.8897934173669468),
                                //     themeProvider.darkTheme ? Color.fromRGBO(216, 222, 218, 1):Color.fromRGBO(216, 222, 218, 1),
                                //   ],
                                //   stops: const [0.0, 1.0], // Stops to match 0% and 100%
                                // ),
                                  image: const DecorationImage(image: AssetImage(AssetUtils.screenBackgroundFive),fit: BoxFit.fill)

                              ),
                              tabs: const [
                                Tab(text: 'Survey'),
                                Tab(text: 'worker'),
                              ],
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.zero,
                            elevation:1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              width: screenWidth(context),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                gradient:  LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    themeProvider.darkTheme
                                        ? const Color.fromRGBO(9, 9, 9, 1)
                                        : const Color.fromRGBO(6, 108, 219, 0.8897934173669468),
                                    themeProvider.darkTheme
                                        ? const Color.fromRGBO(63, 61, 61, 1)
                                        : const Color.fromRGBO(236, 245, 239, 1),
                                  ],
                                  stops: const [0.0, 1.0], // Stops to match 0% and 100%
                                ),                      ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: GestureDetector(
                                            onTap: () => reportProvider.selectDateFrom(context,_tabController.index),
                                            child: Container(
                                              height: 40,
                                              padding:
                                              const EdgeInsets.only(left: 10, right: 10),
                                              decoration: BoxDecoration(
                                                // color: Colors.red,
                                                  border: Border.all(
                                                    width: 0.5,
                                                    color: themeProvider.darkTheme
                                                        ? ColorUtils.colorWhite
                                                        : ColorUtils.colorWhite,
                                                  ),
                                                  borderRadius: BorderRadius.circular(6)),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CommonKhandText(
                                                    title:
                                                    reportProvider.formatDate(reportProvider.selectedDateFromData),
                                                    textColor: themeProvider.darkTheme
                                                        ? ColorUtils.colorWhite
                                                        : ColorUtils.colorWhite,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 15,
                                                  ),
                                                  Icon(
                                                    Icons.calendar_month,
                                                    color: themeProvider.darkTheme
                                                        ? ColorUtils.colorWhite
                                                        : ColorUtils.colorWhite,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )),
                                      horizontalSpace(10),
                                      Expanded(
                                          child: GestureDetector(
                                            onTap: () => reportProvider.selectDateTo(context,_tabController.index),
                                            child: Container(
                                              height: 40,
                                              padding:
                                              const EdgeInsets.only(left: 10, right: 10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 0.5,
                                                    color: themeProvider.darkTheme
                                                        ? ColorUtils.colorWhite
                                                        : ColorUtils.colorWhite,
                                                  ),
                                                  borderRadius: BorderRadius.circular(6)),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CommonKhandText(
                                                    title: reportProvider.formatDate(reportProvider.selectedDateToData),
                                                    textColor: themeProvider.darkTheme
                                                        ? ColorUtils.colorWhite
                                                        : ColorUtils.colorWhite,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 16,
                                                  ),
                                                  Icon(
                                                    Icons.calendar_month,
                                                    color: themeProvider.darkTheme
                                                        ? ColorUtils.colorWhite
                                                        : ColorUtils.colorWhite,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                  verticalSpace(5),
                                  GestureDetector(
                                    onTap: (){
                                      reportProvider.onClear(_tabController.index);
                                    },
                                    child: const CommonKhandText(
                                      title: "Clear",
                                      textColor: Color(0xffffffff),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: [
                            SurveyUi(surveyData: reportProvider.surveyData),
                            WorkerUi(voterReportData: reportProvider.voterDataList,)
                          ]
                      ),
                    )
                  ],
                ),
              ),

              reportProvider.isLoading?CustomLoader():SizedBox.shrink()
            ],
          );
        }
      ),
    );
  }
}
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// height: 40,
// width: 40,
// padding: const EdgeInsets.only(left: 8),
// decoration: BoxDecoration(
// // borderRadius: BorderRadius.circular(8),
// shape: BoxShape.circle,
// color: Colors.black.withOpacity(0.2),
// ),
// child: GestureDetector(
// onTap: () {
// Navigator.pop(context);
// },
// child: const Center(  // Center the Icon widget here
// child: Icon(
// Icons.arrow_back_ios,
// color: Colors.white,
// ),
// ),
// ),
// ),
// horizontalSpace(1),
// const CommonKhandText(
// title: "Events",
// textColor: Color(0xffffffff),
// fontWeight: FontWeight.w300,
// fontSize: 16,
// ),
// const CommonKhandText(
// title: "Create Event",
// textColor: Color(0xffffffff),
// fontWeight: FontWeight.w300,
// fontSize: 15,
// ),
// ],
// ),



// Row(
//   children: [
//     Expanded(
//       child: Container(
//         height: 45,
//         padding: const EdgeInsets.only(left: 15,right: 15),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(6),
//           border: Border.all(color: Colors.white)
//         ),
//         child: const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             CommonKhandText(
//               title: "Select From",
//               textColor: Color(0xffffffff),
//               fontWeight: FontWeight.w300,
//               fontSize: 14,
//             ),
//             Icon(Icons.calendar_month,color: Colors.white,)
//           ],
//         ),
//       ),
//     ),
//     horizontalSpace(10),
//     Expanded(
//       child: Container(
//         height: 45,
//         padding: const EdgeInsets.only(left: 15,right: 15),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(7),
//             border: Border.all(color: Colors.white)
//         ),
//         child: const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             CommonKhandText(
//               title: "Select To",
//               textColor: Color(0xffffffff),
//               fontWeight: FontWeight.w300,
//               fontSize: 14,
//             ),
//             Icon(Icons.calendar_month,color: Colors.white,)
//           ],
//         ),
//       ),
//     )
//   ],
// )