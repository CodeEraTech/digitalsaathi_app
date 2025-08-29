import 'dart:io';

import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/data/model/category_and_mla_response.dart';
import 'package:digitalsaathi/provider/complaint_provider.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:digitalsaathi/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../constants/components/my_TextField.dart';
import '../../../../constants/components/pro_text.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utils/color_utils.dart';
import 'add_location.dart';

class RaiseComplaint extends StatefulWidget {
  final String createType;
  const RaiseComplaint({super.key,required this.createType});

  @override
  State<RaiseComplaint> createState() => _RaiseComplaintState();
}

class _RaiseComplaintState extends State<RaiseComplaint> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ComplaintProvider>(context,listen: false).determinePosition(context);
    Provider.of<ComplaintProvider>(context,listen: false).onInitValue();
    Provider.of<ComplaintProvider>(context,listen: false).getMlaAndCategory().then((value){
      setState(() {

      });
    });

  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: CommonKhandText(
          title: "Raise ${widget.createType}",
          textColor: themeProvider.darkTheme
              ? ColorUtils.colorWhite
              : ColorUtils.colorBlack,
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),
        actions: [
          // Consumer<ComplaintProvider>(
          //   builder: (context,locationProvider,_) {
          //     return Container(
          //       height: 40,
          //       width: 40,
          //       margin: const EdgeInsets.only(right: 8),
          //       // padding: const EdgeInsets.only(left: 8),
          //       decoration: BoxDecoration(
          //           color: Colors.black.withOpacity(0.2), shape: BoxShape.circle),
          //       child: GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) =>  AddLocation(initCoordinates: LatLng(locationProvider.currentPosittion!.latitude, locationProvider.currentPosittion!.latitude),),
          //             ),
          //           );
          //         },
          //         child: const Center(
          //           // Center the Icon widget here
          //           child: Icon(
          //             Icons.location_on,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //     );
          //   }
          // )
        ],
      ),
      body: Consumer<ComplaintProvider>(
        builder: (context,complaintProvider,_) {
          return Stack(
            children: [
              Container(
                height: screenHeight(context),
                width: screenWidth(context),
                padding: const EdgeInsets.all(12),
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
                  padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
                  reverse: true,
                  // physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyTextField(
                        showBorders: true,
                        controller: complaintProvider.subjectCtr,
                        labelText: "Subject*",
                      ),
                      verticalSpace(15),
                      const CommonKhandText(
                        title: "Description*",
                        textColor: ColorUtils.colorWhite,
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                      verticalSpace(5),
                      Container(
                        width: screenWidth(context),
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 0.5, color: ColorUtils.colorWhite)),
                        child: MyTextField(
                          showBorders: false,
                          controller: complaintProvider.descriptionCtr,
                          maxLines: null,
                          minLines: 1,
                          textAlignVertical: TextAlignVertical.top,
                        ),
                      ),
                      verticalSpace(3),
                      Align(
                        alignment: Alignment.topRight,
                        child: CommonKhandText(
                          title: "Maximum 200 words",
                          textColor: ColorUtils.colorWhite,
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                      DropdownButton<Category>(
                        iconSize: 30,
                        isExpanded: true,
                        iconEnabledColor:  ColorUtils.colorWhite,
                        menuWidth: screenWidth(context) * 0.8,
                        elevation: 4,
                        dropdownColor: themeProvider.darkTheme
                            ? ColorUtils.colorBlack
                            : ColorUtils.colorBlack,
                        style: GoogleFonts.playfairDisplay(
                            textStyle: const TextStyle(fontSize: 14, color: ColorUtils.colorWhite,)),
                        hint: CommonKhandText(
                          title: "Category*",
                          textColor: ColorUtils.colorWhite,
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                        ),
                        value: complaintProvider.categorySelectedValue,
                        items: complaintProvider.getCategoryList.map((Category item) {
                          return DropdownMenuItem<Category>(
                            value: item,
                            child: CommonKhandText(
                              title: item.name,
                              textColor: themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorWhite,
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                            ),
                          );
                        }).toList(),
                        onChanged: (Category? newValue) {
                         complaintProvider.onCategorySelected(newValue!);
                        },
                      ),
                      verticalSpace(10),
                      DropdownButton<Mla>(
                        // focusColor: Colors.white,
                        iconSize: 30,
                        isExpanded: true,
                        iconEnabledColor: ColorUtils.colorWhite,
                        menuWidth: screenWidth(context) * 0.8,
                        elevation: 4,
                        dropdownColor: themeProvider.darkTheme
                            ? ColorUtils.colorBlack
                            : ColorUtils.colorBlack,
                        style: GoogleFonts.playfairDisplay(
                            textStyle:  TextStyle(
                          fontSize: 14,
                          color:  themeProvider.darkTheme
                              ? ColorUtils.colorWhite
                              : ColorUtils.colorBlack,
                        )),
                        hint: const CommonKhandText(
                          title: "Tag Invites*",
                          textColor: ColorUtils.colorWhite,
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                        ),
                        value: complaintProvider.tagInviteSelectedValue,
                        items: complaintProvider.getMLAList.map((Mla tagInvitesItem) {
                          return DropdownMenuItem<Mla>(
                            value: tagInvitesItem,
                            alignment: Alignment.centerLeft,
                            child: CommonKhandText(
                              title: tagInvitesItem.name,
                              textColor: themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorWhite,
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          );
                        }).toList(),
                        onChanged: (Mla? newValue) {
                          complaintProvider.onMLATagSelected(newValue!);
                        },
                      ),
                      verticalSpace(10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CommonKhandText(
                            title: "Complaint Location",
                            textColor: ColorUtils.colorWhite,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                          horizontalSpace(5),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  AddLocation(initCoordinates: LatLng(complaintProvider.currentPosittion!.latitude, complaintProvider.currentPosittion!.latitude),onlyView: false,),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.location_on,
                                color: ColorUtils.colorWhite,
                              ))
                        ],
                      ),
                      verticalSpace(10),
                      MyTextField(
                        controller: complaintProvider.addressCtr,
                        labelText: "Enter your address here ",
                        showBorders: true,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: complaintProvider.isChecked,
                              activeColor: Colors.blue,
                              side: BorderSide(
                                color:ColorUtils.colorWhite,
                              ),
                              onChanged: complaintProvider.onCheckboxChanged),
                          CommonKhandText(
                            title: "High Severity",
                            textColor: ColorUtils.colorWhite,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio<String>(
                            value: 'Self',
                            activeColor: Colors.blue,
                            fillColor: const WidgetStatePropertyAll(Colors.blue),
                            groupValue: complaintProvider.selectedRbValue,
                            onChanged: (value) {
                              complaintProvider.radioGroupChange(value!, false);
                            },
                          ),
                          CommonKhandText(
                            title: "Self",
                            textColor: ColorUtils.colorWhite,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                          SizedBox(width: 20), // Spacing between radio buttons
                          Radio<String>(
                            activeColor: Colors.blue,
                            fillColor: WidgetStatePropertyAll(Colors.blue),
                            value: 'Other',
                            groupValue: complaintProvider.selectedRbValue,
                            onChanged: (value) {
                              complaintProvider.radioGroupChange(value!, true);
                            },
                          ),
                          CommonKhandText(
                            title: "Other",
                            textColor: ColorUtils.colorWhite,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ],
                      ),
                      if (complaintProvider.showOtherDesign)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyTextField(
                              controller: complaintProvider.nameCtr,
                              labelText: "Name",
                              showBorders: true,
                            ),
                            MyTextField(
                              controller: complaintProvider.epicCtr,
                              labelText: "EPIC Number",
                              showBorders: true,
                            ),
                            MyTextField(
                              controller: complaintProvider.mobileCtr,
                              labelText: "Mobile No.",
                              showBorders: true,
                            ),
                          ],
                        ),
                      verticalSpace(10),
                      InkWell(
                        onTap: () async{
                          FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
                          if (result != null) {
                            complaintProvider.documentFiles = result.paths.map((path) => File(path!)).toList();
                            setState(() {

                            });
                          }
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            horizontalSpace(12),
                            Icon(
                              Icons.drive_folder_upload,
                              color: ColorUtils.colorWhite,
                            ),
                            horizontalSpace(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonKhandText(
                                  title: "Upload Document",
                                  textColor: ColorUtils.colorWhite,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                                CommonKhandText(
                                  title: "(JPEG,PNG,JPG,pdf,docx)",
                                  textColor: ColorUtils.colorWhite,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 11,
                                ),
                                Visibility(
                                  visible: complaintProvider.documentFiles.isNotEmpty,
                                  child: CommonKhandText(
                                    title: "${complaintProvider.documentFiles.length} files selected",
                                    textColor: ColorUtils.colorGreen,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(70),
                      GestureDetector(
                        onTap: () {
                          if(complaintProvider.subjectCtr.text.toString().isEmpty){
                            Utils.toastMessage("Enter subject!!!");
                            return;
                          }else if(complaintProvider.descriptionCtr.text.toString().isEmpty){
                            Utils.toastMessage("Enter discription!!!");
                            return;
                          }else if(complaintProvider.categorySelectedValue == null){
                            Utils.toastMessage("Select Category!!!");
                            return;
                          }else if(complaintProvider.tagInviteSelectedValue == null){
                            Utils.toastMessage("Select Tag Invites!!!");
                            return;
                          }else if(complaintProvider.addressCtr.text.toString().isEmpty){
                            Utils.toastMessage("Enter Your Address!!!");
                            return;
                          }else if(complaintProvider.showOtherDesign){
                            if(complaintProvider.nameCtr.text.toString().isEmpty){
                              Utils.toastMessage("Enter Name!!!");
                              return;
                            }else if(complaintProvider.epicCtr.text.toString().isEmpty){
                              Utils.toastMessage("Enter EPIC!!!");
                              return;
                            }else if(complaintProvider.mobileCtr.text.toString().isEmpty){
                              Utils.toastMessage("Enter Mobile!!!");
                              return;
                            }
                          }
                          // else if(complaintProvider.documentFiles.isEmpty){
                          //   Utils.toastMessage("Upload Document!!!");
                          //   return;
                          // }

                          complaintProvider.raiseComplaint(context, widget.createType);
                        },
                        child: Container(
                          height: 55,
                          width: screenWidth(context),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                  image: AssetImage(AssetUtils.screenBackgroundFive),
                                  fit: BoxFit.fill)),
                          child: const Center(
                            child: CommonKhandText(
                              title: "SUBMIT",
                              textColor: ColorUtils.colorWhite,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      verticalSpace(15)
                    ],
                  ),
                ),
              ),
              complaintProvider.isLoading?const CustomLoader():const SizedBox.shrink()
            ],
          );
        }
      ),
    );
  }


}
