class NotificationListModel {
  NotificationListModel({
    required this.type,
    required this.id,
    required this.statusCode,
    required this.statusText,
    required this.data,
    required this.message,
  });
  late  var type;
  late  var id;
  late  var statusCode;
  late  var statusText;
  late final List<NotificationData> data;
  late  var message;

  NotificationListModel.fromJson(Map<String, dynamic> json){
    type = json['type'];
    id = json['id'];
    statusCode = json['status_code'];
    statusText = json['status_text'];
    data = List.from(json['data']).map((e)=>NotificationData.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['id'] = id;
    _data['status_code'] = statusCode;
    _data['status_text'] = statusText;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class NotificationData {
  NotificationData({
    required this.notificationId,
    required this.toId,
    required this.toName,
    required this.msg,
    required this.type,
    required this.createdAt,
    required this.fromId,
    required this.fromName,
    required this.readStatus,
    this.imagelink,
    this.event_name,
  });
  late var notificationId;
  late var toId;
  late var toName;
  late var msg;
  late Type type;
  late var createdAt;
  late var fromId;
  late var fromName;
  late var readStatus;
  late var imagelink;
  late var event_name;

  NotificationData.fromJson(Map<String, dynamic> json){
    notificationId = json['notification_id'];
    toId = json['to_id'];
    toName = json['to_name'];
    msg = json['msg'];
    type = Type.fromJson(json['type']);
    createdAt = json['created_at'];
    fromId = json['from_id'];
    fromName = json['from_name'];
    readStatus = json['read_status'];
    imagelink = json['imagelink']??"";
    event_name = json['event_name']??"";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['notification_id'] = notificationId;
    _data['to_id'] = toId;
    _data['to_name'] = toName;
    _data['msg'] = msg;
    _data['type'] = type.toJson();
    _data['created_at'] = createdAt;
    _data['from_id'] = fromId;
    _data['from_name'] = fromName;
    _data['read_status'] = readStatus;
    _data['imagelink'] = imagelink;
    return _data;
  }
}

class Type {
  Type({
    required this.type,
    required this.id,
    this.username,
    this.role_id,
  });
  late  var type;
  late  var id;
  late  var username;
  late  var role_id;

  Type.fromJson(Map<String, dynamic> json){
    type = json['type'];
    id = json['id'];
    username = json["username"];
    role_id = "${json["role_id"]??0}";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['id'] = id;
    _data['username'] = username;
    return _data;
  }
}