class CommonResponse {
  CommonResponse({
    required this.statusCode,
    required this.statusText,
    required this.message,
  });
  late final int statusCode;
  late final String statusText;
  late final String message;

  CommonResponse.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    statusText = json['status_text'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['status_text'] = statusText;
    _data['message'] = message;
    return _data;
  }
}