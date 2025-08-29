import 'package:digitalsaathi/constants/components/loader.dart';
import 'package:digitalsaathi/provider/content_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../../constants/Api_Services/api_services.dart';
import '../../../constants/components/pro_text.dart';
import '../../../data/model/content_post_model.dart';
import '../../../provider/theme_provider.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/color_utils.dart';

class VideoCreativeContent extends StatefulWidget {
  const VideoCreativeContent({super.key});

  @override
  State<VideoCreativeContent> createState() => _VideoCreativeContentState();
}

class _VideoCreativeContentState extends State<VideoCreativeContent> {
  VideoPlayerController? _controller;
  double _currentPosition = 0.0;
  double _totalDuration = 1.0;
  int currentIndex = 0;



  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _controller?.dispose();
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
            color: Colors.black.withOpacity(0.2),
            shape: BoxShape.circle,
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
        title: const CommonKhandText(
          title: "Creative Content",
          textColor: Color(0xffffffff),
          fontWeight: FontWeight.w300,
          fontSize: 16,
        ),
      ),
      body: Consumer<ContentProvider>(
        builder: (context,contentProvider,_) {
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
                      Color(0xFF000000),
                      Color(0xFF3F3D3D),
                      Color(0xFF606060),
                    ],
                  ),
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      height: screenHeight(context),
                      width: screenWidth(context),
                      child: Center(
                        child: _controller != null && _controller!.value.isInitialized
                            ? AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: VideoPlayer(_controller!),
                        )
                            : const Center(child: CircularProgressIndicator(color: Colors.blue,)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Slider(
                            activeColor: Colors.blue,
                            value: _currentPosition,
                            min: 0,
                            max: _totalDuration,
                            onChanged: (value) {
                              setState(() {
                                _currentPosition = value;
                              });
                            },
                            onChangeEnd: _onSliderChanged,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: _skipToPrevious,
                                child: Icon(
                                  Icons.skip_previous,
                                  color: Colors.black,
                                  size: 35,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (_controller != null) {
                                      _controller!.value.isPlaying
                                          ? _controller!.pause()
                                          : _controller!.play();
                                    }
                                  });
                                },
                                child: Icon(
                                  _controller?.value.isPlaying == true
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.black,
                                  size: 40,
                                ),
                              ),
                              GestureDetector(
                                onTap: _skipToNext,
                                child: Icon(
                                  Icons.skip_next,
                                  color: Colors.black,
                                  size: 35,
                                ),)
                            ],
                          )
                        ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        alignment: Alignment.bottomRight,
                        margin: EdgeInsets.only(top: 6,right: 8),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: (){
                                contentProvider.shareContentInit(contentProvider.videoContent[currentIndex].postUrl ?? '', "${contentProvider.videoContent[currentIndex].id}",currentIndex,"video");
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: ColorUtils.colorWhite,
                                 // shape: BoxShape.circle
                                ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.screen_share,color: ColorUtils.colorBlack),
                                      Text(contentProvider.videoContent[currentIndex].share.toString())
                                    ],
                                  )),
                            ),
                            verticalSpace(6),
                            InkWell(
                              onTap: (){
                                contentProvider.downloadImage(contentProvider.videoContent[currentIndex].postUrl ?? '', "${contentProvider.videoContent[currentIndex].id}",currentIndex,"video");

                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: ColorUtils.colorWhite,
                                ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.download,color: ColorUtils.colorBlack),
                                      Text(contentProvider.videoContent[currentIndex].download.toString())

                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              contentProvider.isLoading?CustomLoader():SizedBox.shrink()
            ],
          );
        }
      ),
    );
  }

  Future<void> initData() async {
    List<ContentData> video = Provider.of<ContentProvider>(context,listen: false).videoContent;
    if(video.isNotEmpty){
      if(video.first.postUrl != null){
        _initializeVideoPlayer(video.first.postUrl);
      }
    }

    setState(() {});
  }

  void _initializeVideoPlayer(String? videoUrl) {
    if (videoUrl != null) {
      _controller = VideoPlayerController.network(videoUrl)
        ..initialize().then((_) {
          setState(() {
            _totalDuration = _controller!.value.duration.inSeconds.toDouble();
            _controller!.play();
          });
        }).catchError((error) {
          print("Error initializing video player: $error");
        });

      _controller!.addListener(() {
        if (_controller!.value.hasError) {
          print("Video player error: ${_controller!.value.errorDescription}");
        } else {
          setState(() {
            _currentPosition = _controller!.value.position.inSeconds.toDouble();
          });
        }
      });
    }
  }

  void _onSliderChanged(double value) {
    if (_controller != null) {
      final newPosition = Duration(seconds: value.toInt());
      _controller!.seekTo(newPosition);
    }
  }

  void _skipToPrevious() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        _initializeVideoPlayer(Provider.of<ContentProvider>(context,listen: false).videoContent[currentIndex].postUrl);
      });
    }
  }

  void _skipToNext() {
    if (currentIndex < Provider.of<ContentProvider>(context,listen: false).videoContent.length - 1) {
      setState(() {
        currentIndex++;
        _initializeVideoPlayer(Provider.of<ContentProvider>(context,listen: false).videoContent[currentIndex].postUrl);
      });
    }
  }

}
