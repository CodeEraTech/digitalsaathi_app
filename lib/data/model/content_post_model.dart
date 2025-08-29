class ContentPostModel {
  int? status;
  String? message;
  List<ContentData>? data;

  ContentPostModel({this.status, this.message, this.data});

  ContentPostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ContentData>[];
      json['data'].forEach((v) {
        data!.add(new ContentData.fromJson(v));
      });
    }else{
      data = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContentData {
  var id;
  var file;
  var type;
  var postUrl;
  var share;
  var see;
  var download;
  var isShare;

  ContentData(
      {this.id,
        this.file,
        this.type,
        this.postUrl,
        this.share,
        this.see,
        this.download,
        this.isShare});

  ContentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file = json['file'];
    type = json['type'];
    postUrl = json['post_url'];
    share = json['share'];
    see = json['see'];
    download = json['downlaod'];
    isShare = json['is_share'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file'] = this.file;
    data['type'] = this.type;
    data['post_url'] = this.postUrl;
    data['share'] = this.share;
    data['see'] = this.see;
    data['downlaod'] = this.download;
    data['is_share'] = this.isShare;
    return data;
  }
}
