
import 'package:digitalsaathi/model/feedmodel.dart';
import 'package:digitalsaathi/ui/home/widgets/ReelsCommentModel.dart';

class ReelModel {
  final String? id;
  final String url;
  final List<EventPhotos> imageurl;
   bool isLiked;
  final bool isVideo;
   int likeCount;
  final String userName;
  final int userId;
  final String? profileUrl;
  final String? reelDescription;
  final String? musicName;
   List<ReelCommentModel>? commentList;
  ReelModel(this.url,this.userName,this.userId,{this.id,this.isLiked =false,this.likeCount=0,this.profileUrl,this.reelDescription,this.musicName,this.commentList,required this.isVideo,required this.imageurl});
}