/// USING SOCKET.IO
// import 'package:digitalsaathi/ui/more/chat_screen/chatModel/chat_message.dart';
// import 'package:digitalsaathi/ui/more/chat_screen/chatModel/userChatListModel.dart';
// import 'package:digitalsaathi/ui/more/chat_screen/hive_services/hive_boxes.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// class ChatController extends GetxController {
//   final RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;
//
//   Rx<ChatMessageModel?> selectedMessage = Rx<ChatMessageModel?>(null);
//   void deleteSelectedMessage() {
//     if (selectedMessage.value != null) {
//       deleteMessage(selectedMessage.value!.id);
//       selectedMessage.value = null;
//     }
//   }
//
//   late String currentUserId;
//   late String chattingWithUserId;
//
//   void initialize({required String currentUser, required String chattingWithUser}) {
//     currentUserId = currentUser;
//     chattingWithUserId = chattingWithUser;
//     loadMessages();
//   }
//
//
//   void loadMessages() {
//     final box = HiveBoxes.chatMessageBox();
//     messages.assignAll(
//       box.values.where((msg) =>
//           (msg.fromUserId == currentUserId && msg.toUserId == chattingWithUserId) ||
//           (msg.fromUserId == chattingWithUserId && msg.toUserId == currentUserId)
//       ).toList(),
//     );
//   }
//
//   void addMessage(ChatMessageModel msg) {
//     final box = HiveBoxes.chatMessageBox();
//     box.put(msg.id, msg);
//     messages.add(msg);
//   }
//
//   void deleteMessage(String msgId) {
//     final box = HiveBoxes.chatMessageBox();
//     box.delete(msgId);
//     messages.removeWhere((msg) => msg.id == msgId);
//   }
//
//   void editMessage(String msgId, String newMessage) {
//     final box = HiveBoxes.chatMessageBox();
//     final oldMessage = box.get(msgId);
//
//     if (oldMessage != null) {
//       final updatedMessage = ChatMessageModel(
//         id: oldMessage.id,
//         fromUserId: oldMessage.fromUserId,
//         toUserId: oldMessage.toUserId,
//         message: newMessage,
//         timestamp: oldMessage.timestamp,
//         image: oldMessage.image,
//       );
//
//       box.put(msgId, updatedMessage);
//
//       final index = messages.indexWhere((msg) => msg.id == msgId);
//       if (index != -1) {
//         messages[index] = updatedMessage;
//       }
//     } else {
//       print("Message not found.");
//     }
//   }
//
//   Future<void> loadLastMessagesForUsers(List<UserChatListModel> users) async {
//     final userChatListBox = HiveBoxes.userChatListBox();
//
//     for (var user in users) {
//       final lastMsg = await getLastMessage(user.userId, user.chatWithUserId);
//       if (lastMsg != null) {
//         user.lastMessage = lastMsg.message;
//         user.lastTimestamp = lastMsg.timestamp;
//         await userChatListBox.put(user.userId, user);
//
//       }
//     }
//     update();
//   }
//
//   Future<ChatMessageModel?> getLastMessage(String userId1, String userId2) async {
//     final box = HiveBoxes.chatMessageBox();
//     final msgs = box.values.where((msg) =>
//     (msg.fromUserId == userId1 && msg.toUserId == userId2) || (msg.fromUserId == userId2 && msg.toUserId == userId1));
//     if (msgs.isEmpty) return null;
//
//     final sorted = msgs.toList()..sort((a, b) => b.timestamp.compareTo(a.timestamp));
//     return sorted.first;
//   }
//
//   String formatTime(DateTime timestamp) {
//     final now = DateTime.now();
//     if (now.difference(timestamp).inDays == 0 &&
//         now.day == timestamp.day &&
//         now.month == timestamp.month &&
//         now.year == timestamp.year) {
//       return DateFormat('hh:mm a').format(timestamp);
//     } else {
//       return DateFormat('dd/MM').format(timestamp);
//     }
//   }
//
// }
/// USING FIREBASE


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitalsaathi/ui/more/chat_screen/chatModel/userChatListModel.dart';
import 'package:digitalsaathi/ui/more/chat_screen/chat_controller/chat_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatController extends GetxController {

  final RxList<DigitalChatMessageModel> messages = <DigitalChatMessageModel>[].obs;
  Rx<DigitalChatMessageModel?> selectedMessage = Rx<DigitalChatMessageModel?>(null);

  late String currentUserId;
  late String chattingWithUserId;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  void initialize({required String currentUser, required String chattingWithUser}) {
    currentUserId = currentUser;
    chattingWithUserId = chattingWithUser;
    loadMessages();
  }
  /// 📩 Load chat messages in real-time
  void loadMessages() {
    try {
      _firestore
          .collection('chats')
          .where('participants', arrayContains: currentUserId)
          .orderBy('timestamp', descending: false)
          .snapshots()
          .listen((snapshot) {
        print("📥 Firestore update received: ${snapshot.docs.length} docs");

        for (var doc in snapshot.docs) {
          print("📃 doc: ${doc.data()}"); // Debug each message
        }

        final fetchedMessages = snapshot.docs
            .map((doc) => DigitalChatMessageModel.fromFirestore(doc))
            .where((msg) =>
        (msg.fromUserId == currentUserId && msg.toUserId == chattingWithUserId) ||
            (msg.fromUserId == chattingWithUserId && msg.toUserId == currentUserId))
            .toList();

        messages.assignAll(fetchedMessages); // ✅ ensures reactive update
        update();
      });
    } catch (e, stackTrace) {
      EasyLoading.showError("$stackTrace");
      print("🔥 Error loading messages: $e\n$stackTrace");
      update();
    }
  }

  /// 📨 Send a new message

  Future<void> sendMessage(DigitalChatMessageModel msg) async {
    try {
      final data = msg.toJson();
      await _firestore.collection('chats').doc(msg.id).set(data);
      print("✅ Message sent: ${msg.message}");
    } catch (e) {
      EasyLoading.showError("❌ Send failed: $e");
    }
  }

  /// ❌ Delete a message
  Future<void> deleteMessage(String msgId) async {
    try {
      await _firestore.collection('chats').doc(msgId).delete();
      messages.removeWhere((msg) => msg.id == msgId);
      update();
    } catch (e) {
      EasyLoading.showError("$e");
      print("❌ Failed to delete message: $e");
      update();
    }
  }

  /// 🖊️ Edit a message
  Future<void> editMessage(String msgId, String newMessage) async {
    try {
      final doc = _firestore.collection('chats').doc(msgId);
      final snapshot = await doc.get();
      if (snapshot.exists) {
        await doc.update({'message': newMessage});
        final index = messages.indexWhere((msg) => msg.id == msgId);
        if (index != -1) {
          final updatedMsg = messages[index].copyWith(message: newMessage);
          messages[index] = updatedMsg;
        }
      }
      update();
    } catch (e) {
      EasyLoading.showError("$e");
      print("❌ Failed to edit message: $e");
      update();
    }
  }

  /// ✅ Delete selected message
  void deleteSelectedMessage() {
    if (selectedMessage.value != null) {
      deleteMessage(selectedMessage.value!.id);
      selectedMessage.value = null;
      update();
    }
  }

  /// 🧠 Load last messages for user list
  Future<void> loadLastMessagesForUsers(List<UserChatListModel> users) async {
    for (var user in users) {
      try {
        final lastMsg = await getLastMessage(user.userId, user.chatWithUserId);
        if (lastMsg != null) {
          user.lastMessage = lastMsg.message;
          user.lastTimestamp = lastMsg.timestamp;

          await _firestore
              .collection('user_chat_list')
              .doc('${user.userId}_${user.chatWithUserId}')
              .set({
            'name': user.name,
            'userId': user.userId,
            'chatWithUserId': user.chatWithUserId,
            'lastMessage': user.lastMessage,
            'lastTimestamp': user.lastTimestamp,
          });

          update();
        }
      } catch (e) {
        EasyLoading.showError("⚠️ Failed to load or update last message for ${user.userId}:$e");
        print("⚠️ Failed to load or update last message for ${user.userId}: $e");
        update();
      }
    }
    update(); // Refresh UI
  }

  /// 🔍 Get last message between two users
  Future<DigitalChatMessageModel?> getLastMessage(String user1, String user2) async {
    try {
      final snapshot = await _firestore
          .collection('chats')
          .where('participants', arrayContains: user1)
          .orderBy('timestamp', descending: true)
          .get();
      final msgs = snapshot.docs
          .map((doc) => DigitalChatMessageModel.fromFirestore(doc))
          .where((msg) =>
      (msg.fromUserId == user1 && msg.toUserId == user2) ||
          (msg.fromUserId == user2 && msg.toUserId == user1))
          .toList();

      return msgs.isNotEmpty ? msgs.first : null;
    } catch (e) {
      EasyLoading.showError("❌ Error getting last message between $user1 and $user2: $e");
      print("❌ Error getting last message between $user1 and $user2: $e");
      update();
      return null;
    }
  }

  /// 🕓 Format timestamp for chat bubbles
  String formatTime(DateTime timestamp) {
    final now = DateTime.now();
    if (now.difference(timestamp).inDays == 0 &&
        now.day == timestamp.day &&
        now.month == timestamp.month &&
        now.year == timestamp.year) {
      return DateFormat('hh:mm a').format(timestamp);
    } else {
      return DateFormat('dd/MM').format(timestamp);

    }
  }


}










