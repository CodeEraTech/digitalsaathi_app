class CategoryAndMLAResponse {
  CategoryAndMLAResponse({
    required this.mla,
    required this.category,
    required this.statusCode,
    required this.statusText,
    required this.message,
  });
  late final List<Mla> mla;
  late final List<Category> category;
  late var statusCode;
  late var statusText;
  late var message;

  CategoryAndMLAResponse.fromJson(Map<String, dynamic> json){
    mla = List.from(json['mla']??[]).map((e)=>Mla.fromJson(e)).toList();
    category = List.from(json['category']??[]).map((e)=>Category.fromJson(e)).toList();
    statusCode = json['status_code'];
    statusText = json['status_text'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mla'] = mla.map((e)=>e.toJson()).toList();
    _data['category'] = category.map((e)=>e.toJson()).toList();
    _data['status_code'] = statusCode;
    _data['status_text'] = statusText;
    _data['message'] = message;
    return _data;
  }
}

class Mla {
  Mla({
    required this.id,
    required this.name,
    required this.mobile,
    required this.userProfilePicture,
    required this.gender,
    required this.districtName,
    required this.userType,
    required this.roleId,
    required this.followers,
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
  late var followed;

  Mla.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    userProfilePicture = json['user_profile_picture'];
    gender = json['gender'];
    districtName = json['district_name'];
    userType = json['user_type'];
    roleId = json['role_id'];
    followers = json['followers'];
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
    _data['followed'] = followed;
    return _data;
  }
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.entityStatus,
  });
  late  var id;
  late  var name;
  late  var entityStatus;

  Category.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    entityStatus = json['entity_status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['entity_status'] = entityStatus;
    return _data;
  }
}