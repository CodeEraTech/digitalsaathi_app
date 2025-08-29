class FeedData {
  FeedData({
    required this.livestream,
    required this.livestreamstatus,
    required this.statusCode,
    required this.statusText,
    required this.data,
  });
  late final Livestream livestream;
  late final bool livestreamstatus;
  late final int statusCode;
  late final String statusText;
  late final List<ReelsData> data;

  FeedData.fromJson(Map<String, dynamic> json){
    livestream = Livestream.fromJson(json['livestream']??[]);
    livestreamstatus = json['livestreamstatus'];
    statusCode = json['status_code'];
    statusText = json['status_text'];
    data = List.from(json['data']).map((e)=>ReelsData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['livestream'] = livestream.toJson();
    _data['livestreamstatus'] = livestreamstatus;
    _data['status_code'] = statusCode;
    _data['status_text'] = statusText;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Livestream {
  Livestream();

  Livestream.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}

class ReelsData {
  ReelsData({
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
    required this.name,
    required this.userProfilePicture,
    required this.createdAt,
    required this.relationType,
    this.relationName,
    this.relationEpic,
    this.relationMobile,
    this.address,
    required this.streamingStatus,
    required this.parentId,
    required this.mobile,
    required this.addressLine1,
    required this.commentsCount,
    required this.likesCount,
    required this.isLikeStatus,
    required this.eventPhotos,
  });
  late final int id;
  late final int userId;
  late final String? eventName;
  late final String detail;
  late final Null longitude;
  late final Null latitude;
  late final int eventTypeId;
  late final Null startDate;
  late final Null endDate;
  late final Null startTime;
  late final Null endTime;
  late final String name;
  late final String userProfilePicture;
  late final String createdAt;
  late final String relationType;
  late final Null relationName;
  late final Null relationEpic;
  late final Null relationMobile;
  late final Null address;
  late final String streamingStatus;
  late final int parentId;
  late final String mobile;
  late final String addressLine1;
  late final int commentsCount;
  late final int likesCount;
  late final String isLikeStatus;
  late final List<EventPhotos> eventPhotos;

  ReelsData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = int.parse("${json['user_id']??0}");
    eventName = json['event_name']??'';
    detail = json['detail'];
    longitude = null;
    latitude = null;
    eventTypeId = int.parse("${json['event_type_id']??0}");
    startDate = null;
    endDate = null;
    startTime = null;
    endTime = null;
    name = json['name'];
    userProfilePicture = json['user_profile_picture']??"";
    createdAt = json['created_at'];
    relationType = json['relation_type'];
    relationName = null;
    relationEpic = null;
    relationMobile = null;
    address = null;
    streamingStatus = json['streaming_status'];
    parentId = int.parse("${json['parent_id']??0}");
    mobile = json['mobile'];
    addressLine1 = json['address_line1']??"";
    commentsCount = json['comments_count'];
    likesCount = json['likes_count'];
    isLikeStatus = json['is_like_status'];
    eventPhotos = List.from(json['event_photos']??[]).map((e)=>EventPhotos.fromJson(e)).toList();
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
    _data['name'] = name;
    _data['user_profile_picture'] = userProfilePicture;
    _data['created_at'] = createdAt;
    _data['relation_type'] = relationType;
    _data['relation_name'] = relationName;
    _data['relation_epic'] = relationEpic;
    _data['relation_mobile'] = relationMobile;
    _data['address'] = address;
    _data['streaming_status'] = streamingStatus;
    _data['parent_id'] = parentId;
    _data['mobile'] = mobile;
    _data['address_line1'] = addressLine1;
    _data['comments_count'] = commentsCount;
    _data['likes_count'] = likesCount;
    _data['is_like_status'] = isLikeStatus;
    _data['event_photos'] = eventPhotos.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class EventPhotos {
  EventPhotos({
    required this.id,
    required this.eventId,
    required this.photoName,
    required this.type,
    this.textLeft,
    this.textTop,
    this.textWidth,
    this.textHeight,
    this.textShape,
    this.textBackgroundColor,
    this.imgLeft,
    this.imgTop,
    this.imgWidth,
    this.imgHeight,
    this.imgShape,
    required this.socialTextColor,
    required this.circleBgColor,
    required this.normalTextColor,
    required this.isTask,
    required this.createdBy,
    required this.createdAt,
    required this.lastModifiedBy,
    required this.updatedAt,
    required this.entityStatus,
  });
  late var id;
  late var eventId;
  late var photoName;
  late var type;
  late Null textLeft;
  late Null textTop;
  late Null textWidth;
  late Null textHeight;
  late Null textShape;
  late Null textBackgroundColor;
  late Null imgLeft;
  late Null imgTop;
  late Null imgWidth;
  late Null imgHeight;
  late Null imgShape;
  late var socialTextColor;
  late var circleBgColor;
  late var normalTextColor;
  late var isTask;
  late var createdBy;
  late var createdAt;
  late var lastModifiedBy;
  late var updatedAt;
  late var entityStatus;

  EventPhotos.fromJson(Map<String, dynamic> json){
    id = json['id'];
    eventId = json['event_id'];
    photoName = json['photo_name'];
    type = json['type'];
    textLeft = null;
    textTop = null;
    textWidth = null;
    textHeight = null;
    textShape = null;
    textBackgroundColor = null;
    imgLeft = null;
    imgTop = null;
    imgWidth = null;
    imgHeight = null;
    imgShape = null;
    socialTextColor = json['social_text_color'];
    circleBgColor = json['circle_bg_color'];
    normalTextColor = json['normal_text_color'];
    isTask = json['is_task'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    lastModifiedBy = json['last_modified_by'];
    updatedAt = json['updated_at'];
    entityStatus = json['entity_status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['event_id'] = eventId;
    _data['photo_name'] = photoName;
    _data['type'] = type;
    _data['text_left'] = textLeft;
    _data['text_top'] = textTop;
    _data['text_width'] = textWidth;
    _data['text_height'] = textHeight;
    _data['text_shape'] = textShape;
    _data['text_background_color'] = textBackgroundColor;
    _data['img_left'] = imgLeft;
    _data['img_top'] = imgTop;
    _data['img_width'] = imgWidth;
    _data['img_height'] = imgHeight;
    _data['img_shape'] = imgShape;
    _data['social_text_color'] = socialTextColor;
    _data['circle_bg_color'] = circleBgColor;
    _data['normal_text_color'] = normalTextColor;
    _data['is_task'] = isTask;
    _data['created_by'] = createdBy;
    _data['created_at'] = createdAt;
    _data['last_modified_by'] = lastModifiedBy;
    _data['updated_at'] = updatedAt;
    _data['entity_status'] = entityStatus;
    return _data;
  }
}