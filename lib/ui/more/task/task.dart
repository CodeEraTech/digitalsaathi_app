import 'dart:convert';
import 'dart:developer';
import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/constants/components/pro_text.dart';
import 'package:digitalsaathi/provider/task_provider.dart';
import 'package:digitalsaathi/ui/more/task/task_data/task_list_tab_view.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../provider/theme_provider.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/color_utils.dart';

class TaskScreen extends StatefulWidget {
  final int initialTabIndex;
  const TaskScreen({super.key,required this.initialTabIndex});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  bool chipAllSelected = false;
  Color chipDefaultColor = const Color(0xffEBE0FF);
  Color chipSelectedColor = const Color(0xffF1f3d99);
  Color chipBorderColor = Colors.black;
  TabController? _tabController;

  // selected chip data
  List<String> selectedChipValue = [];

  // click the confirm button the open dialog select yes or no button.
  bool isYesSelected = false;
  bool isNoSelected = false;

  //  chip
  void toggleAll(int tabType) {
    setState(() {
      if (!chipAllSelected) {
        chipAllSelected = true;
       // selectedChipValue = ['Instagram', 'Facebook', 'Whatsapp', 'Twitter'];
      }
      // else {
      //   chipAllSelected = false;
      //   selectedChipValue.clear();
      // }
      Provider.of<TaskProvider>(context,listen: false).filterTask(tabType, []);

    });
  }

  void selectChip(String title,int tabType) {
    setState(() {
      if (selectedChipValue.contains(title)) {
        selectedChipValue.remove(title);
      } else {
        selectedChipValue.add(title);
        chipAllSelected = false; // Deselect 'All'
      }
    });

    Provider.of<TaskProvider>(context,listen: false).filterTask(tabType, selectedChipValue);
  }

  Color getChipColor(String title) {
    if (chipAllSelected) {
      return chipSelectedColor;
    } else if (selectedChipValue.contains(title)) {
      return chipSelectedColor;
    } else {
      return chipDefaultColor;
    }
  }

  Color getTextColor(String title) {
    return (chipAllSelected || selectedChipValue.contains(title))
        ? Colors.white
        : Colors.black;
  }

  List<String> assemblyData = ['Task 1', 'Task 2', 'Task 3'];


  @override
  void initState() {
    super.initState();
    init();
    // _tabController = TabController(length: 4, vsync: this,initialIndex: 0);



  }

  init(){
    print("index :: ${widget.initialTabIndex}");
    Provider.of<TaskProvider>(context, listen: false).initialIndex = widget.initialTabIndex==0?0:widget.initialTabIndex==5?0:widget.initialTabIndex==6?1:widget.initialTabIndex==7?2:3;
    Provider.of<TaskProvider>(context, listen: false).getAllTask().then((val){
      _tabController = TabController(length: 4, vsync: this,initialIndex:  widget.initialTabIndex==0?0:widget.initialTabIndex==5?0:widget.initialTabIndex==6?1:widget.initialTabIndex==7?2:3);
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    if(_tabController != null) {
      _tabController!.dispose();
    }
    super.dispose();
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
          title: "Task",
          textColor: Color(0xffffffff),
          fontWeight: FontWeight.w300,
          fontSize: 18,
        ),
        bottom: _tabController != null?PreferredSize(
          preferredSize: const Size.fromHeight(35),
          child: Container(
            height: 35,
            margin: const EdgeInsets.only(bottom: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: TabBar(

              indicatorSize: TabBarIndicatorSize.tab,
              dividerHeight: 0,
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              unselectedLabelColor: themeProvider.darkTheme
                  ? ColorUtils.colorWhite
                  : ColorUtils.colorBlack,
              controller: _tabController,
              labelStyle: GoogleFonts.playfairDisplay(
                  textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: themeProvider.darkTheme
                    ? ColorUtils.colorBlack
                    : ColorUtils.colorWhite,
              )),
              indicator: BoxDecoration(
                color: const Color(0xff000080),
                borderRadius: BorderRadius.circular(5),
                // image: const DecorationImage(
                //     image: AssetImage(AssetUtils.bgMlaFollow),
                //     fit: BoxFit.fill
                // )
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    themeProvider.darkTheme
                        ? Color.fromRGBO(6, 108, 219, 0.8897934173669468)
                        : Color.fromRGBO(6, 108, 219, 0.8897934173669468),
                    themeProvider.darkTheme
                        ? Color.fromRGBO(216, 222, 218, 1)
                        : Color.fromRGBO(216, 222, 218, 1),
                  ],
                  stops: const [0.0, 1.0], // Stops to match 0% and 100%
                ),
              ),
              tabs: const [
                Tab(text: 'National'),
                Tab(text: 'State'),
                Tab(text: 'District/Parliament'),
                Tab(text: 'Assembly/Block'),
              ],
            ),
          ),
        ):PreferredSize(preferredSize: const Size.fromHeight(35), child: SizedBox.shrink()),
      ),
      body: Consumer<TaskProvider>(builder: (context, taskProvider, _) {
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
              child: _tabController != null?Column(
                children: [

                  Expanded(
                    child: TabBarView(
                        // physics: const NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: [
                          Column(
                            children: [
                              getChipWidget(0),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: List.generate(
                                        taskProvider.nationalTaskList.length,
                                        (index) {
                                      return TaskListTabView(
                                        taskData:
                                            taskProvider.nationalTaskList[index],
                                        navigateTo: (String value) async {
                                          // log(assemblyData[index]);
                                          if (taskProvider
                                              .nationalTaskList[index].showDone==1) {
                                            _showDialog(
                                                context,
                                                taskProvider,
                                                value,
                                                index,
                                                taskProvider
                                                    .nationalTaskList[index].taskListId.toString(),
                                                1);
                                            // taskProvider.markTaskDone(
                                            //     value, taskProvider.nationalTaskList[index].id.toString());
                                          } else {
                                        if (value == "WHATSAPP") {
                                        bool status =
                                        await taskProvider.downloadFile(
                                        taskProvider
                                            .nationalTaskList[index]
                                            .postMedia,
                                        taskProvider
                                            .nationalTaskList[index]
                                            .postMessage);
                                        if (status) {
                                        taskProvider.postSocialPoint(
                                        value,
                                        taskProvider
                                            .nationalTaskList[index].taskListId
                                            .toString(),
                                        index,
                                        1);
                                        }
                                        }
                                        else {
                                         bool status = false;
                                          if(taskProvider.nationalTaskList[index].postType.toString().isEmpty) {
                                            if(taskProvider
                                                .nationalTaskList[index]
                                                .postLink.toString().contains("http")) {
                                              status = await launchUrl(
                                                  Uri.parse(
                                                      taskProvider
                                                          .nationalTaskList[index]
                                                          .postLink));
                                            }else{
                                              status = await launchUrl(Uri.parse("https://twitter.com/intent/tweet?text=${taskProvider
                                                  .nationalTaskList[index]
                                                  .postMessage}"));
                                            }
                                          }else{
                                            String url = jsonDecode(taskProvider.nationalTaskList[index].postType)["task"]??"";
                                            if(url.isNotEmpty){
                                               status = await launchUrl(
                                                  Uri.parse(
                                                      url));
                                            }else{
                                              status = await launchUrl(Uri.parse("https://twitter.com/intent/tweet?text=${taskProvider
                                                  .nationalTaskList[index]
                                                  .postMessage}"));
                                            }
                                          }
                                          if (status) {
                                            taskProvider.postSocialPoint(
                                                value,
                                                taskProvider
                                                    .nationalTaskList[index].taskListId
                                                    .toString(),
                                                index,
                                                1);
                                          }
                                        }
                                          }
                                        },
                                        viewOnly: (String value) async {


                                         bool status = false;
                                          if(taskProvider.nationalTaskList[index].postType.toString().isEmpty) {
                                            if(taskProvider
                                                .nationalTaskList[index]
                                                .postLink.toString().contains("http")) {
                                              status = await launchUrl(
                                                  Uri.parse(
                                                      taskProvider
                                                          .nationalTaskList[index]
                                                          .postLink));
                                            }else{
                                              status = await launchUrl(Uri.parse("https://twitter.com/intent/tweet?text=${taskProvider
                                                  .nationalTaskList[index]
                                                  .postMessage}"));
                                            }
                                          }else{
                                            String url = jsonDecode(taskProvider.nationalTaskList[index].postType)["task"]??"";
                                            if(url.isNotEmpty){
                                               status = await launchUrl(
                                                  Uri.parse(
                                                      url));
                                            }else{
                                              status = await launchUrl(Uri.parse("https://twitter.com/intent/tweet?text=${taskProvider
                                                  .nationalTaskList[index]
                                                  .postMessage}"));
                                            }
                                          }



                                        },
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              getChipWidget(1),

                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: List.generate(
                                        taskProvider.stateTaskList.length, (index) {
                                      return TaskListTabView(
                                        taskData: taskProvider.stateTaskList[index],
                                        navigateTo: (String value) async {
                                          if (taskProvider
                                              .stateTaskList[index].showDone==1) {
                                            _showDialog(
                                                context,
                                                taskProvider,
                                                value,
                                                index,
                                                taskProvider.stateTaskList[index].taskListId
                                                    .toString(),
                                                2);
                                            // taskProvider.markTaskDone(
                                            //     value, taskProvider.nationalTaskList[index].id.toString());
                                          } else {
                                        if (value == "WHATSAPP") {
                                        bool status =
                                        await taskProvider.downloadFile(
                                        taskProvider
                                            .stateTaskList[index]
                                            .postMedia,
                                        taskProvider
                                            .stateTaskList[index]
                                            .postMessage);
                                        if (status) {
                                        taskProvider.postSocialPoint(
                                        value,
                                        taskProvider
                                            .stateTaskList[index].taskListId
                                            .toString(),
                                        index,
                                        2);
                                        }
                                        } else {
                                          bool status = false;
                                          if(taskProvider.stateTaskList[index].postType.toString().isEmpty) {
                                            if(taskProvider
                                                .stateTaskList[index]
                                                .postLink.toString().contains("http")) {
                                              status = await launchUrl(
                                                  Uri.parse(
                                                      taskProvider
                                                          .stateTaskList[index]
                                                          .postLink));
                                            }else{
                                              status = await launchUrl(Uri.parse("https://twitter.com/intent/tweet?text=${taskProvider
                                                  .stateTaskList[index]
                                                  .postMessage}"));
                                            }
                                          }else{
                                            String url = jsonDecode(taskProvider.stateTaskList[index].postType)["task"]??"";
                                            if(url.isNotEmpty){
                                              status = await launchUrl(
                                                  Uri.parse(
                                                      url));
                                            }else{
                                              status = await launchUrl(Uri.parse("https://twitter.com/intent/tweet?text=${taskProvider
                                                  .stateTaskList[index]
                                                  .postMessage}"));
                                            }
                                          }
                                          if (status) {
                                            taskProvider.postSocialPoint(
                                                value,
                                                taskProvider.stateTaskList[index].taskListId
                                                    .toString(),
                                                index,
                                                2);
                                          }
                                        }
                                          }
                                        },
                                        viewOnly: (String value) async {


                                          bool status = false;
                                          if(taskProvider.stateTaskList[index].postType.toString().isEmpty) {
                                            if(taskProvider
                                                .stateTaskList[index]
                                                .postLink.toString().contains("http")) {
                                              status = await launchUrl(
                                                  Uri.parse(
                                                      taskProvider
                                                          .stateTaskList[index]
                                                          .postLink));
                                            }else{
                                              status = await launchUrl(Uri.parse("https://twitter.com/intent/tweet?text=${taskProvider
                                                  .stateTaskList[index]
                                                  .postMessage}"));
                                            }
                                          }else{
                                            String url = jsonDecode(taskProvider.stateTaskList[index].postType)["task"]??"";
                                            if(url.isNotEmpty){
                                              status = await launchUrl(
                                                  Uri.parse(
                                                      url));
                                            }else{
                                              status = await launchUrl(Uri.parse("https://twitter.com/intent/tweet?text=${taskProvider
                                                  .stateTaskList[index]
                                                  .postMessage}"));
                                            }
                                          }



                                        },

                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              getChipWidget(2),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: List.generate(
                                        taskProvider.districttTaskList.length,
                                        (index) {
                                      return TaskListTabView(
                                        taskData:
                                            taskProvider.districttTaskList[index],
                                        navigateTo: (String value) async {
                                          if (taskProvider
                                              .districttTaskList[index].showDone==1) {
                                            _showDialog(
                                                context,
                                                taskProvider,
                                                value,
                                                index,
                                                taskProvider
                                                    .districttTaskList[index].taskListId
                                                    .toString(),
                                                3);
                                            // taskProvider.markTaskDone(
                                            //     value, taskProvider.nationalTaskList[index].id.toString());
                                          } else {
                                        if (value == "WHATSAPP") {
                                        bool status =
                                        await taskProvider.downloadFile(
                                        taskProvider
                                            .districttTaskList[index]
                                            .postMedia,
                                        taskProvider
                                            .districttTaskList[index]
                                            .postMessage);
                                        if (status) {
                                        taskProvider.postSocialPoint(
                                        value,
                                        taskProvider
                                            .districttTaskList[index].taskListId
                                            .toString(),
                                        index,
                                        3);
                                        }
                                        } else {
                                          bool status = false;
                                          if(taskProvider.districttTaskList[index].postType.toString().isEmpty) {
                                            if(taskProvider
                                                .districttTaskList[index]
                                                .postLink.toString().contains("http")) {
                                              status = await launchUrl(
                                                  Uri.parse(
                                                      taskProvider
                                                          .districttTaskList[index]
                                                          .postLink));
                                            }else{
                                              status = await launchUrl(Uri.parse("https://twitter.com/intent/tweet?text=${taskProvider
                                                  .districttTaskList[index]
                                                  .postMessage}"));
                                            }
                                          }else{
                                            String url = jsonDecode(taskProvider.districttTaskList[index].postType)["task"]??"";
                                            if(url.isNotEmpty){
                                              status = await launchUrl(
                                                  Uri.parse(
                                                      url));
                                            }else{
                                              status = await launchUrl(Uri.parse("https://twitter.com/intent/tweet?text=${taskProvider
                                                  .districttTaskList[index]
                                                  .postMessage}"));
                                            }
                                          }
                                          // Share.share(taskProvider.districttTaskList[index].postMessage.isEmpty?taskProvider.districttTaskList[index].postLink:taskProvider.districttTaskList[index].postMessage);
                                          if (status) {
                                            taskProvider.postSocialPoint(
                                                value,
                                                taskProvider
                                                    .districttTaskList[index].taskListId
                                                    .toString(),
                                                index,
                                                3);
                                          }
                                        }
                                          }
                                        },
                                        viewOnly: (String value) async {


                                          bool status = false;
                                          if(taskProvider.districttTaskList[index].postType.toString().isEmpty) {
                                            if(taskProvider
                                                .districttTaskList[index]
                                                .postLink.toString().contains("http")) {
                                              status = await launchUrl(
                                                  Uri.parse(
                                                      taskProvider
                                                          .districttTaskList[index]
                                                          .postLink));
                                            }else{
                                              status = await launchUrl(Uri.parse("https://twitter.com/intent/tweet?text=${taskProvider
                                                  .districttTaskList[index]
                                                  .postMessage}"));
                                            }
                                          }else{
                                            String url = jsonDecode(taskProvider.districttTaskList[index].postType)["task"]??"";
                                            if(url.isNotEmpty){
                                              status = await launchUrl(
                                                  Uri.parse(
                                                      url));
                                            }else{
                                              status = await launchUrl(Uri.parse("https://twitter.com/intent/tweet?text=${taskProvider
                                                  .districttTaskList[index]
                                                  .postMessage}"));
                                            }
                                          }



                                        },

                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              getChipWidget(3),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: List.generate(
                                        taskProvider.blockTaskList.length, (index) {
                                      return TaskListTabView(
                                        taskData: taskProvider.blockTaskList[index],
                                        navigateTo: (String value) async {
                                          // log(assemblyData[index]);
                                          // _showDialog(context, index);
                                          if (taskProvider
                                              .blockTaskList[index].showDone==1) {
                                            _showDialog(
                                                context,
                                                taskProvider,
                                                value,
                                                index,
                                                taskProvider.blockTaskList[index].taskListId
                                                    .toString(),
                                                4);
                                          } else {
                                            if (value == "WHATSAPP") {
                                              bool status =
                                                  await taskProvider.downloadFile(
                                                      taskProvider
                                                          .blockTaskList[index]
                                                          .postMedia,
                                                      taskProvider
                                                          .blockTaskList[index]
                                                          .postMessage);
                                              if (status) {
                                                taskProvider.postSocialPoint(
                                                    value,
                                                    taskProvider
                                                        .blockTaskList[index].taskListId
                                                        .toString(),
                                                    index,
                                                    4);
                                              }
                                            } else {
                                              bool status = false;
                                              print("Post Type ${taskProvider.blockTaskList[index].postType}");
                                              if(taskProvider.blockTaskList[index].postType.toString().isEmpty) {
                                                if(taskProvider
                                                    .blockTaskList[index]
                                                    .postLink.toString().contains("http")) {
                                                  status = await launchUrl(
                                                      Uri.parse(
                                                          taskProvider
                                                              .blockTaskList[index]
                                                              .postLink));
                                                }else{
                                                  status = await launchUrl(Uri.parse("https://twitter.com/intent/tweet?text=${taskProvider
                                                      .blockTaskList[index]
                                                      .postMessage}"));
                                                }
                                              }else{
                                                String url = jsonDecode(taskProvider.blockTaskList[index].postType)["task"]??"";
                                                if(url.isNotEmpty){
                                                  status = await launchUrl(
                                                      Uri.parse(
                                                          url));
                                                }else{
                                                  status = await launchUrl(Uri.parse("https://twitter.com/intent/tweet?text=${taskProvider
                                                      .blockTaskList[index]
                                                      .postMessage}"));
                                                }
                                              }
                                              if (status) {
                                                taskProvider.postSocialPoint(
                                                    value,
                                                    taskProvider
                                                        .blockTaskList[index].taskListId
                                                        .toString(),
                                                    index,
                                                    4);
                                              }
                                            }
                                            // Share.share(taskProvider.blockTaskList[index].postMessage.isEmpty?taskProvider.blockTaskList[index].postLink:taskProvider.blockTaskList[index].postMessage);
                                            // taskProvider.postSocialPoint(
                                            //     value, taskProvider.blockTaskList[index].id.toString(),index,4);
                                          }
                                        },
                                        viewOnly: (String value) async {


                                          bool status = false;
                                          if(taskProvider.blockTaskList[index].postType.toString().isEmpty) {
                                            if(taskProvider
                                                .blockTaskList[index]
                                                .postLink.toString().contains("http")) {
                                              status = await launchUrl(
                                                  Uri.parse(
                                                      taskProvider
                                                          .blockTaskList[index]
                                                          .postLink));
                                            }else{
                                              status = await launchUrl(Uri.parse("https://twitter.com/intent/tweet?text=${taskProvider
                                                  .blockTaskList[index]
                                                  .postMessage}"));
                                            }
                                          }else{
                                            String url = jsonDecode(taskProvider.blockTaskList[index].postType)["task"]??"";
                                            if(url.isNotEmpty){
                                              status = await launchUrl(
                                                  Uri.parse(
                                                      url));
                                            }else{
                                              status = await launchUrl(Uri.parse("https://twitter.com/intent/tweet?text=${taskProvider
                                                  .blockTaskList[index]
                                                  .postMessage}"));
                                            }
                                          }



                                        },

                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                  )
                ],
              ):SizedBox.shrink(),
            ),
            taskProvider.isLoading
                ? const CustomLoader()
                : const SizedBox.shrink()
          ],
        );
      }),
    );
  }

  void _showDialog(BuildContext context, TaskProvider taskProvider, String type,
      int index, String id, int workerType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final themeProvider = Provider.of<DarkThemeProvider>(context);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          title: CommonKhandText(
            title:
                "Are you sure you have shared this task? If you click yes, the task will be removed from the list and your score will be increased after review.",
            fontWeight: FontWeight.w300,
            textColor: themeProvider.darkTheme
                ? ColorUtils.colorWhite
                : ColorUtils.colorBlack,
            fontSize: 17,
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
                        // color:isNoSelected? Colors.yellow:Colors.grey,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(9, 9, 9, 1)
                                : const Color.fromRGBO(
                                    6, 108, 219, 0.8897934173669468),
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(63, 61, 61, 1)
                                : const Color.fromRGBO(216, 222, 218, 1),
                          ],
                          stops: const [0.0, 1.0], // Stops to match 0% and 100%
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: CommonKhandText(
                          title: "No",
                          fontWeight: FontWeight.w300,
                          textColor: themeProvider.darkTheme
                              ? ColorUtils.colorWhite
                              : ColorUtils.colorBlack,
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
                      Navigator.of(context).pop();
                      taskProvider.markTaskDone(type, id, index,
                          workerType); // Close dialog after removal
                    },
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        // color:isYesSelected? Colors.yellow:Colors.grey,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(9, 9, 9, 1)
                                : const Color.fromRGBO(
                                    6, 108, 219, 0.8897934173669468),
                            themeProvider.darkTheme
                                ? const Color.fromRGBO(63, 61, 61, 1)
                                : const Color.fromRGBO(216, 222, 218, 1),
                          ],
                          stops: const [0.0, 1.0], // Stops to match 0% and 100%
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: CommonKhandText(
                          title: "Yes",
                          fontWeight: FontWeight.w300,
                          textColor: themeProvider.darkTheme
                              ? ColorUtils.colorWhite
                              : ColorUtils.colorBlack,
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

  Widget getChipWidget(int tab){
    List<String> titles = [
      "All",
      "YOUTUBE",
      "TWITTER",
      "FACEBOOK",
      "INSTAGRAM",
      "WHATSAPP",
      "TWITTERTREND",
      "OTHER",
    ];
    return  Container(
      height: 35,
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: screenWidth(context),
      // color: Colors.white.withOpacity(0.2),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: titles.map((title) {
            return GestureDetector(
              onTap: () {
                if (title == "All") {
                  toggleAll(tab);
                }
                else {
                  selectChip(title,tab);
                }
              },
              child: Container(
                height: 25,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 6),
                padding: const EdgeInsets.only(
                    right: 8, left: 8, bottom: 4),
                decoration: BoxDecoration(
                  color: getChipColor(title),
                  border: Border.all(
                      color: chipBorderColor, width: 0.5),
                  borderRadius:
                  const BorderRadius.all(Radius.circular(5)),
                ),
                child: Center(
                  child: CommonKhandText(
                    title: title,
                    textColor: getTextColor(title),
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
