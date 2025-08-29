import 'package:hive/hive.dart';
part 'chat_message.g.dart';

@HiveType(typeId: 7)
class ChatMessageModel {
  @HiveField(0)
  String fromUserId;

  @HiveField(1)
  String toUserId;

  @HiveField(2)
  String message;

  @HiveField(3)
  DateTime timestamp;

  @HiveField(4)
  String id;

  @HiveField(5)
  String? image;

  ChatMessageModel({
    required this.fromUserId,
    required this.toUserId,
    required this.message,
    required this.timestamp,
    required this.id,
    this.image
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      fromUserId: json['fromUserId'],
      toUserId: json['toUserId'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
      id: json['id'],
      image: json['image']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'id': id,
      'image':image
    };
  }
}

