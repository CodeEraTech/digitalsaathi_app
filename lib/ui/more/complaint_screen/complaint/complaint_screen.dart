import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/data/model/complaint_list_response.dart';
import 'package:digitalsaathi/provider/complaint_provider.dart';
import 'package:digitalsaathi/ui/more/complaint_screen/complaint/add_location.dart';
import 'package:digitalsaathi/ui/more/complaint_screen/complaint/raise_complaint.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../constants/components/pro_text.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/color_utils.dart';
import 'package:digitalsaathi/ui/more/complaint_screen/complaint_screen_ui.dart';
import 'package:flutter/material.dart';
import 'complaint_details.dart';

class ComplaintScreen extends StatefulWidget {
  final String createType;
  const ComplaintScreen({super.key,required this.createType});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ComplaintProvider>(context,listen: false).determinePosition(context);
    Provider.of<ComplaintProvider>(context,listen: false).getAllComplaints(widget.createType);
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
          title: widget.createType,
          textColor: Color(0xffffffff),
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  RaiseComplaint(createType: widget.createType,),
                      ),
                    ).then((onValue){
                      if(onValue != null){
                        Provider.of<ComplaintProvider>(context,listen: false).getAllComplaints(widget.createType);
                      }
                    });
                  },
                  child: const Icon(
                    Icons.add,
                    color: ColorUtils.colorWhite,
                    size: 30,
                  )))
        ],
      ),
      body: Consumer<ComplaintProvider>(
        builder: (context,complainProvider,_) {
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
                child:  ListView.builder(
                  itemCount: complainProvider.complainData.length,
                    itemBuilder: (context,index){
                    ComplaintData c = complainProvider.complainData[index];
                  return InkWell(
                    onTap: (){
                      if(c.lat.toString().isEmpty || c.lat.toString() == "0") {
          }else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddLocation(initCoordinates: LatLng(
                                    double.parse("${c.lat ?? 0}"),
                                    double.parse("${c.lat ?? 0}")),
                                  onlyView: true,),
                          ),
                        );
                      }
                    },
                    child: ComplaintScreenUi(
                      cData: c,
                      delete: (){
                      complainProvider.deleteComplaint(c.id.toString(), index);
                      },
                      pendingFunction: (){
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintDetails(),));
                      },
                    ),
                  );
                }),
              ),
              complainProvider.isLoading?const CustomLoader():const SizedBox.shrink()
            ],
          );
        }
      ),
    );
  }
}
