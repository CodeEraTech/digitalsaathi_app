class IDCardModel {
  IDCardModel({
    required this.statusCode,
    required this.statusText,
    required this.data,
  });
  late final int statusCode;
  late final String statusText;
  late final CardData data;

  IDCardModel.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    statusText = json['status_text'];
    data = CardData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['status_text'] = statusText;
    _data['data'] = data.toJson();
    return _data;
  }
}

class CardData {
  CardData({
    required this.email,
    required this.firstName,
    required this.mobile,
    required this.profilePicturePresent,
    required this.userProfilePicture,
    required this.addressLine1,
    required this.addressLine2,
    required this.districtName,
    required this.boothNumber,
    required this.assemblyName,
    required this.parentUserId,
    required this.workerCategory,
    required this.mlaName,
    required this.headerTemplate,
    required this.footerTemplate,
  });
  late var email;
  late var firstName;
  late var mobile;
  late var profilePicturePresent;
  late var userProfilePicture;
  late var addressLine1;
  late var addressLine2;
  late var districtName;
  late var boothNumber;
  late var assemblyName;
  late  var parentUserId;
  late var workerCategory;
  late var mlaName;
  late var headerTemplate;
  late var footerTemplate;

  CardData.fromJson(Map<String, dynamic> json){
    email = json['email'];
    firstName = json['first_name'];
    mobile = json['mobile'];
    profilePicturePresent = json['profile_picture_present'];
    userProfilePicture = json['user_profile_picture']??"";
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    districtName = json['district_name'];
    boothNumber = json['booth_number'];
    assemblyName = json['assembly_name'];
    parentUserId = json['parent_user_id'];
    workerCategory = json['worker_category'];
    mlaName = json['mla_name'];
    headerTemplate = json['header_template'];
    footerTemplate = json['footer_template'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['first_name'] = firstName;
    _data['mobile'] = mobile;
    _data['profile_picture_present'] = profilePicturePresent;
    _data['user_profile_picture'] = userProfilePicture;
    _data['address_line1'] = addressLine1;
    _data['address_line2'] = addressLine2;
    _data['district_name'] = districtName;
    _data['booth_number'] = boothNumber;
    _data['assembly_name'] = assemblyName;
    _data['parent_user_id'] = parentUserId;
    _data['worker_category'] = workerCategory;
    _data['mla_name'] = mlaName;
    _data['header_template'] = headerTemplate;
    _data['footer_template'] = footerTemplate;
    return _data;
  }
}