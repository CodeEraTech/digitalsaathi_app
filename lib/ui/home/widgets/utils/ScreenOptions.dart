import 'package:digitalsaathi/ui/home/widgets/ReelModel.dart';
import 'package:digitalsaathi/ui/home/widgets/utils/CommentBottomSheet.dart';
import 'package:digitalsaathi/ui/home/widgets/utils/NumerToShort.dart';
import 'package:digitalsaathi/ui/home/widgets/utils/UserProfileImage.dart';
import 'package:digitalsaathi/utils/prefrence/pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ScreenOptions extends StatelessWidget {
  final ReelModel item;
  final bool showVerifiedTick;
  final int position;
  final Function(String,int)? onShare;
  final Function(int)? onLike;
  final Function(int,String)? onComment;
  final Function(int)? onClickMoreBtn;
  final Function()? onFollow;

  const ScreenOptions({
    Key? key,
    required this.item,
    required this.position,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          color: Colors.black38,
          padding: EdgeInsets.fromLTRB(6, 8, 6, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (item.profileUrl != null)
                UserProfileImage(profileUrl: item.profileUrl??''),
              if (item.profileUrl == null)
                const CircleAvatar(
                  child: Icon(Icons.person, size: 18),
                  radius: 16,
                ),
              const SizedBox(width: 6),
              item.reelDescription!.trim() != ''?Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item.userName, style: const TextStyle(color: Colors.white,fontSize: 16)),
                      item.reelDescription!.trim() != ''?const SizedBox(width: 6):SizedBox.shrink(),
                  item.reelDescription!.trim() != ''?ReadMoreText(
                    item.reelDescription ?? '',
                    trimMode: TrimMode.Line,
                    trimLines: 3,
                    colorClickableText: Colors.red,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: TextStyle(color: Colors.blue),
                    style: TextStyle(color: Colors.white,fontSize: 16),
                  ):SizedBox.shrink()

                      // item.reelDescription!.trim() != ''?Text(item.reelDescription ?? '',
                      //     style: const TextStyle(color: Colors.white,),maxLines: 3,overflow: TextOverflow.ellipsis,):SizedBox.shrink(),
                  ],
                ),
              ):Text(item.userName,
    style: const TextStyle(color: Colors.white)),
              const SizedBox(width: 10),
              // if (showVerifiedTick)
              //   const Icon(
              //     Icons.verified,
              //     size: 15,
              //     color: Colors.white,
              //   ),
              // if (showVerifiedTick) const SizedBox(width: 6),
              // if (onFollow != null)
              //   TextButton(
              //     onPressed: onFollow,
              //     child: const Text(
              //       'Follow',
              //       style: TextStyle(
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
        const SizedBox(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 110),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     if (item.profileUrl != null)
                    //       UserProfileImage(profileUrl: item.profileUrl??''),
                    //     if (item.profileUrl == null)
                    //       const CircleAvatar(
                    //         child: Icon(Icons.person, size: 18),
                    //         radius: 16,
                    //       ),
                    //     const SizedBox(width: 6),
                    //     Text(item.userName,
                    //         style: const TextStyle(color: Colors.white)),
                    //     const SizedBox(width: 10),
                    //     if (showVerifiedTick)
                    //       const Icon(
                    //         Icons.verified,
                    //         size: 15,
                    //         color: Colors.white,
                    //       ),
                    //     if (showVerifiedTick) const SizedBox(width: 6),
                    //     if (onFollow != null)
                    //       TextButton(
                    //         onPressed: onFollow,
                    //         child: const Text(
                    //           'Follow',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //           ),
                    //         ),
                    //       ),
                    //   ],
                    // ),
                    // const SizedBox(width: 6),
                    // if (item.reelDescription != null)
                    //   Text(item.reelDescription ?? '',
                    //       style: const TextStyle(color: Colors.white)),
                    // const SizedBox(height: 10),
                    // if (item.musicName != null)
                    //   Row(
                    //     children: [
                    //       const Icon(
                    //         Icons.music_note,
                    //         size: 15,
                    //         color: Colors.white,
                    //       ),
                    //       Text(
                    //         'Original Audio - ${item.musicName}',
                    //         style: const TextStyle(color: Colors.white),
                    //       ),
                    //     ],
                    //   ),
                  ],
                ),
              ),
              Column(
                children: [
                  if (onLike != null && !item.isLiked)
                    IconButton(
                      icon: const Icon(Icons.favorite_outline,
                          color: Colors.white),
                      onPressed: () => onLike!(position),
                    ),
                  if (item.isLiked)
                    IconButton(
                      icon: const Icon(Icons.favorite_rounded,
                          color: Colors.red),
                      onPressed: () => onLike!(position),
                    ),
                   // const Icon(Icons.favorite_rounded, color: Colors.red),
                  Text(NumbersToShort.convertNumToShort(item.likeCount),
                      style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 20),
                  IconButton(
                    icon:
                    const Icon(Icons.comment_rounded, color: Colors.white),
                    onPressed: () {
                      onComment!(position,"");
                      // if(onComment!=null)  {  showModalBottomSheet(
                      //     barrierColor: Colors.transparent,
                      //     context: context,
                      //     builder: (ctx) => CommentBottomSheet(commentList: item.commentList??[],onComment: onComment,position: position,)
                      // );}
                    },
                  ),
                  Text(NumbersToShort.convertNumToShort(item.commentList?.length??0), style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 20),
                  if (onShare != null)
                    InkWell(
                      onTap: () => onShare!(item.url,position),
                      child: Transform(
                        transform: Matrix4.rotationZ(5.8),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  if (onClickMoreBtn != null)
                    Visibility(
                      visible: PrefUtils.getUserId().toString() == item.userId.toString(),
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: ()=>onClickMoreBtn!(position),
                        color: Colors.white,
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
