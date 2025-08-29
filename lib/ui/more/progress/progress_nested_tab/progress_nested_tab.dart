import 'package:digitalsaathi/provider/progress_provider.dart';
import 'package:digitalsaathi/ui/more/progress/progress_ui/all_ui.dart';
import 'package:digitalsaathi/ui/more/progress/progress_ui/facebook_ui.dart';
import 'package:digitalsaathi/ui/more/progress/progress_ui/instagram_ui.dart';
import 'package:digitalsaathi/ui/more/progress/progress_ui/other_ui.dart';
import 'package:digitalsaathi/ui/more/progress/progress_ui/poster_ui.dart';
import 'package:digitalsaathi/ui/more/progress/progress_ui/twitter_trend_ui.dart';
import 'package:digitalsaathi/ui/more/progress/progress_ui/twitter_ui.dart';
import 'package:digitalsaathi/ui/more/progress/progress_ui/whatsapp_ui.dart';
import 'package:digitalsaathi/ui/more/progress/progress_ui/youtube_ui.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../provider/theme_provider.dart';
import '../../../../utils/asset_utils.dart';
import '../../../../utils/color_utils.dart';
import '../progress_ui/platform_name_ui.dart';

class ProgressNestedTab extends StatefulWidget {
  const ProgressNestedTab({super.key});

  @override
  State<ProgressNestedTab> createState() => _ProgressNestedTabState();
}

class _ProgressNestedTabState extends State<ProgressNestedTab>with SingleTickerProviderStateMixin {
  late TabController _nestedTabController;
  @override
  void initState() {
    super.initState();
    _nestedTabController = TabController(length: 9, vsync: this);
    Provider.of<ProgressProvider>(context,listen: false).initInitialValue();

  }

  @override
  void dispose() {
    _nestedTabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Consumer<ProgressProvider>(
      builder: (context,progressProvider,_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30,
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.only(top: 3, bottom: 3),
              child: TabBar(
                tabAlignment: TabAlignment.start,
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: true, // Make it not scrollable for equal spacing
                unselectedLabelColor: ColorUtils.colorWhite,
                controller: _nestedTabController,
                dividerHeight: 0,
                labelPadding: const EdgeInsets.symmetric(
                    horizontal: 10), // Add horizontal padding
                labelStyle: GoogleFonts.playfairDisplay(
                  textStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    color: ColorUtils.colorBlack,
                  ),
                ),
                indicator: BoxDecoration(
                  color: ColorUtils.appBarColor,
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
              tabs: progressProvider.socialFilter.map((e) {
                return Tab(
                  height: 30,
                  text: e,
                );
              }).toList(),
              ),
            ),
            verticalSpace(10),
            Expanded(
              child: TabBarView(
                controller: _nestedTabController,
                children: progressProvider.socialFilter.map((val){
                  return AllUi(platFormName: val,);
                }).toList(),
              ),
            ),
          ],
        );
      }
    );
  }
}
