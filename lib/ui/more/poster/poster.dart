import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/constants/components/pro_text.dart';
import 'package:digitalsaathi/data/model/poster_list_response.dart';
import 'package:digitalsaathi/ui/more/poster/poster_font_size_adjuster/FontSizeController.dart';
import 'package:digitalsaathi/ui/more/poster/poster_font_size_adjuster/PosterFontSizeAdjuster.dart';
import 'package:digitalsaathi/provider/poster_provider.dart';
import 'package:digitalsaathi/ui/more/poster/CommentScreen.dart';
import 'package:digitalsaathi/ui/more/poster/poster_data_ui.dart';
import 'package:digitalsaathi/ui/more/poster/poster_profile/poster_profile.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:page_transition/page_transition.dart';
import '../../../provider/theme_provider.dart';
import '../../../utils/color_utils.dart';
import 'package:get/get.dart';

class PosterScreen extends StatefulWidget {

  const PosterScreen({super.key,});

  @override
  State<PosterScreen> createState() => _PosterScreenState();
}

class _PosterScreenState extends State<PosterScreen>with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int likeCount = 0; // Initial like count
  int commentCount = 0; // Initial comment count
  int shareCount = 0; // Initial share count
  bool isLiked = false; // Track if the post is liked
  List<String> comments = [];
  int type = 0 ;

  TextEditingController commentController = TextEditingController();
  final FontSizeController controller = Get.put(FontSizeController());


  _likePost(PosterProvidder posterProvider,PosterData p,int index) {
     posterProvider.posterLike(p.id.toString(),p.isLikeStatus=="1"?"0":"1",index);
  }

  void _commentPost(int newCommentCount) {
    setState(() {
      commentCount = newCommentCount; // Update the comment count
    });
  }

   _navigateToCommentScreen(String eventId,int index) {
    Navigator.push(
        context,
        PageTransition(
            duration: const Duration(milliseconds: 800),
            reverseDuration: Duration(milliseconds: 400),
            type: PageTransitionType.bottomToTop,
            child: CommentScreen(
              onCommentAdded: _commentPost,
              existingComments: comments,
              index: index,
              eventId: eventId,
            )
        )
    );
  }

  void _shareContent() {
    Share.share("Digital Saathi Share");
    setState(() {
      shareCount++;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    Provider.of<PosterProvidder>(context,listen: false).getAllPoster();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title:  const CommonKhandText(
          title: "Poster",
          textColor: Color(0xffffffff),
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),
        actions: [
          // Consumer<PosterProvidder>(builder: (context,posterProvider,_) {
          //   return GestureDetector(
          //     onTap: () {
          //       showDialog(
          //         context: context,
          //         builder: (context) => Dialog(
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.only(
          //               topLeft: Radius.circular(12),
          //               topRight: Radius.circular(12),
          //             ),
          //           ),
          //           alignment: Alignment.bottomCenter,
          //           insetPadding: EdgeInsets.zero,
          //           child: Container(
          //             height: 230,
          //             width: MediaQuery.of(context).size.width,
          //             decoration:  const BoxDecoration(
          //                 borderRadius: BorderRadius.only(
          //                   topLeft: Radius.circular(12),
          //                   topRight: Radius.circular(12),
          //                 ),
          //                 color: Color(0xffd9f0f2)
          //               // gradient: LinearGradient(
          //               //   begin: Alignment.bottomCenter,
          //               //   end: Alignment.topCenter,
          //               //   stops: [0.112, 0.789, 1.0],
          //               //   colors: [
          //               //     Color(0xFF3F3D3D),
          //               //     Color(0xFF3F3D3D),
          //               //     Color(0xFF606060),
          //               //   ],
          //               // ),
          //             ),
          //             padding: const EdgeInsets.all(10),
          //             child: PosterFontSizeAdjuster(
          //               defaultProfile: posterProvider.defaultProfile!,
          //               type: type,
          //               controller: controller,
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //     child: const CommonKhandText(
          //       title: "Edit",
          //       textColor: ColorUtils.colorWhite,
          //       fontWeight: FontWeight.w300,
          //       fontSize: 17,
          //     ),
          //   ) ;
          // },),
          // horizontalSpace(2),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePoster()),
              ).then((onValue){
              Provider.of<PosterProvidder>(context,listen: false).getAllPoster();
              });
            },
            child: CommonKhandText(
              title: "Poster Profile",
              textColor: ColorUtils.colorWhite,
              fontWeight: FontWeight.w300,
              fontSize: 17,
            ),
          ),
          Consumer<PosterProvidder>(builder: (context,posterProviderr,_) {
            return IconButton(onPressed: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                  insetPadding: EdgeInsets.zero,
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                    decoration:  const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        color: Color(0xffd9f0f2)
                    ),
                    padding: const EdgeInsets.all(10),
                    child: PosterFontSizeAdjuster(
                      defaultProfile: posterProviderr.defaultProfile!,
                      type: type,
                      controller: controller,
                    ),
                  ),
                ),
              );
            }, icon: Icon(Icons.settings,color: ColorUtils.primaryColor,));
          },),
        ],
        bottom:PreferredSize(
          preferredSize: Size.fromHeight(34),
          child: Container(
            width: double.infinity,
            height: 35,
            margin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.only(top: 3, bottom: 3),
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: false, // Make it not scrollable for equal spacing
              unselectedLabelColor:themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorBlack,
              controller: _tabController,
              dividerHeight: 0,
              labelPadding: const EdgeInsets.symmetric(
                  horizontal: 20), // Add horizontal padding
              labelStyle: GoogleFonts.playfairDisplay(
                textStyle:  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  color:themeProvider.darkTheme ?  ColorUtils.colorBlack: ColorUtils.colorWhite,
                ),
              ),
              indicator: BoxDecoration(
                // color: ColorUtils.appBarColor,
                  borderRadius: BorderRadius.circular(5),
                  image: const DecorationImage(image: AssetImage(AssetUtils.bgMlaFollow),fit: BoxFit.fill)

              ),
              tabs: const [
                Tab(text: 'Normal Poster'),
                Tab(text: 'Special Poster'),
              ],
            ),
          ),
        ),

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
                child: Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _tabController, children: [
                            _tabview(posterProvider,0),
                            _tabview(posterProvider,1),
                      ]),
                    )
                  ],
                ),
              ),
              posterProvider.isLoading?const CustomLoader():const SizedBox.shrink()
            ],
          );
        }
      ),
    );
  }

  Widget _tabview(PosterProvidder posterProvider,int type){
    return  Column(
      children: [
        verticalSpace(10),
        Expanded(
          child: ListView.builder(
            itemCount:posterProvider.posterData.length,
            // physics: const NeverScrollableScrollPhysics(), // Prevent scrolling conflict
            shrinkWrap: true, // Wrap ListView
            itemBuilder: (context, index) {
              PosterData p = posterProvider.posterData[index];
              return PosterDataUi(
                  posterData: p,
                  type: type,
                  defaultProfile:posterProvider.defaultProfile!,
                  like: CommonKhandText(
                    title: "${p.likesCount}",
                    textColor:  ColorUtils.colorWhite,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                  share: CommonKhandText(
                    title: "$shareCount",

                    textColor: const Color(0xffffffff),
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                  comment: CommonKhandText(
                    title: "${p.commentsCount}",
                    textColor: const Color(0xffffffff),
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                  likeFunction:()=> _likePost(posterProvider,p,index),
                  commentFunction:()=> _navigateToCommentScreen(p.id.toString(),index),
                  shareFunction: _shareContent
              );
            },
          ),
        ),
      ],
    );
  }
}



