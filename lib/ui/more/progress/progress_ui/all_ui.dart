import 'dart:async';

import 'package:data_table_2/data_table_2.dart';
import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/constants/components/my_TextField.dart';
import 'package:digitalsaathi/data/model/user_progress_model.dart';
import 'package:digitalsaathi/provider/progress_provider.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:intl/intl.dart';
import '../../../../constants/components/pro_text.dart';
import '../../../../provider/theme_provider.dart';
import 'package:provider/provider.dart';
import '../../../../utils/color_utils.dart';

class AllUi extends StatefulWidget {
  final String? platFormName;
  final bool isAll;
  const AllUi({super.key, this.platFormName, this.isAll = false});

  @override
  State<AllUi> createState() => _AllUiState();
}

class _AllUiState extends State<AllUi> {
  TextEditingController searchCtr = TextEditingController();
  Timer? timer;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      Provider.of<ProgressProvider>(context,listen: false).initInitialValue();
    Provider.of<ProgressProvider>(context,listen: false).getUserPerformance("", widget.platFormName! == "ALL"?"":widget.platFormName!,widget.isAll);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Consumer<ProgressProvider>(
      builder: (context,progressProvider,_) {
        return Column(
          children: [
            Container(
              width: screenWidth(context),
              decoration: BoxDecoration(
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
                  ],
                  stops: [0.0, 1.0], // Stops to match 0% and 100%
                ),
                // image: const DecorationImage(image: AssetImage(AssetUtils.bgMlaFollow),fit:BoxFit.fill)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.platFormName != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CommonKhandText(
                        title: widget.platFormName!,
                        textColor: themeProvider.darkTheme
                            ? ColorUtils.colorWhite
                            : ColorUtils.colorWhite,
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                    ),
                  Card(
                    margin: EdgeInsets.zero,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      width: screenWidth(context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
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
                        // image: const DecorationImage(image: AssetImage(AssetUtils.bgMlaFollow),fit:BoxFit.fill)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                onTap: () => progressProvider.selectDateFrom(context,widget.platFormName!,widget.isAll),
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
                                            progressProvider.formatDate(progressProvider.selectedDateFromData),
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
                                onTap: () => progressProvider.selectDateTo(context,widget.platFormName!,widget.isAll),
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
                                        title: progressProvider.formatDate(progressProvider.selectedDateToData),
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
                          verticalSpace(8),
                          Container(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            height: 45,
                            width: screenWidth(context),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.white,width: 0.5)
                            ),
                            child: Center(
                              child: MyTextField(
                                controller: searchCtr,
                                hintText: "Search",
                                showBorders: false,
                                onChanged: (val){
                                  if(timer != null){
                                    timer!.cancel();
                                  }
                                  timer = Timer(Duration(seconds: 1), searchData(val,progressProvider));

                                },
                              ),
                            ),
                          ),
                          verticalSpace(5),
                          GestureDetector(
                            onTap: () {
                              progressProvider.onClearFilter();
                            },
                            child: CommonKhandText(
                              title: "Clear",
                              textColor: themeProvider.darkTheme
                                  ? ColorUtils.colorWhite
                                  : ColorUtils.colorWhite,
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            verticalSpace(10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: DataTable2(
                  columnSpacing: 5,
                  horizontalMargin: 10,
                  dataRowHeight: 55,
                  dividerThickness: 0,
                  border: TableBorder(
                      borderRadius: BorderRadius.circular(10),
                      horizontalInside: BorderSide(
                          color: themeProvider.darkTheme
                              ? ColorUtils.colorWhite
                              : ColorUtils.colorBlack)),
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
                      textStyle: TextStyle(
                          color: themeProvider.darkTheme
                              ? ColorUtils.colorWhite
                              : ColorUtils.colorBlack,
                          fontSize: 14)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  columns: [
                    DataColumn(
                      label: Center(
                        child: CommonKhandText(
                          title: "Profile",
                          textColor: themeProvider.darkTheme
                              ? ColorUtils.colorWhite
                              : ColorUtils.colorWhite,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    DataColumn(
                        label: Center(
                      child: CommonKhandText(
                        title: "Name",
                        textColor: themeProvider.darkTheme
                            ? ColorUtils.colorWhite
                            : ColorUtils.colorWhite,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    )),
                    DataColumn(
                        label: Center(
                      child: CommonKhandText(
                        title: "Total Task/\nCompleted",
                        textColor: themeProvider.darkTheme
                            ? ColorUtils.colorWhite
                            : ColorUtils.colorWhite,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    )),
                    DataColumn(
                        label: Center(
                      child: CommonKhandText(
                        title: "Total",
                        textColor: themeProvider.darkTheme
                            ? ColorUtils.colorWhite
                            : ColorUtils.colorWhite,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    )),
                  ],
                  rows: List<DataRow>.generate(progressProvider.userProgressData.length, (index) {
                    UserProgressData item = progressProvider.userProgressData[index];
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
                        DataCell(Center(
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: item.userProfilePicture.toString().isEmpty?AssetImage(AssetUtils.profilePng):NetworkImage(AppUrl.BASE_IMAGE_URL+item.userProfilePicture),
                                    fit: BoxFit.fill)),
                          ),
                        )),
                        DataCell(Center(child: Text("${item.firstName??""}"))),
                        DataCell(Center(
                          child: Text(item.todayHierarchy.toString()),
                        )), // Converting to string for display
                        DataCell(Center(
                          child: Container(
                              height: 25,
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 3, top: 3),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: themeProvider.darkTheme
                                        ? ColorUtils.colorWhite
                                        : ColorUtils.colorBlack,
                                    width: 0.5),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(child: Text(item.totalHierarchy.toString()))),
                        )),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
  searchData(String val,ProgressProvider progressProvider){
    String date = "";
    if(progressProvider.selectedDateToData == null && progressProvider.selectedDateToData==null){
      date = "";
    } else if(progressProvider.selectedDateToData != null && progressProvider.selectedDateFromData == null){
      date = "${progressProvider.formatDate(progressProvider.selectedDateToData)}";

    }else if(progressProvider.selectedDateToData == null && progressProvider.selectedDateFromData != null){
      date = "${progressProvider.formatDate(progressProvider.selectedDateFromData)}";
    }else{
      date = "${progressProvider.formatDate(progressProvider.selectedDateFromData)} to ${progressProvider.formatDate(progressProvider.selectedDateToData)}";
    }
    progressProvider.getUserPerformance(date, widget.platFormName!, widget.isAll,nameSearch: val,needUpdate: true);
  }
}
