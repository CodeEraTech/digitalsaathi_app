class SurveyResponse {
  SurveyResponse({
    required this.statusCode,
    required this.statusText,
    required this.message,
    required this.data,
  });
  late final int statusCode;
  late final String statusText;
  late final String message;
  late final List<SurveyData> data;

  SurveyResponse.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    statusText = json['status_text'];
    message = json['message'];
    data = List.from(json['data']).map((e)=>SurveyData.fromJson(e)).toList();
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

class SurveyData {
  SurveyData({
    required this.surveyId,
    required this.surveyName,
    required this.worker,
  });
  late var surveyId;
  late var surveyName;
  late final List<Worker> worker;

  SurveyData.fromJson(Map<String, dynamic> json){
    surveyId = json['survey_id'];
    surveyName = json['survey_name'];
    worker = List.from(json['worker']??[]).map((e)=>Worker.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['survey_id'] = surveyId;
    _data['survey_name'] = surveyName;
    _data['worker'] = worker.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Worker {
  Worker({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.todayVoters,
    required this.totalVoters,
    required this.voters,
  });
  late var id;
  late var firstName;
  late var lastName;
  late var mobile;
  late var todayVoters;
  late var totalVoters;
  late final List<Voters> voters;

  Worker.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    todayVoters = json['today_voters'];
    totalVoters = json['total_voters'];
    voters = List.from(json['voters']??[]).map((e)=>Voters.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['mobile'] = mobile;
    _data['today_voters'] = todayVoters;
    _data['total_voters'] = totalVoters;
    _data['voters'] = voters.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Voters {
  Voters({
    required this.id,
    required this.surveyTypeId,
    required this.surveyQuestionId,
    required this.questionTypeId,
    required this.questionAnswer,
    required this.createrId,
    required this.createdBy,
    required this.createdAt,
    required this.lastModifiedBy,
    required this.updatedAt,
    required this.entityStatus,
    required this.firstName,
    required this.rname,
    required this.mobile,
    required this.boothNumber,
    required this.epicNumber,
  });
  late var id;
  late var surveyTypeId;
  late var surveyQuestionId;
  late var questionTypeId;
  late var questionAnswer;
  late var createrId;
  late var createdBy;
  late var createdAt;
  late var lastModifiedBy;
  late var updatedAt;
  late var entityStatus;
  late var firstName;
  late var rname;
  late var mobile;
  late var boothNumber;
  late var epicNumber;

  Voters.fromJson(Map<String, dynamic> json){
    id = json['id'];
    surveyTypeId = json['survey_type_id'];
    surveyQuestionId = json['survey_question_id'];
    questionTypeId = json['question_type_id'];
    questionAnswer = json['question_answer'];
    createrId = json['creater_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    lastModifiedBy = json['last_modified_by'];
    updatedAt = json['updated_at'];
    entityStatus = json['entity_status'];
    firstName = json['first_name'];
    rname = json['rname'];
    mobile = json['mobile'];
    boothNumber = json['booth_number'];
    epicNumber = json['epic_number'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['survey_type_id'] = surveyTypeId;
    _data['survey_question_id'] = surveyQuestionId;
    _data['question_type_id'] = questionTypeId;
    _data['question_answer'] = questionAnswer;
    _data['creater_id'] = createrId;
    _data['created_by'] = createdBy;
    _data['created_at'] = createdAt;
    _data['last_modified_by'] = lastModifiedBy;
    _data['updated_at'] = updatedAt;
    _data['entity_status'] = entityStatus;
    _data['first_name'] = firstName;
    _data['rname'] = rname;
    _data['mobile'] = mobile;
    _data['booth_number'] = boothNumber;
    _data['epic_number'] = epicNumber;
    return _data;
  }
}