class PosterListModel {
  PosterListModel({
    required this.statusCode,
    required this.statusText,
    required this.data,
    required this.defaultProfile,
  });
  late final int statusCode;
  late final String statusText;
  late final List<PosterData> data;
  late final DefaultProfile defaultProfile;

  PosterListModel.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    statusText = json['status_text'];
    data = List.from(json['data']??[]).map((e)=>PosterData.fromJson(e)).toList();
    if(json['default_profile'] != null) {
      defaultProfile = DefaultProfile.fromJson(json['default_profile']);
    } else{
    defaultProfile = DefaultProfile(id: "", profileImg: "", symbolId: "", designation: "", partyName: "", evm: "", leaders: [], userId: "", isActive: "", whatsapp: "", facebook: "", twitter: "", updatedAt: "", leaderSymbol: "", name: "", symbols: [], mla_name: "", mla_image: "");
  }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['status_text'] = statusText;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['default_profile'] = defaultProfile.toJson();
    return _data;
  }
}

class PosterData {
  PosterData({
    required this.id,
    required this.userId,
    required this.eventCategoryId,
    this.eventName,
    required this.detail,
    this.longitude,
    this.latitude,
    this.address,
    required this.eventTypeId,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    required this.parentId,
    required this.relationType,
    this.relationName,
    this.relationEpic,
    this.relationMobile,
    required this.createdBy,
    required this.createdAt,
    required this.lastModifiedBy,
    required this.updatedAt,
    required this.entityStatus,
    required this.streamingStatus,
    required this.facebookLivestreamingUrl,
    required this.twitterLivestreamingUrl,
    required this.youtubeLivestreamingUrl,
    required this.userid,
    required this.email,
    required this.firstName,
    this.categoryName,
    this.tagUser,
    required this.userMobile,
    this.idCardNo,
    required this.photoName,
    required this.userProfilePicture,
    this.textLeft,
    this.textTop,
    this.textWidth,
    this.textHeight,
    this.textShape,
    this.imgLeft,
    this.imgTop,
    this.imgWidth,
    this.imgHeight,
    this.imgShape,
    this.textBackgroundColor,
    this.socialTextColor,
    this.circleBgColor,
    this.normalTextColor,
    this.taskListId,
    required this.mla_name,
    required this.mla_image,
    required this.commentsCount,
    required this.likesCount,
    required this.isLikeStatus,
    required this.eventPhotos,
  });
  late var id;
  late var userId;
  late var eventCategoryId;
  late Null eventName;
  late var detail;
  late final Null longitude;
  late final Null latitude;
  late final Null address;
  late var eventTypeId;
  late final Null startDate;
  late final Null startTime;
  late final Null endDate;
  late final Null endTime;
  late var parentId;
  late var relationType;
  late final Null relationName;
  late final Null relationEpic;
  late final Null relationMobile;
  late var createdBy;
  late var createdAt;
  late var lastModifiedBy;
  late var updatedAt;
  late var entityStatus;
  late var streamingStatus;
  late var facebookLivestreamingUrl;
  late var twitterLivestreamingUrl;
  late var youtubeLivestreamingUrl;
  late var userid;
  late var email;
  late var firstName;
  late final Null categoryName;
  late final Null tagUser;
  late var userMobile;
  late final Null idCardNo;
  late var photoName;
  late var userProfilePicture;
  late final Null textLeft;
  late final Null textTop;
  late final Null textWidth;
  late final Null textHeight;
  late final Null textShape;
  late final Null imgLeft;
  late final Null imgTop;
  late final Null imgWidth;
  late final Null imgHeight;
  late final Null imgShape;
  late var textBackgroundColor;
  late var socialTextColor;
  late var circleBgColor;
  late var normalTextColor;
  late var taskListId;
  late int commentsCount;
  late  int likesCount;
  late  String isLikeStatus;
  late  String mla_name;
  late  String mla_image;
  late final List<EventPhotos> eventPhotos;

  PosterData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    eventCategoryId = json['event_category_id'];
    eventName = null;
    detail = json['detail'];
    longitude = null;
    latitude = null;
    address = null;
    eventTypeId = json['event_type_id'];
    startDate = null;
    startTime = null;
    endDate = null;
    endTime = null;
    parentId = json['parent_id'];
    relationType = json['relation_type'];
    relationName = null;
    relationEpic = null;
    relationMobile = null;
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    lastModifiedBy = json['last_modified_by'];
    updatedAt = json['updated_at'];
    entityStatus = json['entity_status'];
    streamingStatus = json['streaming_status'];
    facebookLivestreamingUrl = json['facebook_livestreaming_url'];
    twitterLivestreamingUrl = json['twitter_livestreaming_url'];
    youtubeLivestreamingUrl = json['youtube_livestreaming_url'];
    userid = json['userid'];
    email = json['email'];
    firstName = json['first_name'];
    categoryName = null;
    tagUser = null;
    userMobile = json['user_mobile'];
    idCardNo = null;
    photoName = json['photo_name']??'';
    userProfilePicture = json['user_profile_picture'];
    textLeft = null;
    textTop = null;
    textWidth = null;
    textHeight = null;
    textShape = null;
    imgLeft = null;
    imgTop = null;
    imgWidth = null;
    imgHeight = null;
    imgShape = null;
    textBackgroundColor = null;
    socialTextColor = null;
    circleBgColor = null;
    normalTextColor = null;
    taskListId = null;
    commentsCount = json['comments_count'];
    likesCount = json['likes_count'];
    isLikeStatus = json['is_like_status'];
    mla_image = json['mla_image']??"";
    mla_name = json['mla_name']??"";
    eventPhotos = List.from(json['event_photos']??[]).map((e)=>EventPhotos.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['event_category_id'] = eventCategoryId;
    _data['event_name'] = eventName;
    _data['detail'] = detail;
    _data['longitude'] = longitude;
    _data['latitude'] = latitude;
    _data['address'] = address;
    _data['event_type_id'] = eventTypeId;
    _data['start_date'] = startDate;
    _data['start_time'] = startTime;
    _data['end_date'] = endDate;
    _data['end_time'] = endTime;
    _data['parent_id'] = parentId;
    _data['relation_type'] = relationType;
    _data['relation_name'] = relationName;
    _data['relation_epic'] = relationEpic;
    _data['relation_mobile'] = relationMobile;
    _data['created_by'] = createdBy;
    _data['created_at'] = createdAt;
    _data['last_modified_by'] = lastModifiedBy;
    _data['updated_at'] = updatedAt;
    _data['entity_status'] = entityStatus;
    _data['streaming_status'] = streamingStatus;
    _data['facebook_livestreaming_url'] = facebookLivestreamingUrl;
    _data['twitter_livestreaming_url'] = twitterLivestreamingUrl;
    _data['youtube_livestreaming_url'] = youtubeLivestreamingUrl;
    _data['userid'] = userid;
    _data['email'] = email;
    _data['first_name'] = firstName;
    _data['category_name'] = categoryName;
    _data['tag_user'] = tagUser;
    _data['user_mobile'] = userMobile;
    _data['id_card_no'] = idCardNo;
    _data['photo_name'] = photoName;
    _data['user_profile_picture'] = userProfilePicture;
    _data['text_left'] = textLeft;
    _data['text_top'] = textTop;
    _data['text_width'] = textWidth;
    _data['text_height'] = textHeight;
    _data['text_shape'] = textShape;
    _data['img_left'] = imgLeft;
    _data['img_top'] = imgTop;
    _data['img_width'] = imgWidth;
    _data['img_height'] = imgHeight;
    _data['img_shape'] = imgShape;
    _data['text_background_color'] = textBackgroundColor;
    _data['social_text_color'] = socialTextColor;
    _data['circle_bg_color'] = circleBgColor;
    _data['normal_text_color'] = normalTextColor;
    _data['task_list_id'] = taskListId;
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
    required this.textBackgroundColor,
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
  late final Null textLeft;
  late final Null textTop;
  late final Null textWidth;
  late final Null textHeight;
  late final Null textShape;
  late var textBackgroundColor;
  late final Null imgLeft;
  late final Null imgTop;
  late final Null imgWidth;
  late final Null imgHeight;
  late final Null imgShape;
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
    textBackgroundColor = json['text_background_color'];
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

class DefaultProfile {
  DefaultProfile({
    required this.id,
    required this.profileImg,
    required this.symbolId,
    required this.designation,
    required this.partyName,
    required this.evm,
    required this.leaders,
    required this.userId,
    required this.isActive,
    required this.whatsapp,
    required this.facebook,
    required this.twitter,
    required this.updatedAt,
    required this.leaderSymbol,
    required this.name,
    required this.symbols,
    required this.mla_name,
    required this.mla_image,
  });
  late var id;
  late var profileImg;
  late var symbolId;
  late var designation;
  late var partyName;
  late var evm;
  late final List<Leaders> leaders;
  late var userId;
  late var isActive;
  late var whatsapp;
  late var facebook;
  late var twitter;
  late var updatedAt;
  late var leaderSymbol;
  late var name;
  late var mla_name;
  late var mla_image;
  late final List<Symbols> symbols;

  DefaultProfile.fromJson(Map<String, dynamic> json){
    id = json['id']??"";
    profileImg = json['profile_img']??"";
    symbolId = json['symbol_id']??"";
    designation = json['designation']??"";
    partyName = json['party_name']??"";
    evm = json['evm']??"";
    leaders = List.from(json['leaders']??[]).map((e)=>Leaders.fromJson(e)).toList();
    userId = json['user_id']??"";
    isActive = json['is_active']??"";
    whatsapp = json['whatsapp']??"";
    facebook = json['facebook']??"";
    twitter = json['twitter']??"";
    updatedAt = json['updated_at']??"";
    leaderSymbol = json['leader_symbol']??"";
    name = json['name']??"";
    mla_name = json['mla_name']??"";
    mla_image = json['mla_image']??"";
    symbols = List.from(json['symbols']??[]).map((e)=>Symbols.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['profile_img'] = profileImg;
    _data['symbol_id'] = symbolId;
    _data['designation'] = designation;
    _data['party_name'] = partyName;
    _data['evm'] = evm;
    _data['leaders'] = leaders.map((e)=>e.toJson()).toList();
    _data['user_id'] = userId;
    _data['is_active'] = isActive;
    _data['whatsapp'] = whatsapp;
    _data['facebook'] = facebook;
    _data['twitter'] = twitter;
    _data['updated_at'] = updatedAt;
    _data['leader_symbol'] = leaderSymbol;
    _data['name'] = name;
    _data['symbols'] = symbols.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Leaders {
  Leaders({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
  });
  late var id;
  late var name;
  late var image;
  late var type;

  Leaders.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    _data['type'] = type;
    return _data;
  }
}

class Symbols {
  Symbols({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
  });
  late var id;
  late var name;
  late var image;
  late var type;

  Symbols.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    _data['type'] = type;
    return _data;
  }
}