import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../constants/components/pro_text.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/asset_utils.dart';
import '../../../../utils/color_utils.dart';

class ComplaintDetails extends StatefulWidget {
  const ComplaintDetails({super.key});

  @override
  State<ComplaintDetails> createState() => _ComplaintDetailsState();
}

class _ComplaintDetailsState extends State<ComplaintDetails> {
  final TextEditingController _controller = TextEditingController();
  List<String> _comments = []; // List to hold comments

  @override
  void initState() {
    super.initState();
    // _comments = List.from(widget.existingComments); // Initialize with existing comments
  }

  void _postComment() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _comments.add(_controller.text); // Add the comment to the list
      });
      // widget.onCommentAdded(_comments.length); // Pass the updated count back
      _controller.clear(); // Clear the text field after posting
      // Navigator.pop(context); // Navigate back to the previous screen
    }
  }
  String address =  "Noida One IT Park,1113,11th Floor TOWER-C, Rasoolpur Nawada ,Industrial Area,Sector 62,Noida,Utter Pradesh 20309,India ";
  String discription ="Durga Pooja is a Hindu festival celebration of the Mother Goddess and the victory of the warrior Goddess Durga over the demon Mahisasura. The festival represents female power as ‘Shakti’ in the Universe. It is a festival of Good over Evil. Durga Pooja is one of the greatest festivals of India. In addition to being a festival for the Hindus, it is also time for a reunion of family and friends, and a ceremony of cultural values and customs.";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            title: "Complaint Details",
            textColor: Color(0xffffffff),
            fontWeight: FontWeight.w300,
            fontSize: 18,
          ),
        ),
        // bottomSheet: Container(
        //   height: 57,
        //   padding: const EdgeInsets.all(10),
        //   decoration:  const BoxDecoration(
        //     // color: Color(0xffFFFFFF),
        //       image:DecorationImage(image: AssetImage(AssetUtils.bgMlaFollow),fit: BoxFit.fill),
        //       border: Border(top: BorderSide(color:Color(0xffffffff), width: 1))),
        //   child: TextField(
        //     controller: _controller,
        //     decoration: InputDecoration(
        //         border: InputBorder.none,
        //         hintText: "Enter your Comment...",
        //         hintStyle: GoogleFonts.playfairDisplay(
        //           textStyle: const TextStyle(
        //             fontSize: 15,
        //             fontWeight: FontWeight.w400,
        //             color: const Color(0xffffffff),
        //           ),
        //         ),
        //         suffixIcon: GestureDetector(
        //           onTap: _postComment,
        //           child: const Image(
        //               image: AssetImage(
        //                 AssetUtils.messageSend,
        //               )),
        //         )),
        //   ),
        // ),

        body:Container(
          height: screenHeight(context),
          width: screenWidth(context),
          padding: const EdgeInsets.fromLTRB(12,10,12,10),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 const Align(
                  alignment: Alignment.topCenter,
                  child: CommonKhandText(
                    title: "RESTIMP WK2",
                    textColor:ColorUtils.colorWhite,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                verticalSpace(10),
                const Row(
                  children: [
                     CommonKhandText(
                      title: "Complaint No : ",
                       textColor:Color(0xffF0E68C),
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                    CommonKhandText(
                      title: "000154",
                      textColor:ColorUtils.colorWhite,
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                  ],
                ),
                verticalSpace(10),
                 Row(
                  children: [
                    CommonKhandText(
                      title: "Complaint Time : ",
                      textColor:Color(0xffF0E68C),
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                    CommonKhandText(
                      title: "10 Oct 2024 5:08 PM",
                      textColor:ColorUtils.colorWhite,
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                  ],
                ),
                verticalSpace(10),
                 Row(
                  children: [
                    CommonKhandText(
                      title: "Complaint For : ",
                      textColor:Color(0xffF0E68C),
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                    CommonKhandText(
                      title: "Self",
                      textColor:ColorUtils.colorWhite,
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                  ],
                ),
                verticalSpace(10),

                RichText(
                  text: TextSpan(
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 15,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Address : ',
                        style: GoogleFonts.playfairDisplay(
                            fontSize: 15,
                            color:Color(0xffF0E68C),
                            fontWeight: FontWeight.w600
                        ),

                      ),
                      TextSpan(
                        text:address,
                        style: GoogleFonts.playfairDisplay(
                            fontSize: 15,
                            color:ColorUtils.colorWhite,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(10),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 15,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Description : ',
                        style: GoogleFonts.playfairDisplay(
                            fontSize: 15,
                            color:Color(0xffF0E68C),
                            fontWeight: FontWeight.w600
                        ),

                      ),
                      TextSpan(
                        text:discription,
                        style: GoogleFonts.playfairDisplay(
                            fontSize: 15,
                            color:ColorUtils.colorWhite,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(10),
                 CommonKhandText(
                  title: "Comments : ",
                   textColor:Color(0xffF0E68C),
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                ),
                verticalSpace(10),
                SizedBox(
                  height: 200,
                  width: screenWidth(context),
                  child: ListView.builder(
                    itemCount: _comments.length,
                    shrinkWrap: true,
                    // padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                color:themeProvider.darkTheme ?  ColorUtils.colorWhite.withOpacity(0.2): ColorUtils.colorBlack.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)
                  
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(AssetUtils.myPic))),
                                ),
                                horizontalSpace(15),
                                Expanded(
                                  flex: 15,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const CommonKhandText(
                                        title: "You",
                                        textColor: Color(0xff00ff00),
                                        fontSize: 16,
                                      ),
                                      CommonKhandText(
                                        title: _comments[index],
                                        textColor:themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorBlack,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                 CommonKhandText(
                                  title: "23 Sept 2024 1:07 PM",
                                  textColor:themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorBlack,
                                  fontSize: 11,
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  height:55,
                  padding: EdgeInsets.all(10),
                   decoration:   BoxDecoration(
                      image:const DecorationImage(image: AssetImage(AssetUtils.bgMlaFollow),fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your Comment...",
                          hintStyle: GoogleFonts.playfairDisplay(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffffffff),
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: _postComment,
                            child: SizedBox(
                              height: 25,
                              width: 25,
                              child: const Image(
                                  image: AssetImage(
                                    AssetUtils.messageSend,
                                  )
                              ),
                            ),
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          title: const CommonKhandText(
            title: "Are you sure? You really want to delete this?",
            fontWeight: FontWeight.w300,
            textColor: Colors.black,
            fontSize: 17,
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // Close dialog on "No"
                    },
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: CommonKhandText(
                          title: "No",
                          fontWeight: FontWeight.w300,
                          textColor: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Remove the item from the list
                      setState(() {
                        // assemblyData.removeAt(index);
                      });
                      Navigator.of(context).pop(); // Close dialog after removal
                    },
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: const CommonKhandText(
                          title: "Yes",
                          fontWeight: FontWeight.w300,
                          textColor: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

}
