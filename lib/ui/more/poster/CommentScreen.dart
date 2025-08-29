import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/constants/components/pro_text.dart';
import 'package:digitalsaathi/provider/poster_provider.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../provider/theme_provider.dart';
import '../../../utils/color_utils.dart';

class CommentScreen extends StatefulWidget {
  final Function(int) onCommentAdded;
  final String eventId;
  final int index;
  final List<String> existingComments; // New parameter for existing comments

  const CommentScreen(
      {super.key,
      required this.onCommentAdded,
      required this.eventId,
      required this.index,
      required this.existingComments});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> _comments = []; // List to hold comments

  @override
  void initState() {
    super.initState();


    _comments =
        List.from(widget.existingComments);

    Provider.of<PosterProvidder>(context,listen: false).getPosterComments(widget.eventId);
  }

  void _postComment(PosterProvidder postProvider) {
    if (_controller.text.isNotEmpty) {
      postProvider.postComment(widget.eventId, _controller.text.toString(),widget.index).then((onValue){
        _controller.clear();
      });
     // widget.onCommentAdded(_comments.length); // Pass the updated count back
     // Clear the text field after posting
      // Navigator.pop(context); // Navigate back to the previous screen
    }
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
          title: "Comments",
          textColor: Color(0xffffffff),
          fontWeight: FontWeight.w300,
          fontSize: 17,
        ),
      ),
      bottomSheet: Consumer<PosterProvidder>(
        builder: (context,posterProvider,_) {
          return Container(
            height: 57,
            padding: const EdgeInsets.all(10),
            decoration:  const BoxDecoration(
                // color: Color(0xffFFFFFF),
              image:DecorationImage(image: AssetImage(AssetUtils.bgMlaFollow),fit: BoxFit.fill),
                border: Border(top: BorderSide(color:Color(0xffffffff), width: 1))),
            child: TextField(
              controller: _controller,
              style: GoogleFonts.playfairDisplay(
                color: ColorUtils.colorWhite
              ),
              cursorColor: ColorUtils.colorWhite,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter your Comment...",
                  hintStyle: const TextStyle(color: Colors.white),
                  suffixIcon: GestureDetector(
                    onTap:()=> _postComment(posterProvider),
                    child: const Image(
                        image: AssetImage(
                      AssetUtils.messageSend,
                    )),
                  )),
            ),
          );
        }
      ),
      body: Consumer<PosterProvidder>(
        builder: (context,posterProvider,_) {
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
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Column(
                        children: [
                          ListView.builder(
                            itemCount: posterProvider.posterComments.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color:ColorUtils.colorWhite.withOpacity(0.1),
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
                                                colorFilter: ColorFilter.mode(ColorUtils.colorWhite, BlendMode.colorDodge),
                                                  image: AssetImage(AssetUtils.profilePng))),
                                        ),
                                        horizontalSpace(15),
                                        SizedBox(
                                          width: screenWidth(context) * 0.48,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                               CommonKhandText(
                                                title: "${posterProvider.posterComments[index].firstName}",
                                                textColor: Color(0xff00ff00),
                                                fontSize: 16,
                                              ),
                                              CommonKhandText(
                                                title: posterProvider.posterComments[index].comment,
                                                textColor: ColorUtils.colorWhite,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: screenWidth(context) * 0.29,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                               CommonKhandText(
                                                title: posterProvider.posterComments[index].createdAt,
                                                 textColor: ColorUtils.colorWhite,
                                                fontSize: 11,
                                              ),
                                              verticalSpace(20),
                                               // GestureDetector(
                                               //   onTap: ()=> _showDialog(context),
                                               //   child:  Row(
                                               //    crossAxisAlignment: CrossAxisAlignment.start,
                                               //    mainAxisAlignment: MainAxisAlignment.end,
                                               //    children: [
                                               //      Icon(
                                               //        Icons.delete,
                                               //        color: ColorUtils.colorWhite,
                                               //      ),
                                               //      CommonKhandText(
                                               //        title: "Delete",
                                               //        textColor: ColorUtils.colorWhite,
                                               //        fontSize: 14,
                                               //        fontWeight: FontWeight.w600,
                                               //      ),
                                               //    ],
                                               //                                       ),
                                               // ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              posterProvider.isLoading?const CustomLoader():const SizedBox.shrink()
            ],
          );
        }
      ),
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
                      child: const Center(
                        child: CommonKhandText(
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
