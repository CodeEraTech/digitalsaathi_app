// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userChatListModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserChatListModelAdapter extends TypeAdapter<UserChatListModel> {
  @override
  final int typeId = 8;

  @override
  UserChatListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserChatListModel(
      name: fields[0] as String,
      userId: fields[1] as String,
      lastMessage: fields[3] as String?,
      lastTimestamp: fields[4] as DateTime?,
      chatWithUserId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserChatListModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.chatWithUserId)
      ..writeByte(3)
      ..write(obj.lastMessage)
      ..writeByte(4)
      ..write(obj.lastTimestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserChatListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
