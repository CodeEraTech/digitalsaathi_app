// import 'dart:developer';
// import 'dart:io';
// import 'package:digitalsaathi/constants/components/pro_text.dart';
// import 'package:digitalsaathi/ui/more/chat_screen/chat_screen_image_see.dart';
// import 'package:digitalsaathi/utils/app_utils.dart';
// import 'package:digitalsaathi/utils/asset_utils.dart';
// import 'package:digitalsaathi/utils/color_utils.dart';
// import 'package:digitalsaathi/utils/prefrence/pref_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'chatModel/chat_message.dart';
// import 'chat_controller/chat_controller.dart';
// import 'chat_socket_services/socket_service.dart';
//
// class ChatScreen extends StatefulWidget {
//   final String chattingWithUserId;
//   final String userName ;
//   const ChatScreen({super.key,required this.chattingWithUserId, required this.userName});
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//
//   final TextEditingController _controller = TextEditingController();
//   late SocketService _socketService;
//   final ChatController chatController = Get.put(ChatController());
//   final ScrollController _scrollController = ScrollController();
//
//
//   void _setupSocket() {
//     _socketService = SocketService(userId: PrefUtils.getUserId());
//     _socketService.connect();
//
//     _socketService.onMessageReceived((msg) {
//       if ((msg.fromUserId == widget.chattingWithUserId && msg.toUserId ==  PrefUtils.getUserId()) ||
//           (msg.fromUserId ==  PrefUtils.getUserId() && msg.toUserId == widget.chattingWithUserId)) {
//         chatController.addMessage(msg);
//       }
//     });
//   }
//
//   Future<void> _sendMessage() async {
//     final String messageText = _controller.text.trim();
//
//     if (messageText.isEmpty && _selectedImagePath == null) {
//       // Don't send empty messages with no image
//       return;
//     }
//
//     final ChatMessageModel chatMsg = ChatMessageModel(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       fromUserId: PrefUtils.getUserId(),
//       toUserId: widget.chattingWithUserId,
//       message: messageText,
//       timestamp: DateTime.now(),
//       image: _selectedImagePath,
//     );
//
//     _socketService.sendMessage(chatMsg);
//     chatController.addMessage(chatMsg);
//
//     _controller.clear();
//     setState(() {
//       _selectedImagePath = null;
//     });
//   }
//
//   void _editMessage(ChatMessageModel msg, BuildContext context) {
//     final editController = TextEditingController(text: msg.message);
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         alignment: Alignment.bottomCenter,
//         insetPadding:  EdgeInsets.zero,
//         backgroundColor: ColorUtils.colorWhite,
//         surfaceTintColor: ColorUtils.colorWhite,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Container(width: 20,),
//             const CommonKhandText(title: 'Edit Message',textColor: ColorUtils.colorBlack,fontSize: 14,fontWeight: FontWeight.w500,),
//              InkWell(
//                  onTap: (){Navigator.pop(context);},
//                  child: CommonKhandText(title: 'Cancel',textColor: ColorUtils.errorColor,fontSize: 14,fontWeight: FontWeight.w500,)),
//           ],
//         ),
//         content: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(100),
//             border: Border.all(color: ColorUtils.colorWhite.withOpacity(0.2)),
//             gradient: const LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Color(0xFF3D61AD),
//                 Color(0xFF93BCE0),
//               ],
//             ),
//           ),
//           height: 52,
//           width: screenWidth(context),
//           child: TextField(
//             controller: editController,
//             cursorColor: ColorUtils.colorWhite,
//             style: GoogleFonts.playfairDisplay(
//               textStyle:  const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w300,
//                 color: ColorUtils.colorWhite,
//               ),
//             ),
//             decoration: InputDecoration(
//                 suffixIcon: InkWell(
//                     onTap: () {
//                       chatController.editMessage(msg.id, editController.text);
//                       Navigator.pop(context);
//                     },
//                     child: Container(
//                         padding:const EdgeInsets.all(7),
//                         decoration: const BoxDecoration(
//                             color: ColorUtils.colorBlack,
//                             shape: BoxShape.circle
//                         ),
//                         height: 30,
//                         width: 30,
//                         // child: Icon(Icons.check_circle_outline,size: 30,color: ColorUtils.colorWhite,),
//                         child: const Image(image: AssetImage('assets/images/check_icon.png',),height: 20,)
//                     )
//                 ),
//                 hintText: 'Edit message',
//                 hintStyle: GoogleFonts.playfairDisplay(
//                   textStyle: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: ColorUtils.colorWhite,
//                   ),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(100),
//                   borderSide: BorderSide(color: Colors.transparent),
//                 ),
//                 focusedBorder:OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(100),
//                   borderSide: BorderSide(color: Colors.transparent),
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.auto,
//                 labelStyle: GoogleFonts.playfairDisplay(
//                   textStyle:  TextStyle(
//                     fontSize: 14,
//                     color:ColorUtils.colorWhite,
//                   ),
//                 )
//             ),
//           ),
//         ),
//         actionsAlignment: MainAxisAlignment.start,
//         titleTextStyle: GoogleFonts.playfairDisplay(color: ColorUtils.colorBlack,fontSize: 20,fontWeight: FontWeight.w600),
//         titlePadding:EdgeInsets.only(left: 14,right: 14,bottom: 10,top: 8),
//         contentPadding: EdgeInsets.only(left: 12,right: 12,bottom: 10),
//         actionsPadding: EdgeInsets.zero,
//
//       ),
//     );
//   }
//
//   String? _selectedImagePath;
//
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImagePath = pickedFile.path;
//       });
//
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _setupSocket() ;
//     chatController.initialize(currentUser:  PrefUtils.getUserId(), chattingWithUser: widget.chattingWithUserId);
//     log('usetId---> ${ PrefUtils.getUserId()} chattingWithUser---> ${widget.chattingWithUserId}');
//   }
//
//   @override
//   void dispose() {
//     _socketService.dispose();
//     _scrollController.dispose();
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     chatController.initialize(currentUser:  PrefUtils.getUserId(), chattingWithUser: widget.chattingWithUserId);
//     _setupSocket();
//     return WillPopScope(
//       onWillPop: () async {
//         if (chatController.selectedMessage.value != null) {
//           chatController.selectedMessage.value = null;
//           return false;
//         }
//         return true;
//       },
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         backgroundColor: Color(0xff000000),
//         appBar: AppBar(
//           elevation: 4,
//           leading: Container(
//             height: 30,
//             width: 30,
//             margin: const EdgeInsets.all(8),
//             padding: const EdgeInsets.only(left: 8),
//             decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.2),
//                 shape: BoxShape.circle
//             ),
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: const Center(
//                 child: Icon(
//                   Icons.arrow_back_ios,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           centerTitle: true,
//           backgroundColor: Color(0xff28B3D5),
//           surfaceTintColor: Color(0xff28B3D5),
//           automaticallyImplyLeading: false,
//           title: CommonKhandText(
//             title: widget.userName,
//             textColor: Color(0xffffffff),
//             fontWeight: FontWeight.w300,
//             fontSize: 17,
//           ),
//           actions: [
//             Obx(() {
//               final selected = chatController.selectedMessage.value;
//               return selected != null
//                   ? IconButton(
//                 icon: Icon(Icons.delete,color: Color(0xffffffff)),
//                 onPressed: () {
//                   chatController.deleteSelectedMessage();
//                   chatController.selectedMessage.value = null;
//                 },
//               )
//                   : SizedBox.shrink();
//             }),
//
//             Obx(() {
//               final selected = chatController.selectedMessage.value;
//               return selected != null
//                   ? IconButton(
//                 icon: Icon(Icons.edit, color: Color(0xffffffff)),
//                 onPressed: () {
//                   _editMessage(selected, context);
//                   chatController.selectedMessage.value = null;
//
//                 },
//               )
//                   : SizedBox.shrink();
//             }),
//           ],
//         ),
//         body: Container(
//           height: screenHeight(context),
//           width: screenWidth(context),
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               stops: [0.112, 0.789, 1.0],
//               colors: [
//                 Color(0xFF000000), // Black
//                 Color(0xFF3F3D3D), // Dark Grey
//                 Color(0xFF606060), // Medium Grey
//               ],
//             ),
//           ),
//           child: Column(
//             children: [
//               Expanded(
//                 child: Obx(() {
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//                   });
//                   return ListView.builder(
//                     controller: _scrollController,
//                     itemCount: chatController.messages.length,
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                     itemBuilder: (_, index) {
//                       final msg = chatController.messages[index];
//                       final isMe = msg.fromUserId == PrefUtils.getUserId();
//                       final hasImage = msg.image != null && msg.image!.isNotEmpty;
//                       final hasMessage = msg.message.isNotEmpty;
//
//                       final LinearGradient bubbleGradient = isMe
//                           ? const LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Color(0xFF6956CB),
//                           Color(0xFF744FCE),
//                         ],
//                       )
//                           : LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           ColorUtils.colorWhite.withOpacity(0.15),
//                           ColorUtils.colorWhite.withOpacity(0.15),
//                         ],
//                       );
//
//                       return Align(
//                         alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//                         child: GestureDetector(
//                           onLongPress: () {
//                             if (isMe) {
//                               chatController.selectedMessage.value = msg;
//                             }
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.symmetric(vertical: 4),
//                             constraints: BoxConstraints(
//                               maxWidth: screenWidth(context) * 0.7,
//                             ),
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               gradient: bubbleGradient,
//                             ),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//                               children: [
//                                 if (hasImage)
//                                   GestureDetector(
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => ChatScreenImageSee(image: msg.image!,userName :widget.userName),
//                                         ),
//                                       );
//                                     },
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(8),
//                                       child: SizedBox(
//                                         height: 150,
//                                         width: screenWidth(context) * 0.7,
//                                         child: Image.file(
//                                           File(msg.image!),
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 if (hasImage && hasMessage)
//                                   verticalSpace(8),
//                                 if (hasMessage)
//                                   CommonKhandText(
//                                     title: msg.message,
//                                     fontSize: 14,
//                                     textColor: isMe ? ColorUtils.colorWhite : ColorUtils.colorWhite, // Consistent white text
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 verticalSpace(4),
//                                 CommonKhandText(
//                                   title: DateFormat('hh:mm a').format(msg.timestamp),
//                                   fontSize: 10,
//                                   textColor: ColorUtils.colorWhite,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(10),
//                 child:  Row(
//                   children: [
//                     Expanded(
//                         flex: 4,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(100),
//                             border: Border.all(color: ColorUtils.colorWhite.withOpacity(0.2)),
//                             gradient: const LinearGradient(
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                               colors: [
//                                 Color(0xFF3D61AD),
//                                 Color(0xFF93BCE0),
//                               ],
//                             ),
//                           ),
//                           height: 52,
//                           child: Row(
//                             children: [
//                               // if(_selectedImagePath != null)
//                               //   horizontalSpace(2),
//                               if(_selectedImagePath != null)
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(100),
//                                   child: Image.file(
//                                     File(_selectedImagePath!),
//                                     height: 48,
//                                     width: 48,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               Expanded(
//                                 child: TextField(
//                                   controller: _controller,
//                                   cursorColor: ColorUtils.colorWhite,
//                                   style: GoogleFonts.playfairDisplay(
//                                     textStyle:  const TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w300,
//                                       color: ColorUtils.colorWhite,
//                                     ),
//                                   ),
//                                   decoration: InputDecoration(
//                                       suffixIcon: InkWell(
//                                           onTap: _pickImage,
//                                           child: Container(
//                                               padding:EdgeInsets.all(7),
//                                               decoration: BoxDecoration(
//                                                   color: ColorUtils.colorBlack,
//                                                   shape: BoxShape.circle
//                                               ),
//                                               height: 30,
//                                               width: 30,
//                                               child: Image(image: AssetImage('assets/profile_images/gallery_icon.png',),height: 20,)
//                                           )
//                                       ),
//                                       hintText: 'Type a message',
//                                       hintStyle: GoogleFonts.playfairDisplay(
//                                         textStyle: TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w600,
//                                           color: ColorUtils.colorWhite,
//                                         ),
//                                       ),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(100),
//                                         borderSide: BorderSide(color: Colors.transparent),
//                                       ),
//                                       focusedBorder:OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(100),
//                                         borderSide: BorderSide(color: Colors.transparent),
//                                       ),
//                                       floatingLabelBehavior: FloatingLabelBehavior.auto,
//                                       labelStyle: GoogleFonts.playfairDisplay(
//                                         textStyle:  TextStyle(
//                                           fontSize: 14,
//                                           color:ColorUtils.colorWhite,
//                                         ),
//                                       )
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                     ),
//
//                     horizontalSpace(8),
//                     InkWell(
//                         onTap: _sendMessage,
//                         child: Container(
//                             padding:EdgeInsets.all(8),
//                             height: 52,
//                             width: 52,
//                             decoration: BoxDecoration(
//                               border: Border.all(color: ColorUtils.colorWhite.withOpacity(0.2)),
//                               shape: BoxShape.circle,
//                               gradient: RadialGradient(
//                                 colors: [
//                                   Color(0xFF93BCE0),
//                                   Color(0xFF3D61AD),
//                                 ],
//                                 center: Alignment.center,
//                                 radius: 0.8,
//                               ),
//                             ),
//                             child: Image(image: AssetImage(AssetUtils.messageSend,),height: 20,)
//                         )
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//


import 'dart:io';
import 'package:digitalsaathi/constants/components/pro_text.dart';
import 'package:digitalsaathi/ui/more/chat_screen/chat_controller/chat_model.dart';
import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:digitalsaathi/utils/asset_utils.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:digitalsaathi/utils/prefrence/pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'chat_controller/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  final String chattingWithUserId;
  final String userName;

  const ChatScreen({
    super.key,
    required this.chattingWithUserId,
    required this.userName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController _controller = TextEditingController();
  final ChatController chatController = Get.put(ChatController());
  final ScrollController _scrollController = ScrollController();
  String? _selectedImagePath;

  Future<void> _sendMessage() async {
    final messageText = _controller.text.trim();
    if (messageText.isEmpty && _selectedImagePath == null) return;
    final DigitalChatMessageModel msg = DigitalChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fromUserId: PrefUtils.getUserId(),
      toUserId: widget.chattingWithUserId,
      message: messageText,
      timestamp: DateTime.now(),
      // image: _selectedImagePath,
    );

    await chatController.sendMessage(msg);

    setState(() {
      _controller.clear();
      _selectedImagePath = null;
      print('Message cleared & image reset');
    });
  }



  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _selectedImagePath = pickedFile.path);
    }
  }

  @override
  void initState() {
    super.initState();
    chatController.initialize(
      currentUser: PrefUtils.getUserId(),
      chattingWithUser: widget.chattingWithUserId,
    );

    ever(chatController.messages, (_) {
      Future.delayed(Duration(milliseconds: 200), () {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3F3D3D),
      appBar: AppBar(
          elevation: 4,
          leading: Container(
            height: 30,
            width: 30,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                shape: BoxShape.circle
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
          centerTitle: true,
          backgroundColor: Color(0xff28B3D5),
          surfaceTintColor: Color(0xff28B3D5),
          automaticallyImplyLeading: false,
          title: CommonKhandText(
            title: widget.userName,
            textColor: Color(0xffffffff),
            fontWeight: FontWeight.w300,
            fontSize: 17,
          ),
          actions: [
            Obx(() {
              final selected = chatController.selectedMessage.value;
              return selected != null
                  ? IconButton(
                icon: Icon(Icons.delete,color: Color(0xffffffff)),
                onPressed: () {
                  chatController.deleteSelectedMessage();
                },
              ) : SizedBox.shrink();
            }),

            Obx(() {
              final selected = chatController.selectedMessage.value;
              return selected != null
                  ? IconButton(
                icon: Icon(Icons.edit, color: Color(0xffffffff)),
                onPressed: () {
                  _editMessage(selected);

                },
              ): SizedBox.shrink();
            }),
          ],
        ),
      body: GetBuilder<ChatController>(
        init: chatController,
        builder: (chatCtr) {
          return Container(
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
            child: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                    });
                    return Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: chatController.messages.length,
                        itemBuilder: (_, index) {
                          final msg = chatController.messages[index];
                          final isMe = msg.fromUserId == PrefUtils.getUserId();
                          final hasImage = msg.image != null && msg.image!.isNotEmpty;
                          final hasMessage = msg.message.isNotEmpty;

                          final LinearGradient bubbleGradient = isMe
                              ? const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF6956CB),
                              Color(0xFF744FCE),
                            ],
                          )
                              : LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              ColorUtils.colorWhite.withOpacity(0.15),
                              ColorUtils.colorWhite.withOpacity(0.15),
                            ],
                          );

                          return Align(
                            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                            child: GestureDetector(
                              onLongPress: () {
                                if (isMe) chatController.selectedMessage.value = msg;
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                constraints: BoxConstraints(
                                  maxWidth: screenWidth(context) * 0.7,
                                ),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: bubbleGradient,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                  children: [
                                    // if (hasImage)
                                    //   GestureDetector(
                                    //     onTap: () {
                                    //       Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //           builder: (context) => ChatScreenImageSee(image: msg.image!,userName :widget.userName),
                                    //         ),
                                    //       );
                                    //     },
                                    //     child: ClipRRect(
                                    //       borderRadius: BorderRadius.circular(8),
                                    //       child: SizedBox(
                                    //         height: 150,
                                    //         width: screenWidth(context) * 0.7,
                                    //         child: Image.file(
                                    //           File(msg.image!),
                                    //           fit: BoxFit.cover,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // if (hasImage && hasMessage)
                                      verticalSpace(8),
                                    if (hasMessage)
                                      CommonKhandText(
                                        title: msg.message,
                                        fontSize: 14,
                                        textColor: isMe ? ColorUtils.colorWhite : ColorUtils.colorWhite, // Consistent white text
                                        fontWeight: FontWeight.w400,
                                      ),
                                    verticalSpace(4),
                                    CommonKhandText(
                                      title: chatController.formatTime(msg.timestamp),
                                      fontSize: 10,
                                      textColor: ColorUtils.colorWhite,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child:  Row(
                    children: [

                      Expanded(
                          flex: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: ColorUtils.colorWhite.withOpacity(0.2)),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF3D61AD),
                                  Color(0xFF93BCE0),
                                ],
                              ),
                            ),
                            height: 52,
                            child: Row(
                              children: [
                                // if(_selectedImagePath != null)
                                //   ClipRRect(
                                //     borderRadius: BorderRadius.circular(100),
                                //     child: Image.file(
                                //       File(_selectedImagePath!),
                                //       height: 48,
                                //       width: 48,
                                //       fit: BoxFit.cover,
                                //     ),
                                //   ),
                                Expanded(
                                  child: TextField(
                                    controller: _controller,
                                    cursorColor: ColorUtils.colorWhite,
                                    style: GoogleFonts.playfairDisplay(
                                      textStyle:  const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: ColorUtils.colorWhite,
                                      ),
                                    ),
                                    decoration: InputDecoration(
                                        // suffixIcon: InkWell(
                                        //     onTap: _pickImage,
                                        //     child: Container(
                                        //         padding:EdgeInsets.all(7),
                                        //         decoration: BoxDecoration(
                                        //             color: ColorUtils.colorBlack,
                                        //             shape: BoxShape.circle
                                        //         ),
                                        //         height: 30,
                                        //         width: 30,
                                        //         child: Image(image: AssetImage('assets/profile_images/gallery_icon.png',),height: 20,)
                                        //     )
                                        // ),
                                        hintText: 'Type a message',
                                        hintStyle: GoogleFonts.playfairDisplay(
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: ColorUtils.colorWhite,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(100),
                                          borderSide: BorderSide(color: Colors.transparent),
                                        ),
                                        focusedBorder:OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(100),
                                          borderSide: BorderSide(color: Colors.transparent),
                                        ),
                                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                                        labelStyle: GoogleFonts.playfairDisplay(
                                          textStyle:  TextStyle(
                                            fontSize: 14,
                                            color:ColorUtils.colorWhite,
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),

                      horizontalSpace(8),
                      InkWell(
                          onTap: (){
                            _sendMessage();
                          },
                          child: Container(
                              padding:EdgeInsets.all(8),
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                border: Border.all(color: ColorUtils.colorWhite.withOpacity(0.2)),
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    Color(0xFF93BCE0),
                                    Color(0xFF3D61AD),
                                  ],
                                  center: Alignment.center,
                                  radius: 0.8,
                                ),
                              ),
                              child: Image(image: AssetImage(AssetUtils.messageSend,),height: 20,)
                          )
                      )
                    ],
                  ),
                ),
              ],
            ),
          ) ;
        },
      ),
    );
  }

  void _editMessage(DigitalChatMessageModel msg) {
    final controller = TextEditingController(text: msg.message);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        alignment: Alignment.bottomCenter,
        insetPadding:  EdgeInsets.zero,
        backgroundColor: ColorUtils.colorWhite,
        surfaceTintColor: ColorUtils.colorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Container(width: 20,),
            const CommonKhandText(title: 'Edit Message',textColor: ColorUtils.colorBlack,fontSize: 14,fontWeight: FontWeight.w500,),
            InkWell(
                onTap: (){Navigator.pop(context);},
                child: CommonKhandText(title: 'Cancel',textColor: ColorUtils.errorColor,fontSize: 14,fontWeight: FontWeight.w500,)),
          ],
        ),
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: ColorUtils.colorWhite.withOpacity(0.2)),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF3D61AD),
                Color(0xFF93BCE0),
              ],
            ),
          ),
          height: 52,
          width: screenWidth(context),
          child: TextField(
            controller: controller,
            cursorColor: ColorUtils.colorWhite,
            style: GoogleFonts.playfairDisplay(
              textStyle:  const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: ColorUtils.colorWhite,
              ),
            ),
            decoration: InputDecoration(
                suffixIcon: InkWell(
                    onTap: () async{
                      await chatController.editMessage(msg.id, controller.text);
                      Navigator.pop(context);
                    },
                    child: Container(
                        padding:const EdgeInsets.all(7),
                        decoration: const BoxDecoration(
                            color: ColorUtils.colorBlack,
                            shape: BoxShape.circle
                        ),
                        height: 30,
                        width: 30,
                        // child: Icon(Icons.check_circle_outline,size: 30,color: ColorUtils.colorWhite,),
                        child: const Image(image: AssetImage('assets/images/check_icon.png',),height: 20,)
                    )
                ),
                hintText: 'Edit message',
                hintStyle: GoogleFonts.playfairDisplay(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ColorUtils.colorWhite,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelStyle: GoogleFonts.playfairDisplay(
                  textStyle:  TextStyle(
                    fontSize: 14,
                    color:ColorUtils.colorWhite,
                  ),
                )
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.start,
        titleTextStyle: GoogleFonts.playfairDisplay(color: ColorUtils.colorBlack,fontSize: 20,fontWeight: FontWeight.w600),
        titlePadding:EdgeInsets.only(left: 14,right: 14,bottom: 10,top: 8),
        contentPadding: EdgeInsets.only(left: 12,right: 12,bottom: 10),
        actionsPadding: EdgeInsets.zero,
      ),
    );
  }
}








