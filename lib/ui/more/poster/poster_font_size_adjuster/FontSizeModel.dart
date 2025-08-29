class FontSizeModel {
  int? statusCode;
  String? statusText;
  String? data;

  FontSizeModel({this.statusCode, this.statusText, this.data});

  FontSizeModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusText = json['status_text'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status_text'] = this.statusText;
    data['data'] = this.data;
    return data;
  }
}
