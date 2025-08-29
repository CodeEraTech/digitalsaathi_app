import 'package:card_swiper/card_swiper.dart';
import 'package:chewie/chewie.dart';
import 'package:digitalsaathi/constants/app_url.dart';
import 'package:digitalsaathi/ui/home/widgets/ReelModel.dart';
import 'package:digitalsaathi/ui/home/widgets/utils/LikeIcon.dart';
import 'package:digitalsaathi/ui/home/widgets/utils/ScreenOptions.dart';
import 'package:digitalsaathi/ui/home/widgets/utils/UrlChecker.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelsPage extends StatefulWidget {
  final ReelModel item;
  final bool showVerifiedTick;
  final Function(String,int)? onShare;
  final Function(int)? onLike;
  final Function(int,String)? onComment;
  final Function(int)? onClickMoreBtn;
  final Function()? onFollow;
  final SwiperController swiperController;
  final bool showProgressIndicator;
  final int position;
  const ReelsPage({
    Key? key,
    required this.item,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
    this.showProgressIndicator = true,
    required this.swiperController,
    required this.position,
  }) : super(key: key);

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _liked = false;
  @override
  void initState() {
    super.initState();
    if(widget.item.isVideo) {
      if (!UrlChecker.isImageUrl(widget.item.url) &&
          UrlChecker.isValid(widget.item.url)) {
        initializePlayer();
      }
    }
  }

  Future initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.item.url);
    await Future.wait([_videoPlayerController.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      showControls: false,
      looping: false,
      //aspectRatio: 0.1
    );
    setState(() {});
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.position ==
          _videoPlayerController.value.duration) {
        widget.swiperController.next();
      }
    });
  }
  SwiperController controller = SwiperController();



  @override
  void dispose() {
    controller.dispose();
    // if(_videoPlayerController ) {
    //   _videoPlayerController.dispose();
    // }
    if (_chewieController != null) {
      _chewieController!.dispose();
      _videoPlayerController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.item.isVideo?getVideoView():getImageView();
  }

  Widget getVideoView() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized
            ? FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: GestureDetector(
              onDoubleTap: () {
                if (!widget.item.isLiked) {
                  _liked = true;
                  if (widget.onLike != null) {
                    widget.onLike!(widget.position);
                  }
                  setState(() {});
                }
              },
              child: Chewie(
                controller: _chewieController!,
              ),
            ),
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text('Loading...')
          ],
        ),
        if (_liked)
          const Center(
            child: LikeIcon(),
          ),
        if (widget.showProgressIndicator)
          // Positioned(
          //   bottom: 0,
          //   width: MediaQuery.of(context).size.width,
          //   child: VideoProgressIndicator(
          //     _videoPlayerController,
          //     allowScrubbing: false,
          //     colors: const VideoProgressColors(
          //       backgroundColor: Colors.blueGrey,
          //       bufferedColor: Colors.blueGrey,
          //       playedColor: Colors.blueAccent,
          //     ),
          //   ),
          // ),
        ScreenOptions(
          onClickMoreBtn: widget.onClickMoreBtn,
          onComment: widget.onComment,
          onFollow: widget.onFollow,
          onLike: widget.onLike,
          onShare: widget.onShare,
          showVerifiedTick: widget.showVerifiedTick,
          item: widget.item,
          position: widget.position,
        )
      ],
    );
  }
  Widget getImageView() {
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onDoubleTap: () {
            if (!widget.item.isLiked) {
              _liked = true;
              if (widget.onLike != null) {
                widget.onLike!(widget.position);
              }
              setState(() {});
            }
          },
          child: Container(
            //color: ColorUtils.colorWhite,
          ),
        ),

        if (_liked)
          const Center(
            child: LikeIcon(),
          ),
        //if (widget.showProgressIndicator)
          widget.item.imageurl.isNotEmpty?Container(
           
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    //padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(AppUrl.EVENT_URL+widget.item.imageurl[index].photoName,
                        fit: BoxFit.fitWidth,
                      ),
                    ));
              },
              controller: controller,
              itemCount: widget.item.imageurl.length,
              scrollDirection: Axis.horizontal,
              //onIndexChanged: widget.onIndexChanged,
              autoplay: false,
              loop: false,
              pagination: SwiperPagination(
                //alignment: Alignment.topCenter
                margin: EdgeInsets.all(100)
              ),
              //viewportFraction: 0.7,
             // scale: 0.5,

              control: SwiperControl(color: ColorUtils.errorColor),
            ),
          ):Image.asset(AssetUtils.logoPng,color: ColorUtils.primaryColor.withOpacity(0.1),),
       // widget.item.url.isEmpty?Image.asset(AssetUtils.logoPng):Image.network(widget.item.url),
        ScreenOptions(
          onClickMoreBtn: widget.onClickMoreBtn,
          onComment: widget.onComment,
          onFollow: widget.onFollow,
          onLike: widget.onLike,
          onShare: widget.onShare,
          showVerifiedTick: widget.showVerifiedTick,
          item: widget.item,
          position: widget.position,
        )
      ],
    );
  }
}
