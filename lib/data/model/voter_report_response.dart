class VoterReportModel {
  VoterReportModel({
    required this.statusCode,
    required this.statusText,
    required this.message,
    required this.data,
    required this.total,
    required this.lastPage,
  });
  late final int statusCode;
  late final String statusText;
  late final String message;
  late final List<VoterReportData> data;
  late final int total;
  late final int lastPage;

  VoterReportModel.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    statusText = json['status_text'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>VoterReportData.fromJson(e)).toList();
    total = json['total'];
    lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['status_text'] = statusText;
    _data['message'] = message;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['total'] = total;
    _data['lastPage'] = lastPage;
    return _data;
  }
}

class VoterReportData {
  VoterReportData({
    required this.id,
    required this.name,
    this.mobile,
    required this.totalAssignVote,
    required this.todayAssignVote,
  });
  late var  id;
  late var name;
  late var mobile;
  late var totalAssignVote;
  late var todayAssignVote;

  VoterReportData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    mobile = json["mobile"];
    totalAssignVote = json['total_assign_vote'];
    todayAssignVote = json['today_assign_vote'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['mobile'] = mobile;
    _data['total_assign_vote'] = totalAssignVote;
    _data['today_assign_vote'] = todayAssignVote;
    return _data;
  }
}