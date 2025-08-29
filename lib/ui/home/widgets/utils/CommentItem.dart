import 'package:digitalsaathi/ui/home/widgets/ReelsCommentModel.dart';
import 'package:digitalsaathi/ui/home/widgets/utils/UserProfileImage.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:digitalsaathi/utils/date_formatter.dart';
import 'package:digitalsaathi/utils/prefrence/pref_utils.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  final ReelCommentModel commentItem;
  final Function delComment;
  const CommentItem({Key? key, required this.commentItem,required this.delComment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserProfileImage(profileUrl: commentItem.userProfilePic),
              const SizedBox(width: 7),
              Flexible(
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(225, 239, 239, 239),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 5),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  commentItem.userName,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color:
                                    Color.fromARGB(255, 41, 35, 35),
                                  ),
                                ),
                                   SizedBox(width: 10,),
                                Visibility(
                                  visible: PrefUtils.getUserName() == commentItem.userName,
                                  child: InkWell(
                                    onTap: (){
                                      delComment();
                                    },
                                      child: Icon(Icons.delete,color: ColorUtils.errorColor,size: 16,)),
                                )
                              ],
                            ),
                            Text(
                              commentItem.comment,
                              style:  const TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 69, 67, 67),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // ),
            ],
          ),
          const SizedBox(height: 3),
          Padding(
            padding: const EdgeInsets.only(left: 44),
            child: Text(
              DateFormatter.getTimeAgo(commentItem.commentTime),
              style: const TextStyle(
                fontSize: 9,
                color: Color.fromARGB(255, 41, 35, 35),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
