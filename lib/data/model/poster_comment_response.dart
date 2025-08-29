class PosterCommentResponse {
  PosterCommentResponse({
    required this.id,
    required this.userId,
    this.eventName,
    required this.detail,
    this.longitude,
    this.latitude,
    required this.eventTypeId,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    required this.relationType,
    this.relationName,
    this.relationEpic,
    this.relationMobile,
    this.address,
    required this.images,
    required this.comments,
    required this.epics,
    required this.mlatags,
    required this.statusCode,
    required this.statusText,
  });
  late  var id;
  late  var userId;
  late final Null eventName;
  late  var detail;
  late final Null longitude;
  late final Null latitude;
  late  var eventTypeId;
  late final Null startDate;
  late final Null endDate;
  late final Null startTime;
  late final Null endTime;
  late  var relationType;
  late final Null relationName;
  late final Null relationEpic;
  late final Null relationMobile;
  late final Null address;
  late final List<Images> images;
  late final List<Comments> comments;
  late final List<dynamic> epics;
  late final List<dynamic> mlatags;
  late  var statusCode;
  late  var statusText;

  PosterCommentResponse.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    eventName = null;
    detail = json['detail'];
    longitude = null;
    latitude = null;
    eventTypeId = json['event_type_id'];
    startDate = null;
    endDate = null;
    startTime = null;
    endTime = null;
    relationType = json['relation_type'];
    relationName = null;
    relationEpic = null;
    relationMobile = null;
    address = null;
    images = List.from(json['images']??[]).map((e)=>Images.fromJson(e)).toList();
    comments = List.from(json['comments']??[]).map((e)=>Comments.fromJson(e)).toList();
    epics = List.castFrom<dynamic, dynamic>(json['epics']);
    mlatags = List.castFrom<dynamic, dynamic>(json['mlatags']);
    statusCode = json['status_code'];
    statusText = json['status_text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['event_name'] = eventName;
    _data['detail'] = detail;
    _data['longitude'] = longitude;
    _data['latitude'] = latitude;
    _data['event_type_id'] = eventTypeId;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    _data['start_time'] = startTime;
    _data['end_time'] = endTime;
    _data['relation_type'] = relationType;
    _data['relation_name'] = relationName;
    _data['relation_epic'] = relationEpic;
    _data['relation_mobile'] = relationMobile;
    _data['address'] = address;
    _data['images'] = images.map((e)=>e.toJson()).toList();
    _data['comments'] = comments.map((e)=>e.toJson()).toList();
    _data['epics'] = epics;
    _data['mlatags'] = mlatags;
    _data['status_code'] = statusCode;
    _data['status_text'] = statusText;
    return _data;
  }
}

class Images {
  Images({
    required this.id,
    required this.eventId,
    required this.photoName,
  });
  late  var id;
  late  var eventId;
  late  var photoName;

  Images.fromJson(Map<String, dynamic> json){
    id = json['id'];
    eventId = json['event_id'];
    photoName = json['photo_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['event_id'] = eventId;
    _data['photo_name'] = photoName;
    return _data;
  }
}

class Comments {
  Comments({
    required this.comId,
    required this.eventId,
    required this.comment,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.createdAt,
  });
  late var comId;
  late var eventId;
  late var comment;
  late var firstName;
  late var lastName;
  late var email;
  late var createdAt;

  Comments.fromJson(Map<String, dynamic> json){
    comId = json['com_id']??"";
    eventId = json['event_id']??"";
    comment = json['comment']??"";
    firstName = json['first_name']??"";
    lastName = json['last_name']??"";
    email = json['email']??"";
    createdAt = json['created_at']??"";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['com_id'] = comId;
    _data['event_id'] = eventId;
    _data['comment'] = comment;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['created_at'] = createdAt;
    return _data;
  }
}