class MeetingDetailResponse {
  MeetingDetailResponse({
    required this.statusCode,
    required this.statusText,
    required this.message,
    required this.data,
  });
  late final int statusCode;
  late final String statusText;
  late final String message;
  late final MeetingDetailData data;

  MeetingDetailResponse.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    statusText = json['status_text'];
    message = json['message'];
    data = MeetingDetailData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['status_text'] = statusText;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class MeetingDetailData {
  MeetingDetailData({
    required this.id,
    required this.meetingAgenda,
    required this.meetingDate,
    required this.meetingTime,
    required this.meetingBannerImage,
    required this.description,
    //required this.createdAt,
    required this.participants,
    required this.review,
    required this.report,
  });
  late var id;
  late var meetingAgenda;
  late var meetingDate;
  late var meetingTime;
  late var meetingBannerImage;
  late var description;
  //late final CreatedAt createdAt;
  late final List<Participants> participants;
  late final List<Review> review;
  late final Report report;

  MeetingDetailData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    meetingAgenda = json['meeting_agenda'];
    meetingDate = json['meeting_date'];
    meetingTime = json['meeting_time'];
    meetingBannerImage = json['meeting_banner_image']??'';
    description = json['description'];
    //createdAt = CreatedAt.fromJson(json['created_at']);
    participants = List.from(json['participants']).map((e)=>Participants.fromJson(e)).toList();
    review = List.from(json['review']).map((e)=>Review.fromJson(e)).toList();
    report = Report.fromJson(json['report']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['meeting_agenda'] = meetingAgenda;
    _data['meeting_date'] = meetingDate;
    _data['meeting_time'] = meetingTime;
    _data['meeting_banner_image'] = meetingBannerImage;
    _data['description'] = description;
   // _data['created_at'] = createdAt.toJson();
    _data['participants'] = participants.map((e)=>e.toJson()).toList();
    _data['review'] = review.map((e)=>e.toJson()).toList();
    _data['report'] = report.toJson();
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
  late  var timezoneType;
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

class Participants {
  Participants({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.fatherName,
    required this.gender,
    required this.cast,
    required this.subcast,
    required this.rtype,
    required this.age,
    required this.idCardNo,
    required this.houseNo,
    required this.address,
    required this.designation,
    required this.wardNo,
    required this.attandance,
  });
  late var id;
  late var name;
  late var mobile;
  late var email;
  late var fatherName;
  late var gender;
  late var cast;
  late var subcast;
  late var rtype;
  late var age;
  late var idCardNo;
  late var houseNo;
  late var address;
  late var designation;
  late var wardNo;
  late var attandance;

  Participants.fromJson(Map<String, dynamic> json){
    id = json['id']??'';
    name = json['name']??'';
    mobile = json['mobile']??'';
    email = json['email']??'';
    fatherName = json['father_name']??'';
    gender = json['gender']??'';
    cast = json['cast']??'';
    subcast = json['subcast']??'';
    rtype = json['rtype']??'';
    age = json['age']??'';
    idCardNo = json['id_card_no']??'';
    houseNo = json['house_no']??'';
    address = json['address']??'';
    designation = json['designation']??'';
    wardNo = json['ward_no']??'';
    attandance = json['attandance']??'';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['mobile'] = mobile;
    _data['email'] = email;
    _data['father_name'] = fatherName;
    _data['gender'] = gender;
    _data['cast'] = cast;
    _data['subcast'] = subcast;
    _data['rtype'] = rtype;
    _data['age'] = age;
    _data['id_card_no'] = idCardNo;
    _data['house_no'] = houseNo;
    _data['address'] = address;
    _data['designation'] = designation;
    _data['ward_no'] = wardNo;
    _data['attandance'] = attandance;
    return _data;
  }
}
class Review {
  Review({
    required this.id,
    required this.meetingId,
    required this.message,
    required this.photos,
  });
  late var id;
  late var meetingId;
  late String message;
  late final List<dynamic> photos;

  Review.fromJson(Map<String, dynamic> json){
    id = json['id'];
    meetingId = json['meeting_id'];
    message = json['message'];
    photos = List.castFrom<dynamic, dynamic>(json['photos']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['meeting_id'] = meetingId;
    _data['message'] = message;
    _data['photos'] = photos;
    return _data;
  }
}

class Report {
  Report({
    required this.totalParticipants,
    required this.totalNewParticipants,
    required this.totalAbsent,
    required this.totalPresent,
    required this.totalNotMarked,
  });
  late var totalParticipants;
  late var totalNewParticipants;
  late var totalAbsent;
  late var totalPresent;
  late var totalNotMarked;

  Report.fromJson(Map<String, dynamic> json){
    totalParticipants = json['total_participants'];
    totalNewParticipants = json['total_new_participants'];
    totalAbsent = json['total_absent'];
    totalPresent = json['total_present'];
    totalNotMarked = json['total_not_marked'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total_participants'] = totalParticipants;
    _data['total_new_participants'] = totalNewParticipants;
    _data['total_absent'] = totalAbsent;
    _data['total_present'] = totalPresent;
    _data['total_not_marked'] = totalNotMarked;
    return _data;
  }
}