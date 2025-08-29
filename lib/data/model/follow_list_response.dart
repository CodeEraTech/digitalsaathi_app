class FollowMLAListResponse {
  FollowMLAListResponse({
    required this.data,
    required this.statusCode,
    required this.statusText,
    required this.message,
  });
  late final List<FollowMlaData> data;
  late final int statusCode;
  late final String statusText;
  late final String message;

  FollowMLAListResponse.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>FollowMlaData.fromJson(e)).toList();
    statusCode = json['status_code'];
    statusText = json['status_text'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['status_code'] = statusCode;
    _data['status_text'] = statusText;
    _data['message'] = message;
    return _data;
  }
}

class FollowMlaData {
  FollowMlaData({
    required this.id,
    required this.name,
    required this.mobile,
    required this.userProfilePicture,
    required this.gender,
    required this.districtName,
    required this.userType,
    required this.roleId,
    required this.followers,
    required this.isReferral,
    required this.followed,
  });
  late var id;
  late var name;
  late var mobile;
  late var userProfilePicture;
  late var gender;
  late var districtName;
  late var userType;
  late var roleId;
  late var followers;
  late var isReferral;
  late var followed;

  FollowMlaData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    userProfilePicture = json["user_profile_picture"]??"";
    gender = json['gender'];
    districtName = json['district_name'];
    userType = json['user_type'];
    roleId = json['role_id'];
    followers = json['followers'];
    isReferral = json['is_referral'];
    followed = json['followed'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['mobile'] = mobile;
    _data['user_profile_picture'] = userProfilePicture;
    _data['gender'] = gender;
    _data['district_name'] = districtName;
    _data['user_type'] = userType;
    _data['role_id'] = roleId;
    _data['followers'] = followers;
    _data['is_referral'] = isReferral;
    _data['followed'] = followed;
    return _data;
  }
}