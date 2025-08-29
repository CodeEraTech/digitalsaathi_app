class LoginModel {
  LoginModel({
    required this.id,
    required this.roleId,
    required this.email,
    required this.firstName,
    required this.mobile,
    required this.isMobileVerified,
    required this.userProfilePicture,
    required this.gender,
    required this.dateOfBirth,
    required this.referralCode,
    required this.facebookProfileUrl,
    required this.twitterProfileUrl,
    required this.instagramProfileUrl,
    required this.youtubeProfileUrl,
    required this.entityStatus,
    required this.workerType,
    required this.mlaAssemblyId,
    required this.mpConstituencyId,
    required this.socialProfileCompletionStatus,
    required this.authkey,
    required this.statusCode,
    required this.statusText,
    this.primaryFontSize,
    this.secondaryFontSize,
    this.message,
  });
  late var id;
  late var roleId;
  late var email;
  late var firstName;
  late var mobile;
  late var isMobileVerified;
  late var userProfilePicture;
  late var gender;
  late var dateOfBirth;
  late var referralCode;
  late var facebookProfileUrl;
  late var twitterProfileUrl;
  late var instagramProfileUrl;
  late var youtubeProfileUrl;
  late var entityStatus;
  late var workerType;
  late var mlaAssemblyId;
  late var mpConstituencyId;
  late var socialProfileCompletionStatus;
  late var authkey;
  late var statusCode;
  late var statusText;
  late var primaryFontSize;
  late var secondaryFontSize;

  late final Null message;

  LoginModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    roleId = json['role_id'];
    email = json['email'];
    firstName = json['first_name'];
    mobile = json['mobile'];
     isMobileVerified = json['is_mobile_verified'];
    userProfilePicture = json['user_profile_picture'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    referralCode = json['referral_code'];
    facebookProfileUrl = json['facebook_profile_url'];
    twitterProfileUrl = json['twitter_profile_url'];
    instagramProfileUrl = json['instagram_profile_url'];
    youtubeProfileUrl = json['youtube_profile_url'];
    entityStatus = json['entity_status'];
    workerType = json['worker_type'];
    mlaAssemblyId = json['mla_assembly_id'];
    mpConstituencyId = json['mp_constituency_id'];
    socialProfileCompletionStatus = json['social_profile_completion_status'];
    authkey = json['authkey'];
    statusCode = json['status_code'];
    statusText = json['status_text'];
    primaryFontSize = json['primary_font_size'];
    secondaryFontSize = json['secondry_font_size'];
    message = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['role_id'] = roleId;
    _data['email'] = email;
    _data['first_name'] = firstName;
    _data['mobile'] = mobile;
    _data['is_mobile_verified'] = isMobileVerified;
    _data['user_profile_picture'] = userProfilePicture;
    _data['gender'] = gender;
    _data['date_of_birth'] = dateOfBirth;
    _data['referral_code'] = referralCode;
    _data['facebook_profile_url'] = facebookProfileUrl;
    _data['twitter_profile_url'] = twitterProfileUrl;
    _data['instagram_profile_url'] = instagramProfileUrl;
    _data['youtube_profile_url'] = youtubeProfileUrl;
    _data['entity_status'] = entityStatus;
    _data['worker_type'] = workerType;
    _data['mla_assembly_id'] = mlaAssemblyId;
    _data['mp_constituency_id'] = mpConstituencyId;
    _data['social_profile_completion_status'] = socialProfileCompletionStatus;
    _data['authkey'] = authkey;
    _data['status_code'] = statusCode;
    _data['status_text'] = statusText;
    _data['message'] = message;
    _data['primary_font_size'] = primaryFontSize;
    _data['secondry_font_size'] = secondaryFontSize;
    return _data;
  }
}

