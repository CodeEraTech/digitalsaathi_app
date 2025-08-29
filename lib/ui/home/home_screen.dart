import 'dart:developer';

import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/provider/home_provider.dart';
import 'package:digitalsaathi/ui/home/widgets/ReelModel.dart';
import 'package:digitalsaathi/ui/home/widgets/ReelsCommentModel.dart';
import 'package:digitalsaathi/ui/home/widgets/ReelsViewer.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Consumer<HomeProvider>(
        builder: (context,homeProvider,_) {
          return Stack(
            children: [
              ReelsViewer(
                reelsList: homeProvider.reelsList,
                appbarTitle: '',
                onShare: (String url,int index) {
                  log('Shared reel url ==> $url');
                  homeProvider.downloadFile(url, "Share",index);
                  //homeProvider.posterLike(index);
                },
                onLike: (index) {
                  log('Liked reel url ==> $index');
                  //homeProvider.onLike(0);
                  homeProvider.posterLike(index);
                },
                onFollow: () {
                  log('======> Clicked on follow <======');
                },
                onComment: (int index,String comment) {
                  log('Comment on reel ==> $index');
                  homeProvider.getPosterComments(context,index,"");
                },
                onClickMoreBtn: (int index) {
                  log('======> Clicked on more option <======');
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        title: const Text('Delete Feed'),
                        content: const Text(
                            'Do you want to delete this feed?'),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            child: const Text('Cancel',style: TextStyle(color: ColorUtils.colorBlack)),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          CupertinoDialogAction(
                            child: const Text('Delete',style: TextStyle(color: ColorUtils.errorColor),),
                            onPressed: () async{
                              Navigator.pop(context);
                              homeProvider.deleteFeed(index,context);
                             // openAppSettings();
                            },
                          ),
                        ],
                      ));

                },
                onClickBackArrow: () {
                  log('======> Clicked on back arrow <======');
                },
                onIndexChanged: (index){
                  log('======> Current Index ======> $index <========');
                },
                showProgressIndicator: true,
                showVerifiedTick: true,
                showAppbar: false,
              ),
              homeProvider.isLoading?CustomLoader():SizedBox.shrink()
            ],
          );
        }
      ),
    );
  }
}
