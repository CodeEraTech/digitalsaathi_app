class UserProgressResponse {
  UserProgressResponse({
    required this.statusCode,
    required this.statusText,
    required this.data,
    required this.totalData,
  });
  late final int statusCode;
  late final String statusText;
  late final List<UserProgressData> data;
  late final int totalData;

  UserProgressResponse.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    statusText = json['status_text'];
    data = List.from(json['data']).map((e)=>UserProgressData.fromJson(e)).toList();
    totalData = json['total_data'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['status_text'] = statusText;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['total_data'] = totalData;
    return _data;
  }
}

class UserProgressData {
  UserProgressData({
    required this.id,
    required this.firstName,
    required this.categoryId,
    required this.userProfilePicture,
    required this.profilePicturePresent,
    required this.roleId,
    required this.mobile,
    required this.todayHierarchy,
    required this.todayNonHierarchy,
    required this.totalHierarchy,
    required this.totalNonHierarchy,
    required this.grandTotal,
    required this.backgroundColor,
    required this.color,
  });
  late var id;
  late var firstName;
  late var categoryId;
  late var userProfilePicture;
  late var profilePicturePresent;
  late var roleId;
  late var mobile;
  late var todayHierarchy;
  late var todayNonHierarchy;
  late var totalHierarchy;
  late var totalNonHierarchy;
  late var grandTotal;
  late var backgroundColor;
  late var color;

  UserProgressData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstName = json['first_name'];
    categoryId = json['category_id'];
    userProfilePicture = json['user_profile_picture']??"";
    profilePicturePresent = json['profile_picture_present']??"";
    roleId = json['role_id'];
    mobile = json['mobile'];
    todayHierarchy = json['today_hierarchy'];
    todayNonHierarchy = json['today_non_hierarchy'];
    totalHierarchy = json['total_hierarchy'];
    totalNonHierarchy = json['total_non_hierarchy'];
    grandTotal = json['grand_total']??"";
    backgroundColor = json['background_color'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['category_id'] = categoryId;
    _data['user_profile_picture'] = userProfilePicture;
    _data['profile_picture_present'] = profilePicturePresent;
    _data['role_id'] = roleId;
    _data['mobile'] = mobile;
    _data['today_hierarchy'] = todayHierarchy;
    _data['today_non_hierarchy'] = todayNonHierarchy;
    _data['total_hierarchy'] = totalHierarchy;
    _data['total_non_hierarchy'] = totalNonHierarchy;
    _data['grand_total'] = grandTotal;
    _data['background_color'] = backgroundColor;
    _data['color'] = color;
    return _data;
  }
}