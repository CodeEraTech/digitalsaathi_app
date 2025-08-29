import 'dart:io';

import 'package:data_table_2/data_table_2.dart';
import 'package:digitalsaathi/constants/components/my_TextField.dart';
import 'package:digitalsaathi/data/model/meeting_list_response.dart';
import 'package:digitalsaathi/provider/meeeting_provider.dart';
import 'package:digitalsaathi/ui/more/meeting/meeting_screen/add_participants.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../constants/components/loader.dart';
import '../../../../constants/components/pro_text.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/color_utils.dart';
import 'meeting_model.dart';

class MeetingDetailsScreen extends StatefulWidget {
  final MeetingData meetingData;

  const MeetingDetailsScreen({super.key, required this.meetingData});

  @override
  State<MeetingDetailsScreen> createState() => _MeetingDetailsScreenState();
}

class _MeetingDetailsScreenState extends State<MeetingDetailsScreen> {
  TextEditingController meetingDescriptionCtr = TextEditingController();
  TextEditingController agendaDescriptionCtr = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<MeetingProvider>(context, listen: false)
        .getMeetingDetail(widget.meetingData.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Consumer<MeetingProvider>(builder: (context, meetingProvider, _) {
      return Scaffold(
        backgroundColor: themeProvider.darkTheme
            ? ColorUtils.colorBlack
            : ColorUtils.lightTheme,
        appBar: AppBar(
          surfaceTintColor: themeProvider.darkTheme
              ? ColorUtils.colorBlack
              : ColorUtils.appBarColor,
          backgroundColor: themeProvider.darkTheme
              ? ColorUtils.colorBlack
              : ColorUtils.appBarColor,
          centerTitle: true,
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
                  color: ColorUtils.colorWhite,
                ),
              ),
            ),
          ),
          title: CommonKhandText(
            title: widget.meetingData.meetingAgenda,
            textColor: ColorUtils.colorWhite,
            fontWeight: FontWeight.w300,
            fontSize: 17,
          ),
          actions: [
            if(meetingProvider.meetingDetailData.isNotEmpty)
            Visibility(
              visible: meetingProvider.meetingDetailData[0].review.isEmpty,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          meetingImages = [];
                          agendaImages = [];
                          meetingDescriptionCtr.text = "";
                          agendaDescriptionCtr.text = "";
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return buildDesign(widget.meetingData.id.toString());
                              });
                        },
                        child: const Icon(
                          Icons.note_add_rounded,
                          color: ColorUtils.colorWhite,
                        )),
                    horizontalSpace(10),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddParticipants(
                                participants: null,
                                meetingId: widget.meetingData.id.toString(),
                              ),
                            ),

                          ).then((onValue) {
                            if (onValue != null) {
                              meetingProvider.getMeetingDetail(
                                  widget.meetingData.id.toString());
                            }
                          });
                        },
                        child: const Icon(
                          Icons.add,
                          color: ColorUtils.colorWhite,
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
        body: Consumer<MeetingProvider>(builder: (context, meetingProvider, _) {
          return Stack(
            children: [
              Container(
                  height: screenHeight(context),
                  width: screenWidth(context),
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
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        verticalSpace(10),
                        meetingProvider.meetingDetailData.isNotEmpty
                            ? SizedBox(
                                height: screenHeight(context) * 0.88,
                                child: Column(
                                  children: [
                                    Container(
                                      width: screenWidth(context),
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          // color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  AssetUtils.bgMlaFollow),
                                              fit: BoxFit.fill)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: CommonKhandText(
                                              title: "PARTICIPANT REPORT",
                                              textColor: ColorUtils.colorWhite,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Card(
                                            margin: EdgeInsets.zero,
                                            elevation: 1,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              width: screenWidth(context),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  image: const DecorationImage(
                                                      image: AssetImage(
                                                          AssetUtils
                                                              .bgMlaFollow),
                                                      fit: BoxFit.fill)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const CommonKhandText(
                                                        title: "Total",
                                                        textColor: ColorUtils
                                                            .colorWhite,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 16,
                                                      ),
                                                      verticalSpace(10),
                                                      CommonKhandText(
                                                        title: meetingProvider
                                                            .meetingDetailData[
                                                                0]
                                                            .report
                                                            .totalParticipants
                                                            .toString(),
                                                        textColor: ColorUtils
                                                            .colorWhite,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 16,
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const CommonKhandText(
                                                        title: "Present",
                                                        textColor: ColorUtils
                                                            .colorWhite,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 16,
                                                      ),
                                                      verticalSpace(10),
                                                      CommonKhandText(
                                                        title: meetingProvider
                                                            .meetingDetailData[
                                                                0]
                                                            .report
                                                            .totalPresent
                                                            .toString(),
                                                        textColor: ColorUtils
                                                            .colorWhite,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 16,
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const CommonKhandText(
                                                        title: "Absent",
                                                        textColor: ColorUtils
                                                            .colorWhite,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 16,
                                                      ),
                                                      verticalSpace(10),
                                                      CommonKhandText(
                                                        title: meetingProvider
                                                            .meetingDetailData[
                                                                0]
                                                            .report
                                                            .totalAbsent
                                                            .toString(),
                                                        textColor: ColorUtils
                                                            .colorWhite,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 16,
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const CommonKhandText(
                                                        title: "New",
                                                        textColor: ColorUtils
                                                            .colorWhite,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 16,
                                                      ),
                                                      verticalSpace(10),
                                                      CommonKhandText(
                                                        title: meetingProvider
                                                            .meetingDetailData[
                                                                0]
                                                            .report
                                                            .totalNewParticipants
                                                            .toString(),
                                                        textColor: ColorUtils
                                                            .colorWhite,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 16,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: DataTable2(
                                        columnSpacing: 3,
                                        horizontalMargin: 5,
                                        dataRowHeight: 55,
                                        dividerThickness: 0,
                                        border: TableBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            horizontalInside: const BorderSide(
                                                color: Colors.white)),
                                        headingRowDecoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  AssetUtils.bgMlaFollow),
                                              fit: BoxFit.fill),
                                        ),
                                        //minWidth: screenWidth(context)*1.2,
                                        dataTextStyle:
                                            GoogleFonts.playfairDisplay(
                                                textStyle: const TextStyle(
                                                    color:
                                                        ColorUtils.colorWhite,
                                                    fontSize: 14)),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        columns: const [
                                          DataColumn2(
                                            size: ColumnSize.S,
                                            numeric: true,
                                            fixedWidth: 25,
                                            label: Center(
                                              child: CommonKhandText(
                                                title: "SN",
                                                textColor:
                                                    ColorUtils.colorWhite,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                              label: Center(
                                            child: CommonKhandText(
                                              title: "Name",
                                              textColor: ColorUtils.colorWhite,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          )),
                                          DataColumn(
                                              label: Center(
                                            child: CommonKhandText(
                                              title: "Mobile",
                                              textColor: ColorUtils.colorWhite,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          )),
                                          DataColumn(
                                              label: Center(
                                            child: CommonKhandText(
                                              title: "Post",
                                              textColor: ColorUtils.colorWhite,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          )),
                                          DataColumn2(
                                              size: ColumnSize.M,
                                              label: Center(
                                                child: CommonKhandText(
                                                  title: "Action",
                                                  textColor:
                                                      ColorUtils.colorWhite,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                ),
                                              )),
                                        ],
                                        rows: List<DataRow>.generate(
                                            meetingProvider.meetingDetailData[0]
                                                .participants.length, (index) {
                                          final item = meetingProvider
                                              .meetingDetailData[0]
                                              .participants[index];
                                          Color rowColor;
                                          // Assign colors based on index
                                          switch (index % 2) {
                                            case 0:
                                              rowColor =
                                                  const Color(0xffD2691E);
                                              break;
                                            case 1:
                                              rowColor =
                                                  const Color(0xffFFA07A);
                                              break;
                                            // case 2:
                                            // rowColor = const Color(0xffF08080);
                                            // break;
                                            default:
                                              rowColor = Colors.white;
                                          }
                                          return DataRow(
                                            color: MaterialStateProperty.all(
                                                rowColor),
                                            cells: [
                                              DataCell(
                                                Center(
                                                    child: Text((index + 1)
                                                        .toString())),
                                              ),
                                              DataCell(Center(
                                                  child: Text(item.name))),
                                              DataCell(Center(
                                                  child: InkWell(
                                                    onTap:(){
                                                      Utils.launchDialPad(item.mobile.toString());
                                          },
                                                    child: Text(
                                                        item.mobile.toString()),
                                                  ))),
                                              // Converting to string for display
                                              DataCell(Center(
                                                  child:
                                                      Text(item.designation))),
                                              DataCell(Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      String attendance = "1";
                                                      if (item.attandance.toString() ==
                                                          "0") {
                                                        attendance = "1";
                                                      } else if (item
                                                              .attandance.toString() ==
                                                          "1") {
                                                        attendance = "2";
                                                      } else if (item
                                                              .attandance.toString() ==
                                                          "2") {
                                                        attendance = "1";
                                                      }

                                                      meetingProvider
                                                          .markAttendance(
                                                              widget.meetingData
                                                                  .id
                                                                  .toString(),
                                                              item.id
                                                                  .toString(),
                                                              attendance,
                                                              index);
                                                    },
                                                    child: Container(
                                                      width: 49,
                                                      height: 23,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              item.attandance.toString() ==
                                                                      '1'
                                                                  ? Colors.green
                                                                  : Colors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(2)),
                                                      child: Center(
                                                        child: CommonKhandText(
                                                          title:
                                                              item.attandance.toString() ==
                                                                      '1'
                                                                  ? "Present"
                                                                  : "Mark",
                                                          textColor:
                                                              Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                AddParticipants(
                                                              participants:
                                                                  item,
                                                              meetingId: widget
                                                                  .meetingData
                                                                  .id
                                                                  .toString(),
                                                            ),
                                                          ),
                                                        ).then((onValue) {
                                                          if (onValue != null) {
                                                            meetingProvider
                                                                .getMeetingDetail(widget
                                                                    .meetingData
                                                                    .id
                                                                    .toString());
                                                          }
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.edit_note,
                                                        color: ColorUtils
                                                            .colorWhite,
                                                        size: 25,
                                                      ))
                                                ],
                                              ))
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  )),
              meetingProvider.isLoading
                  ? const CustomLoader()
                  : const SizedBox.shrink()
            ],
          );
        }),
      );
    });
  }

  ImagePicker _imagePicker = ImagePicker();

  List<File> meetingImages = [];
  List<File> agendaImages = [];


  Widget buildDesign(String meetingId) {

    return StatefulBuilder(
      builder: (context,customState) {
        return Padding(
            padding: MediaQuery.of(context).viewInsets,
          child: Container(
            width: screenWidth(context),
            height: screenHeight(context)/1.8,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                image: const DecorationImage(
                    image: AssetImage(AssetUtils.bgMlaFollow), fit: BoxFit.fill)),
            child: ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CommonKhandText(
                      title: "Meeting Description",
                      textColor: ColorUtils.colorWhite,
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                    const CommonKhandText(
                      title: "*",
                      textColor: ColorUtils.errorColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                  ],
                ),
                verticalSpace(5),
                Container(
                  width: screenWidth(context),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 0.5, color: ColorUtils.colorWhite)),
                  child: MyTextField(
                    showBorders: false,
                    controller: meetingDescriptionCtr,
                    maxLines: 30,
                    minLines: 1,
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                verticalSpace(5),

                InkWell(
                  onTap: () async{
                    List<XFile> files = await _imagePicker.pickMultiImage(limit: 3);
                    if(files.isNotEmpty){
                      for(var im in files){
                        if(meetingImages.length<3){
                          meetingImages.add(File(im.path));
                        }
                      }

                      customState(() {

                      });
                    }
                  },
                  child: Row(
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.photo,color: ColorUtils.colorWhite,size: 20,),
                              horizontalSpace(6),
                              const CommonKhandText(
                                title: "Upload meeting Images",
                                textColor: ColorUtils.colorWhite,
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                              ),
                            ],
                          ),
                          const CommonKhandText(
                            title: "(JPEG,png,jpg)",
                            textColor: ColorUtils.colorWhite,
                            fontWeight: FontWeight.w300,
                            fontSize: 13,
                          ),

                          verticalSpace(6),
                          Visibility(
                            visible: meetingImages.isNotEmpty,
                            child: Container(
                              height: 55,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: meetingImages.length,
                                  itemBuilder: (context,index){
                                return Container(
                                  height: 50,
                                  width: 50,
                                  margin: EdgeInsets.only(right: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: ColorUtils.colorWhite),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                          child: Image.file(meetingImages[index],fit: BoxFit.fill, height: 52,
                                            width: 50,)),

                                      InkWell(
                                        onTap:(){
                                          customState(() {
                                            meetingImages.removeAt(index);
                                          });
                                    },
                                          child: Icon(Icons.cancel,color: Colors.red,size: 20,))
                                    ],
                                  ),
                                );
                              }),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                verticalSpace(20),
                Row(
                  children: [
                    const CommonKhandText(
                      title: "Agenda Description",
                      textColor: ColorUtils.colorWhite,
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                    const CommonKhandText(
                      title: "*",
                      textColor: ColorUtils.errorColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                    ),
                  ],
                ),
                verticalSpace(5),
                Container(
                  width: screenWidth(context),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 0.5, color: ColorUtils.colorWhite)),
                  child: MyTextField(
                    showBorders: false,
                    controller: agendaDescriptionCtr,
                    maxLines: 30,
                    minLines: 1,
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                verticalSpace(5),
                InkWell(
                  onTap: () async{
                    List<XFile> files = await _imagePicker.pickMultiImage(limit: 3);
                    if(files.isNotEmpty){
                      for(var im in files){
                        if(agendaImages.length<3){
                          agendaImages.add(File(im.path));
                        }
                      }

                      customState(() {

                      });
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.photo,color: ColorUtils.colorWhite,size: 20,),
                          horizontalSpace(6),
                          const CommonKhandText(
                            title: "Upload Agenda Images",
                            textColor: ColorUtils.colorWhite,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ],
                      ),
                      const CommonKhandText(
                        title: "(JPEG,png,jpg)",
                        textColor: ColorUtils.colorWhite,
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                      ),

                      verticalSpace(6),
                      Visibility(
                        visible: agendaImages.isNotEmpty,
                        child: Container(
                          height: 55,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: agendaImages.length,
                              itemBuilder: (context,index){
                                return Container(
                                  height: 50,
                                  width: 50,
                                  margin: EdgeInsets.only(right: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: ColorUtils.colorWhite),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.file(agendaImages[index],fit: BoxFit.fill, height: 52,
                                            width: 50,)),

                                      InkWell(
                                          onTap:(){
                                            customState(() {
                                              agendaImages.removeAt(index);
                                            });
                                          },
                                          child: Icon(Icons.cancel,color: Colors.red,size: 20,))
                                    ],
                                  ),
                                );
                              }),
                        ),
                      )
                    ],
                  ),
                ),

                verticalSpace(15),
                InkWell(
                  onTap: (){
                    if(meetingDescriptionCtr.text.isEmpty){
                      Utils.toastMessage("Enter meeting description");
                      return;
                    }else if(meetingImages.isEmpty){
                      Utils.toastMessage("Select meeting images");
                      return;
                    }else if(agendaDescriptionCtr.text.isEmpty){
                      Utils.toastMessage("Enter meeting agenda");
                      return;
                    }else if(agendaImages.isEmpty){
                      Utils.toastMessage("Select agenda images");
                      return;
                    }
                    Provider.of<MeetingProvider>(context,listen: false).submitMeetingReview( meetingFiles: meetingImages, agendaFiles: agendaImages, meetingId: meetingId, meetingDesc: meetingDescriptionCtr.text.toString(), agendaDisc: agendaDescriptionCtr.text.toString());
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    width: screenWidth(context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black.withOpacity(0.3),
                        image: const DecorationImage(
                            image: AssetImage(AssetUtils.screenBackgroundFive),
                            fit: BoxFit.fill)),
                    child: const Center(
                      child: CommonKhandText(
                        title: "SUBMIT",
                        textColor: ColorUtils.colorWhite,
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
