class LeadersResponse {
  LeadersResponse({
    required this.status,
    required this.message,
    required this.data,
  });
  late final int status;
  late final String message;
  late final List<LeaderData> data;

  LeadersResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>LeaderData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class LeaderData {
  LeaderData({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
    required this.selected,
  });
  late var id;
  late var name;
  late var image;
  late var type;
   bool selected=false;

  LeaderData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
    type = json['type'];
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    _data['type'] = type;
    return _data;
  }
}