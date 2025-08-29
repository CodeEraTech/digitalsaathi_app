class NotificationCountModel {
  NotificationCountModel({
    required this.statusCode,
    required this.statusText,
    required this.data,
    required this.message,
  });
  late final int statusCode;
  late final String statusText;
  late final int data;
  late final String message;

  NotificationCountModel.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    statusText = json['status_text'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['status_text'] = statusText;
    _data['data'] = data;
    _data['message'] = message;
    return _data;
  }
}