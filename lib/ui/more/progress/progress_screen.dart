import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/constants/components/my_TextField.dart';
import 'package:digitalsaathi/provider/progress_provider.dart';
import 'package:digitalsaathi/ui/more/progress/progress_nested_tab/progress_nested_tab.dart';
import 'package:digitalsaathi/ui/more/progress/progress_ui/all_ui.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../constants/components/pro_text.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import '../../../provider/theme_provider.dart';
import '../../../utils/color_utils.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  bool _isIconVisible = true;
  bool _isSearchFieldVisible = false; // Track visibility of the text widget


  @override
  void initState() {
    super.initState();
    _tabController =TabController(length: 2, vsync: this); // Initialize the TabController
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
        title:  CommonKhandText(
          title: "Worker Progress",
          textColor:themeProvider.darkTheme ?  ColorUtils.colorWhite: ColorUtils.colorWhite,
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(34),
          child: Container(
            width: double.infinity,
            height: 35,
            margin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.only(top: 3, bottom: 3),
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: false, // Make it not scrollable for equal spacing
              unselectedLabelColor:ColorUtils.colorWhite,
              controller: _tabController,
              dividerHeight: 0,
              labelPadding: const EdgeInsets.symmetric(
                  horizontal: 20), // Add horizontal padding
              labelStyle: GoogleFonts.playfairDisplay(
                textStyle:  const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                   color: ColorUtils.colorBlack,
                ),
              ),
              indicator: BoxDecoration(
                  // color: ColorUtils.appBarColor,
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      themeProvider.darkTheme ? Color.fromRGBO(6, 108, 219, 0.8897934173669468):Color.fromRGBO(6, 108, 219, 0.8897934173669468),
                      themeProvider.darkTheme ? Color.fromRGBO(216, 222, 218, 1):Color.fromRGBO(216, 222, 218, 1),
                    ],
                    stops: const [0.0, 1.0], // Stops to match 0% and 100%
                  ),
              ),
              tabs: const [
                Tab(text: 'Social'),
                Tab(text: 'All'),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child:GestureDetector(
              onTap: () {
                setState(() {
                  _isIconVisible = !_isIconVisible; // Toggle the state
                  _isSearchFieldVisible = !_isIconVisible;
                });
              },
              child: _isIconVisible ?
              const Icon(
                Icons.filter_alt_outlined,
                color: Colors.white,
              ) : const CommonKhandText(
                title: "Close",
                textColor: Color(0xffffffff),
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            )
          ),
        ],
      ),
      body: Consumer<ProgressProvider>(
        builder: (context,progressProvider,_) {
          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  height: screenHeight(context),
                  width: screenWidth(context),
                  padding: const EdgeInsets.all(10),
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
                  child: TabBarView(
                      controller: _tabController,
                      children:  [
                        const ProgressNestedTab(),
                        AllUi(
                          platFormName: "",
                          isAll: true,

                        )
                      ]
                  ),
                ),
              ),

              progressProvider.isLoading?const CustomLoader():const SizedBox.shrink()
            ],
          );
        }
      ),
    );
  }
}
