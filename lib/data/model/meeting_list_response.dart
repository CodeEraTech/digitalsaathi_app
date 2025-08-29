class MeetingListResponse {
  MeetingListResponse({
    required this.statusCode,
    required this.statusText,
    required this.message,
    required this.data,
  });
  late final int statusCode;
  late final String statusText;
  late final String message;
  late final List<MeetingData> data;

  MeetingListResponse.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    statusText = json['status_text'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>MeetingData.fromJson(e)).toList();
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

class MeetingData {
  MeetingData({
    required this.id,
    required this.meetingAgenda,
    required this.meetingDate,
    required this.meetingBannerImage,
    required this.meetingTime,
    required this.description,
   // required this.createdAt,
  });
  late var id;
  late var meetingAgenda;
  late var meetingDate;
  late var meetingBannerImage;
  late var meetingTime;
  late var description;
  //late final CreatedAt createdAt;

  MeetingData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    meetingAgenda = json['meeting_agenda'];
    meetingDate = json['meeting_date'];
    meetingBannerImage = json['meeting_banner']??'';
    meetingTime = json['meeting_time'];
    description = json['description'];
    //createdAt = CreatedAt.fromJson(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['meeting_agenda'] = meetingAgenda;
    _data['meeting_date'] = meetingDate;
    _data['meeting_banner'] = meetingBannerImage;
    _data['meeting_time'] = meetingTime;
    _data['description'] = description;
    //_data['created_at'] = createdAt.toJson();
    return _data;
  }
}

class CreatedAt {
  CreatedAt({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });
  late var date;
  late var timezoneType;
  late var timezone;

  CreatedAt.fromJson(Map<String, dynamic> json){
    date = json['date'];
    timezoneType = json['timezone_type'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date;
    _data['timezone_type'] = timezoneType;
    _data['timezone'] = timezone;
    return _data;
  }
}

