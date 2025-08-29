class DistrictResponse {
  DistrictResponse({
    required this.statusCode,
    required this.statusText,
    required this.message,
    required this.data,
  });
  late final int statusCode;
  late final String statusText;
  late final String message;
  late final List<DistrictData> data;

  DistrictResponse.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    statusText = json['status_text'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>DistrictData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['status_text'] = statusText;
    _data['message'] = message;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class DistrictData {
  DistrictData({
    required this.id,
    required this.stateId,
    required this.name,
  });
  late var id;
  late var stateId;
  late var name;

  DistrictData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    stateId = json['state_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['state_id'] = stateId;
    _data['name'] = name;
    return _data;
  }
}