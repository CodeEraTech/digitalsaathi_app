import 'package:digitalsaathi/ui/more/chat_screen/chatModel/chat_message.dart';
import 'package:digitalsaathi/ui/more/chat_screen/chatModel/userChatListModel.dart';
import 'package:hive/hive.dart';
import 'hive_box_name.dart';

class HiveBoxes{
  static Box<ChatMessageModel> chatMessageBox() =>Hive.box<ChatMessageModel>(HiveBoxName.chatMessageBox);
  static Box<UserChatListModel> userChatListBox() =>Hive.box<UserChatListModel>(HiveBoxName.userChatListBox);
}
