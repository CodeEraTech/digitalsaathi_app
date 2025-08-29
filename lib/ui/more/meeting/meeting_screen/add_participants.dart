import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/data/model/meeting_detail_response.dart';
import 'package:digitalsaathi/provider/meeeting_provider.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:digitalsaathi/constants/components/my_TextField.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../constants/components/pro_text.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/color_utils.dart';
import 'meeting_model.dart';

class AddParticipants extends StatefulWidget {
  final Participants? participants;
  final String meetingId;
  const AddParticipants({super.key, this.participants,required this.meetingId});

  @override
  State<AddParticipants> createState() => _AddParticipantsState();
}

class _AddParticipantsState extends State<AddParticipants> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // if(widget.participants != null){
      Provider.of<MeetingProvider>(context,listen: false).setUpdateData(widget.participants);
   // }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
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
          title: const CommonKhandText(
            title: "Add Participant",
            textColor: ColorUtils.colorWhite,
            fontWeight: FontWeight.w300,
            fontSize: 18,
          ),
        ),
        body: Consumer<MeetingProvider>(
          builder: (context,meetingProvider,_) {
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
                  padding: const EdgeInsets.all(12),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        MyTextField(
                          controller: meetingProvider.nameCtr,
                          labelText: "Name",
                          showBorders: true,
                        ),
                        MyTextField(
                          controller: meetingProvider.mobileCtr,
                          labelText: "Mobile",
                          showBorders: true,
                          maxLength: 10,
                          keyboardType: TextInputType.phone,
                        ),
                        MyTextField(
                          controller: meetingProvider.emailCtr,
                          labelText: "E-mail",
                          showBorders: true,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        MyTextField(
                          controller: meetingProvider.fatherNameCtr,
                          labelText: "Father Name",
                          showBorders: true,
                          keyboardType: TextInputType.name,
                        ),
                        MyTextField(
                          controller: meetingProvider.genderCtr,
                          labelText: "Gender",
                          showBorders: true,
                        ),
                        MyTextField(
                          controller: meetingProvider.designationCtr,
                          labelText: "Designation",
                          showBorders: true,
                        ),
                        MyTextField(
                          controller: meetingProvider.ageCtr,
                          labelText: "Age",
                          showBorders: true,
                          keyboardType: TextInputType.number,
                        ),
                        MyTextField(
                          controller: meetingProvider.idCardNoCtr,
                          labelText: "ID Card No.",
                          showBorders: true,
                        ),
                        MyTextField(
                          controller: meetingProvider.wardNoCtr,
                          labelText: "Ward No.",
                          showBorders: true,
                        ),
                        MyTextField(
                          controller: meetingProvider.castCtr,
                          labelText: "Cast",
                          showBorders: true,
                        ),
                        verticalSpace(35),
                        GestureDetector(
                          onTap: () {
                            if(widget.participants==null){
                              meetingProvider.addParticipant(context,widget.meetingId);
                            }else{
                              meetingProvider.updateParticipant(context, widget.meetingId, widget.participants!.id.toString());
                            }
                          },
                          child: Container(
                            height: 55,
                            width: screenWidth(context),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    image:
                                        AssetImage(AssetUtils.screenBackgroundFive),
                                    fit: BoxFit.fill)),
                            child:  Center(
                              child: CommonKhandText(
                                title: widget.participants==null? "SUBMIT":"UPDATE",
                                textColor: ColorUtils.colorWhite,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                meetingProvider.isLoading?const CustomLoader():const SizedBox.shrink()
              ],
            );
          },
        ));
  }
}
