class PoliticalProfileResponse {
  PoliticalProfileResponse({
    required this.status,
    required this.message,
    required this.data,
  });
  late final int status;
  late final String message;
  late final List<PoliticalProfileData> data;

  PoliticalProfileResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>PoliticalProfileData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class PoliticalProfileData {
  PoliticalProfileData({
    required this.id,
    required this.profileImg,
    required this.symbolId,
    required this.designation,
    required this.partyName,
    required this.evm,
    required this.leaders,
    required this.userId,
    required this.isActive,
    required this.whatsapp,
    required this.facebook,
    required this.twitter,
    required this.updatedAt,
    required this.leaderSymbol,
    required this.name,
    required this.symbols,
  });
  late var id;
  late var profileImg;
  late var symbolId;
  late var designation;
  late var partyName;
  late var evm;
  late final List<Leaders> leaders;
  late var userId;
  late var isActive;
  late var whatsapp;
  late var facebook;
  late var twitter;
  late var updatedAt;
  late var leaderSymbol;
  late var name;
  late final List<Symbols> symbols;

  PoliticalProfileData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    profileImg = json['profile_img']??'';
    symbolId = json['symbol_id']??'';
    designation = json['designation']??'';
    partyName = json['party_name']??'';
    evm = json['evm']??'';
    leaders = List.from(json['leaders']??[]).map((e)=>Leaders.fromJson(e)).toList();
    userId = json['user_id']??'';
    isActive = json['is_active']??'';
    whatsapp = json['whatsapp']??'';
    facebook = json['facebook']??'';
    twitter = json['twitter']??'';
    updatedAt = json['updated_at'];
    leaderSymbol = json['leader_symbol']??"";
    name = json['name'];
    symbols = List.from(json['symbols']??[]).map((e)=>Symbols.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['profile_img'] = profileImg;
    _data['symbol_id'] = symbolId;
    _data['designation'] = designation;
    _data['party_name'] = partyName;
    _data['evm'] = evm;
    _data['leaders'] = leaders.map((e)=>e.toJson()).toList();
    _data['user_id'] = userId;
    _data['is_active'] = isActive;
    _data['whatsapp'] = whatsapp;
    _data['facebook'] = facebook;
    _data['twitter'] = twitter;
    _data['updated_at'] = updatedAt;
    _data['leader_symbol'] = leaderSymbol;
    _data['name'] = name;
    _data['symbols'] = symbols.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Leaders {
  Leaders({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
  });
  late var id;
  late var name;
  late var image;
  late var type;

  Leaders.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
    type = json['type'];
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

class Symbols {
  Symbols({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
  });
  late var id;
  late var name;
  late var image;
  late var type;

  Symbols.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
    type = json['type'];
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