import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/Api_Services/api_services.dart';
import '../../../constants/components/pro_text.dart';
import '../../../provider/theme_provider.dart';
import '../../../utils/color_utils.dart';
import '../../authentication_screen/Pdf_viewer.dart';

class NewsLetterScreen extends StatefulWidget {
  const NewsLetterScreen({super.key});

  @override
  State<NewsLetterScreen> createState() => _NewsLetterScreenState();
}

class _NewsLetterScreenState extends State<NewsLetterScreen> {
  List<String> pdfLinks = [];
  String? selectedPdfUrl;
  final ApiServices apiServices = ApiServices();

  @override
  void initState() {
    super.initState();
    fetchNewsLetter();
  }

  Future<void> fetchNewsLetter() async {
    try {
      final links = await apiServices.fetchNewsLetter();
      setState(() {
        pdfLinks = links;
        if (pdfLinks.isNotEmpty) {
          selectedPdfUrl = pdfLinks[0]; // Show the first PDF by default
        }
      });
    } catch (e) {
      print('Error fetching pdf links: $e');
    }
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
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: const CommonKhandText(
          title: "NEWS LETTER",
          textColor: Color(0xffffffff),
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),
      ),
      body:SizedBox(
        height: screenHeight(context),
        width: screenWidth(context),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: pdfLinks.map((url) => PdfViewer(url: url)).toList(),),

        ),
      )
    );
  }
}

