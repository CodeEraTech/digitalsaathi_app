import 'package:digitalsaathi/provider/home_provider.dart';
import 'package:digitalsaathi/ui/home/widgets/ReelsCommentModel.dart';
import 'package:digitalsaathi/ui/home/widgets/utils/CommentItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentBottomSheet extends StatefulWidget {
  final List<ReelCommentModel> commentList;
  final int position;
  const CommentBottomSheet({Key? key, required this.commentList,required this.position})
      : super(key: key);

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final commentController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context,homeProvider,_) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            color: Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Text(
                  'Comments',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              if (widget.commentList.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    itemCount: widget.commentList.length,
                    itemBuilder: (ctx, i) =>
                        CommentItem(
                          delComment: (){
                            homeProvider.deleteComment(context, widget.commentList[i].id.toString(),widget.position);
                          },
                            commentItem: widget.commentList[i]),
                  ),
                ),
              if (widget.commentList.isEmpty)
                const Expanded(
                    child: Center(
                      child: Text('No Comments yet.'),
                    )),
              const Divider(),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    contentPadding: const EdgeInsets.all(10),
                    border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    suffixIcon: InkWell(onTap: () {
                      homeProvider.postComment(context, widget.position, commentController.text);
                      // if(widget.onComment!=null){
                      //   String comment = commentController.text;
                      //   widget.onComment!(widget.position,comment);
                      // }
                      //Navigator.pop(context);
                    }, child: const Icon(Icons.send)),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
