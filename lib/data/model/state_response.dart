class StateResponse {
  StateResponse({
    required this.statusCode,
    required this.statusText,
    required this.message,
    required this.data,
  });
  late final int statusCode;
  late final String statusText;
  late final String message;
  late final List<StateData> data;

  StateResponse.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    statusText = json['status_text'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>StateData.fromJson(e)).toList();
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

class StateData {
  StateData({
    required this.id,
    required this.CountryId,
    required this.StateName,
  });
  late var  id;
  late var CountryId;
  late var StateName;

  StateData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    CountryId = json['CountryId'];
    StateName = json['StateName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['CountryId'] = CountryId;
    _data['StateName'] = StateName;
    return _data;
  }
}