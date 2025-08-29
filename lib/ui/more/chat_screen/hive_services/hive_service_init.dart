import 'package:digitalsaathi/ui/more/chat_screen/chatModel/chat_message.dart';
import 'package:digitalsaathi/ui/more/chat_screen/chatModel/userChatListModel.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'hive_box_name.dart';


class HiveServiceInit {
  static Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    // Register Adapters
    Hive.registerAdapter(ChatMessageAdapter());
    Hive.registerAdapter(UserChatListModelAdapter());


    // Open Boxes
    await Hive.openBox<ChatMessageModel>(HiveBoxName.chatMessageBox);
    await Hive.openBox<UserChatListModel>(HiveBoxName.userChatListBox);

  }
}
