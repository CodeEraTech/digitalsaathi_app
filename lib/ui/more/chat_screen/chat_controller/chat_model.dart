import 'package:cloud_firestore/cloud_firestore.dart';

// class DigitalChatMessageModel {
//   final String id;
//   final String fromUserId;
//   final String toUserId;
//   final String message;
//   final DateTime timestamp;
//   final String? image;
//
//   DigitalChatMessageModel({
//     required this.id,
//     required this.fromUserId,
//     required this.toUserId,
//     required this.message,
//     required this.timestamp,
//     this.image,
//   });
//
//   factory DigitalChatMessageModel.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return DigitalChatMessageModel(
//       id: doc.id,
//       fromUserId: data['fromUserId'],
//       toUserId: data['toUserId'],
//       message: data['message'],
//       timestamp: (data['timestamp'] as Timestamp).toDate(),
//       image: data['image'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'fromUserId': fromUserId,
//       'toUserId': toUserId,
//       'message': message,
//       'timestamp': timestamp,
//       'image': image,
//       'participants': [fromUserId, toUserId],
//     };
//   }
//
//   DigitalChatMessageModel copyWith({String? message}) {
//     return DigitalChatMessageModel(
//       id: id,
//       fromUserId: fromUserId,
//       toUserId: toUserId,
//       message: message ?? this.message,
//       timestamp: timestamp,
//       image: image,
//     );
//   }
// }


class DigitalChatMessageModel {
  final String id;
  final String fromUserId;
  final String toUserId;
  final String message;
  final DateTime timestamp;
  final String? image;

  DigitalChatMessageModel({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.message,
    required this.timestamp,
    this.image,
  });

  /// ✅ Safe Firestore conversion with null checks
  factory DigitalChatMessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;

    if (data == null) {
      throw StateError("Document ${doc.id} contains no data.");
    }

    return DigitalChatMessageModel(
      id: doc.id,
      fromUserId: data['fromUserId'] ?? '',
      toUserId: data['toUserId'] ?? '',
      message: data['message'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      image: data['image'],
    );
  }

  /// 🔄 Convert to JSON for Firestore storage
  Map<String, dynamic> toJson() {
    return {
      'fromUserId': fromUserId,
      'toUserId': toUserId,
      'message': message,
      'timestamp': timestamp,
      'image': image,
      'participants': [fromUserId, toUserId],
    };
  }

  /// 🖊️ Create a modified copy (e.g. for editing message)
  DigitalChatMessageModel copyWith({
    String? message,
    String? image,
  }) {
    return DigitalChatMessageModel(
      id: id,
      fromUserId: fromUserId,
      toUserId: toUserId,
      message: message ?? this.message,
      timestamp: timestamp,
      image: image ?? this.image,
    );
  }
}
