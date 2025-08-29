class MyEpicDataModel {
  MyEpicDataModel({
    required this.status,
    required this.message,
    required this.data,
  });
  late final int status;
  late final String message;
  late final EpicData data;

  MyEpicDataModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = EpicData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class EpicData {
  EpicData({
    required this.id,
    required this.userDetailFileId,
    required this.stateId,
    required this.districtId,
    required this.mpConstituencyId,
    required this.mlaAssemblyId,
    required this.boothNumber,
    required this.sno,
    required this.firstName,
    required this.rname,
    required this.mobile,
    required this.alternateMobileNo,
    required this.userProfilePicture,
    required this.gender,
    required this.rtype,
    required this.age,
    required this.idCardNo,
    required this.houseNo,
    required this.address,
    required this.poolingStationName,
    this.newIdcardno,
    this.wardNo,
    required this.dateOfBirth,
    required this.marriageAnniversary,
    required this.fbUsername,
    required this.twitterUsername,
    required this.instaUsername,
    required this.email,
    required this.party,
    required this.category,
    required this.relationWithWorker,
    required this.voteStatus,
    required this.posterDeliveryStatus,
    required this.cast,
    required this.subcast,
    required this.tehseel,
    this.taggedWorker,
    required this.surveyCode,
    this.createdBy,
    required this.createdAt,
    this.lastModifiedBy,
    this.updatedAt,
    this.deletedAt,
    required this.entityStatus,
    this.epic,
    required this.voteDone,
    required this.isWorkerVoter,
    required this.selfVoter,
    required this.pointVoter,
    required this.assignedWorkerId,
  });
  late var id;
  late var userDetailFileId;
  late var stateId;
  late var districtId;
  late var mpConstituencyId;
  late var mlaAssemblyId;
  late var boothNumber;
  late var sno;
  late var firstName;
  late var rname;
  late var mobile;
  late var alternateMobileNo;
  late var userProfilePicture;
  late var gender;
  late var rtype;
  late var age;
  late var idCardNo;
  late var houseNo;
  late var address;
  late var poolingStationName;
  late var newIdcardno;
  late var wardNo;
  late var dateOfBirth;
  late var marriageAnniversary;
  late var fbUsername;
  late var twitterUsername;
  late var instaUsername;
  late var email;
  late var party;
  late var category;
  late var relationWithWorker;
  late var voteStatus;
  late var posterDeliveryStatus;
  late var cast;
  late var subcast;
  late var tehseel;
  late var taggedWorker;
  late var surveyCode;
  late var createdBy;
  late var createdAt;
  late var lastModifiedBy;
  late var updatedAt;
  late var deletedAt;
  late var entityStatus;
  late var epic;
  late var voteDone;
  late var isWorkerVoter;
  late var selfVoter;
  late var pointVoter;
  late var assignedWorkerId;

  EpicData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userDetailFileId = json['user_detail_file_id'];
    stateId = json['stateId'];
    districtId = json['district_id'];
    mpConstituencyId = json['mp_constituency_id'];
    mlaAssemblyId = json['mla_assembly_id'];
    boothNumber = json['booth_number']??"";
    sno = json['sno'];
    firstName = json['first_name']??"";
    rname = json['rname'];
    mobile = json['mobile'];
    alternateMobileNo = json['alternate_mobile_no'];
    userProfilePicture = json['user_profile_picture'];
    gender = json['gender'];
    rtype = json['rtype'];
    age = json['age'];
    idCardNo = json['id_card_no'];
    houseNo = json['house_no']??"";
    address = json['address']??"";
    poolingStationName = json['pooling_station_name']??"";
    newIdcardno = json["new_idcardno"];
    wardNo = json["ward_no"];
    dateOfBirth = json['date_of_birth'];
    marriageAnniversary = json['marriage_anniversary'];
    fbUsername = json['fb_username'];
    twitterUsername = json['twitter_username'];
    instaUsername = json['insta_username'];
    email = json['email'];
    party = json['party'];
    category = json['category'];
    relationWithWorker = json['relation_with_worker'];
    voteStatus = json['vote_status'];
    posterDeliveryStatus = json['poster_delivery_status'];
    cast = json['cast'];
    subcast = json['subcast'];
    stateId = json['state_id'];
    tehseel = json['tehseel'];
    taggedWorker = null;
    surveyCode = json['survey_code'];
    createdBy = null;
    createdAt = json['created_at'];
    lastModifiedBy = null;
    updatedAt = null;
    deletedAt = null;
    entityStatus = json['entity_status'];
    epic = json['epic']??"";
    voteDone = json['vote_done'];
    isWorkerVoter = json['is_worker_voter'];
    selfVoter = json['self_voter'];
    pointVoter = json['point_voter'];
    assignedWorkerId = json['assigned_worker_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_detail_file_id'] = userDetailFileId;
    _data['stateId'] = stateId;
    _data['district_id'] = districtId;
    _data['mp_constituency_id'] = mpConstituencyId;
    _data['mla_assembly_id'] = mlaAssemblyId;
    _data['booth_number'] = boothNumber;
    _data['sno'] = sno;
    _data['first_name'] = firstName;
    _data['rname'] = rname;
    _data['mobile'] = mobile;
    _data['alternate_mobile_no'] = alternateMobileNo;
    _data['user_profile_picture'] = userProfilePicture;
    _data['gender'] = gender;
    _data['rtype'] = rtype;
    _data['age'] = age;
    _data['id_card_no'] = idCardNo;
    _data['house_no'] = houseNo;
    _data['address'] = address;
    _data['pooling_station_name'] = poolingStationName;
    _data['new_idcardno'] = newIdcardno;
    _data['ward_no'] = wardNo;
    _data['date_of_birth'] = dateOfBirth;
    _data['marriage_anniversary'] = marriageAnniversary;
    _data['fb_username'] = fbUsername;
    _data['twitter_username'] = twitterUsername;
    _data['insta_username'] = instaUsername;
    _data['email'] = email;
    _data['party'] = party;
    _data['category'] = category;
    _data['relation_with_worker'] = relationWithWorker;
    _data['vote_status'] = voteStatus;
    _data['poster_delivery_status'] = posterDeliveryStatus;
    _data['cast'] = cast;
    _data['subcast'] = subcast;
    _data['state_id'] = stateId;
    _data['tehseel'] = tehseel;
    _data['tagged_worker'] = taggedWorker;
    _data['survey_code'] = surveyCode;
    _data['created_by'] = createdBy;
    _data['created_at'] = createdAt;
    _data['last_modified_by'] = lastModifiedBy;
    _data['updated_at'] = updatedAt;
    _data['deleted_at'] = deletedAt;
    _data['entity_status'] = entityStatus;
    _data['epic'] = epic;
    _data['vote_done'] = voteDone;
    _data['is_worker_voter'] = isWorkerVoter;
    _data['self_voter'] = selfVoter;
    _data['point_voter'] = pointVoter;
    _data['assigned_worker_id'] = assignedWorkerId;
    return _data;
  }
}