class AssemblyResponse {
  AssemblyResponse({
    required this.data,
    required this.statusCode,
    required this.statusText,
    required this.message,
  });
  late final List<AssemblyData> data;
  late final int statusCode;
  late final String statusText;
  late final String message;

  AssemblyResponse.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>AssemblyData.fromJson(e)).toList();
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

class AssemblyData {
  AssemblyData({
    required this.id,
    required this.stateId,
    required this.name,
    required this.districtId,
    required this.mpConstituencyId,
  });
  late var id;
  late var stateId;
  late var name;
  late var districtId;
  late var mpConstituencyId;

  AssemblyData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    stateId = json['state_id'];
    name = json['name'];
    districtId = json['district_id'];
    mpConstituencyId = json['mp_constituency_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['state_id'] = stateId;
    _data['name'] = name;
    _data['district_id'] = districtId;
    _data['mp_constituency_id'] = mpConstituencyId;
    return _data;
  }
}