import 'package:hive/hive.dart';
part 'userChatListModel.g.dart';
@HiveType(typeId: 8)
class UserChatListModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String userId;
  @HiveField(2)
  final String chatWithUserId;
  @HiveField(3)
  String? lastMessage;
  @HiveField(4)
  DateTime? lastTimestamp;

  UserChatListModel({
    required this.name,
    required this.userId,
    this.lastMessage = '',
    this.lastTimestamp ,
    required this.chatWithUserId,
  });
}


