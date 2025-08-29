import 'package:data_table_2/data_table_2.dart';
import 'package:digitalsaathi/data/model/survey_report_su.dart';
import 'package:digitalsaathi/data/model/survey_response.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../constants/components/pro_text.dart';
import '../../../../provider/theme_provider.dart';

class SurveyUi extends StatefulWidget {
  final List<SurveyReportResponseCustom> surveyData;
  const SurveyUi({super.key,required this.surveyData});

  @override
  State<SurveyUi> createState() => _SurveyUiState();
}

class _SurveyUiState extends State<SurveyUi> {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: ColorUtils.lightTheme,
                borderRadius:BorderRadius.circular(10)
              ),
              child: DataTable2(
                columnSpacing: 10,
                horizontalMargin: 3,
                dataRowHeight: 55,
                dividerThickness:0,
                checkboxAlignment: Alignment.center,
                border:  TableBorder(
                    borderRadius: BorderRadius.circular(10),
                    horizontalInside: const BorderSide(color: Colors.white )
                ),
                headingRowDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      themeProvider.darkTheme
                          ? const Color.fromRGBO(9, 9, 9, 1)
                          : const Color.fromRGBO(6, 108, 219, 0.8897934173669468),
                      themeProvider.darkTheme
                          ? const Color.fromRGBO(63, 61, 61, 1)
                          : const Color.fromRGBO(236, 245, 239, 1),

                    //   Color.fromRGBO(6, 108, 219, 0.8897934173669468), // rgba(6,108,219,0.889793)
                      //               Color.fromRGBO(236, 245, 239, 1), // rgba(236,245,239,1)
                    ],
                    stops: const [0.0, 1.0], // Stops to match 0% and 100%
                  ),
                ),
                minWidth: screenWidth(context)*1.13,
                dataTextStyle: GoogleFonts.playfairDisplay(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 13
                    )
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                columns:  const [
                  DataColumn(label: Center(
                    child: CommonKhandText(
                      title: "Worker Name",
                      textColor:  ColorUtils.colorWhite,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),),
                  DataColumn(label: Center(
                    child: CommonKhandText(
                      title: "Survey Name",
                      textColor:  ColorUtils.colorWhite,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  )),
                  DataColumn(label: Center(
                    child: CommonKhandText(
                      title: "Today",
                      textColor:  ColorUtils.colorWhite,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  )),
                  DataColumn(label: Center(
                    child: CommonKhandText(
                      title: "Total",
                      textColor:  ColorUtils.colorWhite,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  )),
                ],
                rows: List<DataRow>.generate(widget.surveyData.length, (index) {
                  final item = widget.surveyData[index];
                  Color rowColor;
                  // Assign colors based on index
                  switch (index % 2) {
                    case 0:
                      rowColor = themeProvider.darkTheme ? Color(0xff05998c).withOpacity(0.8) : Color(0xff05998c).withOpacity(0.7);
                      break;
                    case 1:
                      rowColor = themeProvider.darkTheme ? Color(0xffec9006).withOpacity(0.7) : Color(0xffFCAE1E).withOpacity(0.7);
                      break;
                    default:
                      rowColor = Colors.white;
                  }
                  return DataRow(
                    color: MaterialStateProperty.all(rowColor),
                    cells: [
                      DataCell(Center(child: Text(item.firstName.toString()+" "+item.lastName.toString())),),
                      DataCell(Center(child: Text(item.surveyName.toString()))),
                      DataCell(Center(child: Text(item.todayVoters.toString()))), // Converting to string for display
                      DataCell(Center(child: Text(item.totalVoters.toString()))),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        )
      ],
    );
  }
}
