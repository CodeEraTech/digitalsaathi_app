class MeetingReportResponse {
  MeetingReportResponse({
    required this.statusCode,
    required this.statusText,
    required this.message,
    required this.data,
  });
  late var statusCode;
  late var statusText;
  late var message;
  late final MeetingReportData data;

  MeetingReportResponse.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    statusText = json['status_text'];
    message = json['message'];
    data = MeetingReportData.fromJson(json['data']);
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

class MeetingReportData {
  MeetingReportData({
    required this.totalMeeting,
    required this.totalParticipants,
    required this.totalNewParticipants,
    required this.totalAbsent,
    required this.totalPresent,
    required this.totalNotMarked,
    required this.totalCompleteMeeting,
  });
  late var totalMeeting;
  late var totalParticipants;
  late var totalNewParticipants;
  late var totalAbsent;
  late var totalPresent;
  late var totalNotMarked;
  late var totalCompleteMeeting;

  MeetingReportData.fromJson(Map<String, dynamic> json){
    totalMeeting = json['total_meeting'];
    totalParticipants = json['total_participants'];
    totalNewParticipants = json['total_new_participants'];
    totalAbsent = json['total_absent'];
    totalPresent = json['total_present'];
    totalNotMarked = json['total_not_marked'];
    totalCompleteMeeting = json['total_complete_meeting'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total_meeting'] = totalMeeting;
    _data['total_participants'] = totalParticipants;
    _data['total_new_participants'] = totalNewParticipants;
    _data['total_absent'] = totalAbsent;
    _data['total_present'] = totalPresent;
    _data['total_not_marked'] = totalNotMarked;
    _data['total_complete_meeting'] = totalCompleteMeeting;
    return _data;
  }
}