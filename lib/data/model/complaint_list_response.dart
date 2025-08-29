class ComplaintListResponse {
  ComplaintListResponse({
    required this.statusCode,
    required this.statusText,
    required this.data,
  });
  late final int statusCode;
  late final String statusText;
  late final List<ComplaintData> data;

  ComplaintListResponse.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    statusText = json['status_text'];
    data = List.from(json['data']??[]).map((e)=>ComplaintData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['status_text'] = statusText;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ComplaintData {
  ComplaintData({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.complaintNo,
    required this.lat,
    required this.lng,
    required this.address,
    required this.mlaId,
    required this.subject,
    required this.description,
    required this.statusId,
    required this.relationType,
    required this.relationName,
    required this.relationEpic,
    required this.relationMobile,
    required this.createdBy,
    required this.createdAt,
    required this.lastModifiedBy,
    required this.updatedAt,
    required this.entityStatus,
    required this.highSeverity,
    required this.createType,
    this.complainStatus,
    required this.complainDate,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.userProfilePicture,
    required this.catId,
    required this.categoryName,
    required this.status,
    required this.createdbyuser,
    required this.documents,
    required this.comments,
  });
  late var id;
  late var userId;
  late var categoryId;
  late var complaintNo;
  late var lat;
  late var lng;
  late var address;
  late var mlaId;
  late var subject;
  late var description;
  late var statusId;
  late var relationType;
  late var relationName;
  late var relationEpic;
  late var relationMobile;
  late var createdBy;
  late var createdAt;
  late var lastModifiedBy;
  late var updatedAt;
  late var entityStatus;
  late var highSeverity;
  late var createType;
  late final Null complainStatus;
  late var complainDate;
  late var firstName;
  late var lastName;
  late var email;
  late var mobile;
  late var userProfilePicture;
  late var catId;
  late var categoryName;
  late var status;
  late var createdbyuser;
  late final List<Documents> documents;
  late  var comments;

  ComplaintData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    complaintNo = json['complaint_no'];
    lat = json['lat'];
    lng = json['lng'];
    address = json['address'];
    mlaId = json['mla_id'];
    subject = json['subject'];
    description = json['description'];
    statusId = json['status_id'];
    relationType = json['relation_type']??'';
    relationName = json['relation_name']??"";
    relationEpic =  json['relation_epic']??'';
    relationMobile =  json['relation_mobile']??'';
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    lastModifiedBy = json['last_modified_by'];
    updatedAt = json['updated_at'];
    entityStatus = json['entity_status'];
    highSeverity = json['high_severity'];
    createType = json['createType'];
    complainStatus = null;
    complainDate = json['complain_date'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    userProfilePicture = json['user_profile_picture']??"";
    catId = json['cat_id'];
    categoryName = json['category_name'];
    status = json['status'];
    createdbyuser = json['createdbyuser'];
    documents = List.from(json['documents']??[]).map((e)=>Documents.fromJson(e)).toList();
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['category_id'] = categoryId;
    _data['complaint_no'] = complaintNo;
    _data['lat'] = lat;
    _data['lng'] = lng;
    _data['address'] = address;
    _data['mla_id'] = mlaId;
    _data['subject'] = subject;
    _data['description'] = description;
    _data['status_id'] = statusId;
    _data['relation_type'] = relationType;
    _data['relation_name'] = relationName;
    _data['relation_epic'] = relationEpic;
    _data['relation_mobile'] = relationMobile;
    _data['created_by'] = createdBy;
    _data['created_at'] = createdAt;
    _data['last_modified_by'] = lastModifiedBy;
    _data['updated_at'] = updatedAt;
    _data['entity_status'] = entityStatus;
    _data['high_severity'] = highSeverity;
    _data['createType'] = createType;
    _data['complain_status'] = complainStatus;
    _data['complain_date'] = complainDate;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['mobile'] = mobile;
    _data['user_profile_picture'] = userProfilePicture;
    _data['cat_id'] = catId;
    _data['category_name'] = categoryName;
    _data['status'] = status;
    _data['createdbyuser'] = createdbyuser;
    _data['documents'] = documents.map((e)=>e.toJson()).toList();
    _data['comments'] = comments;
    return _data;
  }
}

class Documents {
  Documents({
    required this.docId,
    required this.complaintId,
    required this.docName,
  });
  late var docId;
  late var complaintId;
  late var docName;

  Documents.fromJson(Map<String, dynamic> json){
    docId = json['doc_id'];
    complaintId = json['complaint_id'];
    docName = json['doc_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['doc_id'] = docId;
    _data['complaint_id'] = complaintId;
    _data['doc_name'] = docName;
    return _data;
  }
}