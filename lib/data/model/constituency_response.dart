class ConstituencyResponse {
  ConstituencyResponse({
    required this.data,
    required this.statusCode,
    required this.statusText,
    required this.message,
  });
  late final List<ConstituencyData> data;
  late final int statusCode;
  late final String statusText;
  late final String message;

  ConstituencyResponse.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>ConstituencyData.fromJson(e)).toList();
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

class ConstituencyData {
  ConstituencyData({
    required this.id,
    required this.stateId,
    required this.name,
    required this.districtId,
  });
  late var id;
  late var stateId;
  late var name;
  late var districtId;

  ConstituencyData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    stateId = json['state_id'];
    name = json['name'];
    districtId = json['district_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['state_id'] = stateId;
    _data['name'] = name;
    _data['district_id'] = districtId;
    return _data;
  }
}