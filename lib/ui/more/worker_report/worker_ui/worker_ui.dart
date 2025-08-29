import 'package:data_table_2/data_table_2.dart';
import 'package:digitalsaathi/data/model/voter_report_response.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../constants/components/pro_text.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utils/color_utils.dart';

class WorkerUi extends StatefulWidget {
  final List<VoterReportData> voterReportData;
  const WorkerUi({super.key,required this.voterReportData});

  @override
  State<WorkerUi> createState() => _WorkerUiState();
}

class _WorkerUiState extends State<WorkerUi> {

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
                borderRadius: BorderRadius.circular(10)
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
                headingRowDecoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  image: const DecorationImage(image:AssetImage(AssetUtils.bgMlaFollow),fit: BoxFit.fill),
                ),
                minWidth: screenWidth(context)*0.8,
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
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),),
                  DataColumn(label: Center(
                    child: CommonKhandText(
                      title: "Today Vote",
                      textColor:  ColorUtils.colorWhite,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  )),
                  DataColumn(label: Center(
                    child: CommonKhandText(
                      title: "Total Vote",
                      textColor:  ColorUtils.colorWhite,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  )),
                ],
                rows: List<DataRow>.generate(widget.voterReportData.length, (index) {
                  final item = widget.voterReportData[index];
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
                      DataCell(Center(child: Text(item.name.toString())),),
                      DataCell(Center(child: Text(item.todayAssignVote.toString()))),
                      DataCell(Center(child: Text(item.totalAssignVote.toString()))), // Converting to string for display
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
