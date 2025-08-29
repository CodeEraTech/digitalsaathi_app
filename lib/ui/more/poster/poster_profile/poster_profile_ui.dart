import 'package:digitalsaathi/data/model/political_profile_response.dart';
import 'package:digitalsaathi/ui/more/poster/poster_profile/edit_create_poster_profile.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../../constants/components/pro_text.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utils/color_utils.dart';

class MyPosterProfileUi extends StatefulWidget {
  final PoliticalProfileData politicalProfileData;
  final VoidCallback selectFunction;
  final VoidCallback editFunction;
  final VoidCallback deleteFunction;

  const MyPosterProfileUi(
      {super.key,
      required this.politicalProfileData,
      required this.selectFunction,
      required this.editFunction,
      required this.deleteFunction,});

  @override
  State<MyPosterProfileUi> createState() => _MyPosterProfileUiState();
}

class _MyPosterProfileUiState extends State<MyPosterProfileUi> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Card(
                margin: const EdgeInsets.only(top: 50),
                elevation: 5,
                child: Container(
                  width: screenWidth(context),
                  padding: const EdgeInsets.only(
                    top: 55,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                          image: AssetImage(AssetUtils.screenBackgroundFour),
                          fit: BoxFit.fill)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Center(
                        child: CommonKhandText(
                          title: widget.politicalProfileData.name,
                          textColor: ColorUtils.colorWhite,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          textAlign: TextAlign.center,
                        ),
                      ),
                       Center(
                        child: CommonKhandText(
                          title: widget.politicalProfileData.designation,
                          textAlign: TextAlign.center,
                          textColor: ColorUtils.colorWhite,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      verticalSpace(8),
                      Container(
                        width: screenWidth(context),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: const DecorationImage(
                                image:
                                    AssetImage(AssetUtils.screenBackgroundFour),
                                fit: BoxFit.fill)),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                widget.politicalProfileData.leaders.isEmpty?SizedBox.shrink():Column(
                                  children: [

                                    Container(
                                      height: 60,
                                      child: ListView.separated(
                                          separatorBuilder: (context,index){
                                            return VerticalDivider();
                                          },
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: widget.politicalProfileData.leaders.length,
                                          itemBuilder: (context,index){

                                            return Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(50)),
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                padding: const EdgeInsets.all(5),
                                                decoration:  BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            widget.politicalProfileData.leaders[index].image)
                                                    )
                                                ),
                                              ),
                                            );
                                          }),
                                    ),

                                    const CommonKhandText(
                                      title: "Leader",
                                      textColor: ColorUtils.colorWhite,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ],
                                ),
                                verticalSpace(20),
                                widget.politicalProfileData.leaderSymbol.isEmpty?SizedBox.shrink():Column(
                                  children: [
                                     Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        padding: const EdgeInsets.all(3),
                                        decoration:  BoxDecoration(
                                            shape: BoxShape.circle,
                                            // color: Colors.white,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    widget.politicalProfileData.leaderSymbol))),
                                      ),
                                    ),
                                     const CommonKhandText(
                                      title: "Symbol",
                                      textColor: ColorUtils.colorWhite,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            verticalSpace(5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: screenWidth(context) * 0.9,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Visibility(
                                        visible: widget.politicalProfileData.facebook.isNotEmpty,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Row(
                                            children: [
                                              const Image(
                                                image: AssetImage(
                                                    AssetUtils.Facebook),
                                                height: 15,
                                              ),
                                              horizontalSpace(5),
                                               CommonKhandText(
                                                title: widget.politicalProfileData.facebook,
                                                textAlign: TextAlign.start,
                                                textColor: Colors.white,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                          visible: widget.politicalProfileData.whatsapp.isNotEmpty,
                                          child: verticalSpace(10)),
                                      Visibility(
                                        visible: widget.politicalProfileData.whatsapp.isNotEmpty,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Row(
                                            children: [
                                              const Image(
                                                image: AssetImage(
                                                    AssetUtils.Whatsapp),
                                                height: 15,
                                              ),
                                              horizontalSpace(8),
                                               CommonKhandText(
                                                title: widget.politicalProfileData.whatsapp,
                                                textColor: ColorUtils.colorWhite,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                          visible: widget.politicalProfileData.twitter.isNotEmpty,
                                          child: verticalSpace(10)),

                                      Visibility(
                                        visible: widget.politicalProfileData.twitter.isNotEmpty,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Row(
                                            children: [
                                              const Image(
                                                image: AssetImage(
                                                    AssetUtils.Twitter),
                                                height: 15,
                                              ),
                                              horizontalSpace(8),
                                               CommonKhandText(
                                                title: widget.politicalProfileData.twitter,
                                                textColor: ColorUtils.colorWhite,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            verticalSpace(5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    widget.selectFunction();
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color:Colors.blue,
                                        borderRadius: BorderRadius.circular(6)),
                                    child:  Center(
                                      child: CommonKhandText(
                                        title: "Select",
                                        textAlign: TextAlign.center,
                                        textColor: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.editFunction();

                                  },
                                  child: Container(
                                    height: 35,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(6)),
                                    child: const Center(
                                      child: CommonKhandText(
                                        title: "Edit",
                                        textAlign: TextAlign.center,
                                        textColor: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.deleteFunction();
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 100,
                                    // padding: EdgeInsets.only(left: 15,right: 15),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(6)),
                                    child: const Center(
                                      child: CommonKhandText(
                                        title: "Delete",
                                        textAlign: TextAlign.center,
                                        textColor: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // profile ui
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                margin: const EdgeInsets.only(
                  left: 120,
                ),
                child: Container(
                  height: 100,
                  width: 100,
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(AssetUtils.screenBackgroundFour),
                          fit: BoxFit.fill)),
                  child: Container(
                    height: 95,
                    width: 95,
                    padding: const EdgeInsets.all(4),
                    decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                            image: widget.politicalProfileData.profileImg.isEmpty?AssetImage(AssetUtils.profilePng):NetworkImage(widget.politicalProfileData.profileImg),
                          fit: BoxFit.fill
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpace(5),
        const Divider()
      ],
    );
  }
}
