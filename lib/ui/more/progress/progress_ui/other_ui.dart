import 'package:digitalsaathi/ui/more/progress/progress_ui/platform_name_ui.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import '../../../../constants/components/pro_text.dart';
import '../../../../provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../../utils/color_utils.dart';
class OtherUi extends StatefulWidget {
  const OtherUi({super.key});

  @override
  State<OtherUi> createState() => _OtherUiState();
}

class _OtherUiState extends State<OtherUi> {
  final List<Map<String, dynamic>> data = [
    {'Name': 'Sagar Kumar', 'Total Task/Completed': '0', 'Total': '45'},
    {'Name': 'Sagar Kumar', 'Total Task/Completed': '0', 'Total': '45'},
    {'Name': 'Sagar Kumar', 'Total Task/Completed': '0', 'Total': '45'},
    {'Name': 'Sagar Kumar', 'Total Task/Completed': '0', 'Total': '45'},
    {'Name': 'Sagar Kumar', 'Total Task/Completed': '0', 'Total': '45'},
    {'Name': 'Sagar Kumar', 'Total Task/Completed': '0', 'Total': '45'},
    {'Name': 'Sagar Kumar', 'Total Task/Completed': '0', 'Total': '45'},
    {'Name': 'Sagar Kumar', 'Total Task/Completed': '0', 'Total': '45'},
    {'Name': 'Sagar Kumar', 'Total Task/Completed': '0', 'Total': '45'},
    {'Name': 'Sagar Kumar', 'Total Task/Completed': '0', 'Total': '45'},
    {'Name': 'Sagar Kumar', 'Total Task/Completed': '0', 'Total': '45'},
    {'Name': 'Sagar Kumar', 'Total Task/Completed': '0', 'Total': '45'},
    {'Name': 'Sagar Kumar', 'Total Task/Completed': '0', 'Total': '45'},
    {'Name': 'Sagar Kumar', 'Total Task/Completed': '0', 'Total': '45'},
    {'Name': 'Sagar Kumar', 'Total Task/Completed': '0', 'Total': '45'},
  ];
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return Column(
      children: [
        const PlatformNameUi(
          platformName: "PlatFormName :- OTHER",
        ),
        verticalSpace(10),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: DataTable2(
              columnSpacing: 5,
              horizontalMargin: 10,
              dataRowHeight: 55,
              dividerThickness: 0,
              border: TableBorder(
                  borderRadius: BorderRadius.circular(10),
                  horizontalInside:
                  const BorderSide(color: Colors.white)),
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
                        : const Color.fromRGBO(216, 222, 218, 1),
                  ],
                  stops: const [0.0, 1.0], // Stops to match 0% and 100%
                ),
              ),
              minWidth: screenWidth(context) * 1,
              dataTextStyle: GoogleFonts.playfairDisplay(
                  textStyle:  TextStyle(
                      color :themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorBlack,
                      fontSize: 14)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              columns:  [
                DataColumn(
                  label: CommonKhandText(
                    title: "Profile",
                    textColor:themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorWhite,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                DataColumn(
                    label: CommonKhandText(
                      title: "Name",
                      textColor:themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorWhite,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    )),
                DataColumn(
                    label: CommonKhandText(
                      title: "Total Task/\nCompleted",
                      textColor:themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorWhite,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    )),
                DataColumn(
                    label: Center(
                      child: CommonKhandText(
                        title: "Total",
                        textColor:themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    )),
              ],
              rows: List<DataRow>.generate(data.length, (index) {
                final item = data[index];
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
                    DataCell(Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(AssetUtils.myPic),
                              fit: BoxFit.fill)),
                    )),
                    DataCell(Center(child: Text(item['Name']))),
                    DataCell(Center(
                      child: Text(item['Total Task/Completed']
                          .toString()),
                    )), // Converting to string for display
                    DataCell(Container(
                        height: 25,
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 3, top: 3),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorBlack,
                              width: 0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(child: Text(item['Total'])))),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
