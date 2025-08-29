class ProfileModel {
  ProfileModel({
    required this.statusCode,
    required this.statusText,
    required this.message,
    required this.data,
  });
  late final int statusCode;
  late final String statusText;
  late final String message;
  late final ProfileData data;

  ProfileModel.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    statusText = json['status_text'];
    message = json['message'];
    data = ProfileData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['status_text'] = statusText;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class ProfileData {
  ProfileData({
    required this.id,
    required this.selfReferralCode,
    required this.roleId,
    required this.email,
    required this.mobile,
    required this.userProfilePicture,
    required this.gender,
    required this.dateOfBirth,
    required this.idCardNo,
    required this.facebookProfileUrl,
    required this.facebookEditable,
    required this.twitterProfileUrl,
    required this.twitterEditable,
    required this.instagramProfileUrl,
    required this.instagramEditable,
    required this.youtubeProfileUrl,
    required this.youtubeEditable,
    required this.entityStatus,
    required this.fullName,
    required this.rolename,
    required this.mpConstituency,
    required this.mpConstituencyId,
    required this.mlaAssembly,
    required this.mlaAssemblyId,
    required this.districtId,
    required this.districtName,
    required this.sateName,
    required this.sateId,
    required this.boothNumber,
    required this.rname,
    required this.rtype,
    required this.marriageAnniversary,
    required this.relationWithWorker,
    required this.sno,
    required this.poolingStationName,
    required this.category,
    required this.age,
    required this.houseNo,
    required this.address,
    required this.workerType,
    required this.followers,
    required this.following,
    required this.referralCode,
    required this.totalCount,
    required this.todayCount,
    required this.tweets,
  });
  late var id;
  late var selfReferralCode;
  late var roleId;
  late var email;
  late var mobile;
  late var userProfilePicture;
  late var gender;
  late var dateOfBirth;
  late var idCardNo;
  late var facebookProfileUrl;
  late var facebookEditable;
  late var twitterProfileUrl;
  late var twitterEditable;
  late var instagramProfileUrl;
  late var instagramEditable;
  late var youtubeProfileUrl;
  late var youtubeEditable;
  late var entityStatus;
  late var fullName;
  late var rolename;
  late var mpConstituency;
  late var mpConstituencyId;
  late var mlaAssembly;
  late var mlaAssemblyId;
  late var districtId;
  late var districtName;
  late var sateName;
  late var sateId;
  late var boothNumber;
  late var rname;
  late var rtype;
  late var marriageAnniversary;
  late var relationWithWorker;
  late var sno;
  late var poolingStationName;
  late var category;
  late var age;
  late var houseNo;
  late var address;
  late var workerType;
  late var followers;
  late var following;
  late final List<ReferralCode> referralCode;
  late var totalCount;
  late var todayCount;
  late var tweets;

  ProfileData.fromJson(Map<String, dynamic> json){
    id = json['id']??"";
    selfReferralCode = json['self_referral_code']??"";
    roleId = json['role_id']??"";
    email = json['email']??"";
    mobile = json['mobile']??"";
    userProfilePicture = json['user_profile_picture']??"";
    gender = json['gender']??"";
    dateOfBirth = json['date_of_birth']??"";
    idCardNo = json['id_card_no']??"";
    facebookProfileUrl = json['facebook_profile_url']??"";
    facebookEditable = json['facebook_editable']??"";
    twitterProfileUrl = json['twitter_profile_url']??"";
    twitterEditable = json['twitter_editable']??"";
    instagramProfileUrl = json['instagram_profile_url']??"";
    instagramEditable = json['instagram_editable']??"";
    youtubeProfileUrl = json['youtube_profile_url']??"";
    youtubeEditable = json['youtube_editable']??"";
    entityStatus = json['entity_status']??"";
    fullName = json['full_name']??"";
    rolename = json['rolename']??"";
    mpConstituency = json['mp_constituency']??"";
    mpConstituencyId = json['mp_constituency_id']??"";
    mlaAssembly = json['mla_assembly']??"";
    mlaAssemblyId = json['mla_assembly_id']??"";
    districtId = json['district_id']??"";
    districtName = json['district_name']??"";
    sateName = json['sate_name']??"";
    sateId = json['sate_id']??"";
    boothNumber = json['booth_number']??"";
    rname = json['rname']??"";
    rtype = json['rtype']??"";
    marriageAnniversary = json['marriage_anniversary']??"";
    relationWithWorker = json['relation_with_worker']??"";
    sno = json['sno']??"";
    poolingStationName = json['pooling_station_name']??"";
    category = json['category']??"";
    age = json['age']??"";
    houseNo = json['house_no']??"";
    address = json['address']??"";
    workerType = json['worker_type']??"";
    followers = json['followers']??0;
    following = json['following']??0;
    referralCode = List.from(json['referral_code']??[]).map((e)=>ReferralCode.fromJson(e)).toList();
    totalCount = json['total_count']??0;
    todayCount = json['today_count']??0;
    tweets = json['tweets']??"";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['self_referral_code'] = selfReferralCode;
    _data['role_id'] = roleId;
    _data['email'] = email;
    _data['mobile'] = mobile;
    _data['user_profile_picture'] = userProfilePicture;
    _data['gender'] = gender;
    _data['date_of_birth'] = dateOfBirth;
    _data['id_card_no'] = idCardNo;
    _data['facebook_profile_url'] = facebookProfileUrl;
    _data['facebook_editable'] = facebookEditable;
    _data['twitter_profile_url'] = twitterProfileUrl;
    _data['twitter_editable'] = twitterEditable;
    _data['instagram_profile_url'] = instagramProfileUrl;
    _data['instagram_editable'] = instagramEditable;
    _data['youtube_profile_url'] = youtubeProfileUrl;
    _data['youtube_editable'] = youtubeEditable;
    _data['entity_status'] = entityStatus;
    _data['full_name'] = fullName;
    _data['rolename'] = rolename;
    _data['mp_constituency'] = mpConstituency;
    _data['mp_constituency_id'] = mpConstituencyId;
    _data['mla_assembly'] = mlaAssembly;
    _data['mla_assembly_id'] = mlaAssemblyId;
    _data['district_id'] = districtId;
    _data['district_name'] = districtName;
    _data['sate_name'] = sateName;
    _data['sate_id'] = sateId;
    _data['booth_number'] = boothNumber;
    _data['rname'] = rname;
    _data['rtype'] = rtype;
    _data['marriage_anniversary'] = marriageAnniversary;
    _data['relation_with_worker'] = relationWithWorker;
    _data['sno'] = sno;
    _data['pooling_station_name'] = poolingStationName;
    _data['category'] = category;
    _data['age'] = age;
    _data['house_no'] = houseNo;
    _data['address'] = address;
    _data['worker_type'] = workerType;
    _data['followers'] = followers;
    _data['following'] = following;
    _data['referral_code'] = referralCode.map((e)=>e.toJson()).toList();
    _data['total_count'] = totalCount;
    _data['today_count'] = todayCount;
    _data['tweets'] = tweets;
    return _data;
  }
}

class ReferralCode {
  ReferralCode({
    required this.workerId,
    required this.referralCode,
    required this.userProfilePicture,
    required this.fullName,
  });
  late var workerId;
  late var referralCode;
  late var userProfilePicture;
  late var fullName;

  ReferralCode.fromJson(Map<String, dynamic> json){
    workerId = json['worker_id'];
    referralCode = json['referral_code'];
    userProfilePicture = json['user_profile_picture'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['worker_id'] = workerId;
    _data['referral_code'] = referralCode;
    _data['user_profile_picture'] = userProfilePicture;
    _data['full_name'] = fullName;
    return _data;
  }
}