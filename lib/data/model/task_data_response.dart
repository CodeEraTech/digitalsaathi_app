class TaskModel {
  TaskModel({
    required this.statusCode,
    required this.statusText,
    required this.message,
    required this.data,
  });
  late final int statusCode;
  late  var statusText;
  late  var message;
  late final List<TaskData> data;

  TaskModel.fromJson(Map<String, dynamic> json){
    statusCode = json['status_code'];
    statusText = json['status_text'];
    message = json['message']??"";
    data = List.from(json['data']).map((e)=>TaskData.fromJson(e)).toList();
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

class TaskData {
  TaskData({
    required this.roleId,
    required this.tasks,
  });
  late final int roleId;
  late final List<Tasks> tasks;

  TaskData.fromJson(Map<String, dynamic> json){
    roleId = json['role_id']??0;
    tasks = List.from(json['tasks']??[]).map((e)=>Tasks.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['role_id'] = roleId;
    _data['tasks'] = tasks.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Tasks {
  Tasks({
    required this.taskListId,
    required this.hidePost,
    required this.showDone,
    required this.pointsStatus,
    required this.visiblityHours,
    required this.uploadedTime,
    required this.socialType,
    required this.id,
    required this.userId,
    required this.postCreatedTime,
    this.postId,
    required this.postLink,
    required this.postType,
    required this.postMessage,
    required this.postMedia,
    required this.postPreviewData,
    required this.postUsername,
    required this.userName,
    this.socialUserId,
    required this.socialTaskPlanId,
    required this.badgeStatus,
    required this.priorityOrder,
    required this.canViewSh,
    required this.canViewMp,
    required this.canViewMla,
    required this.canViewWorker,
    required this.postImg,
    required this.points,
    required this.endDate,
  //  required this.isShared,
  });
  late  var taskListId;
  late  var hidePost;
  late  var showDone;
  late  var pointsStatus;
  late  var visiblityHours;
  late  var uploadedTime;
  late  var socialType;
  late  var id;
  late  var userId;
  late  var postCreatedTime;
  late  var postId;
  late  var postLink;
  late  var postType;
  late  var postMessage;
  late  var postMedia;
  late final PostPreviewData postPreviewData;
  late  var postUsername;
  late  var userName;
  late  var socialUserId;
  late  var socialTaskPlanId;
  late  var badgeStatus;
  late  var priorityOrder;
  late  var canViewSh;
  late  var canViewMp;
  late  var canViewMla;
  late  var canViewWorker;
  late  var postImg;
  late  var points;

  late  var endDate;
  //bool isShared = false;

  Tasks.fromJson(Map<String, dynamic> json){
    taskListId = json['task_list_id'];
    hidePost = json["hide_post"]??"";
    showDone = json['show_done'];
    pointsStatus = json['points_status'];
    visiblityHours = json['visiblity_hours']??"";
    uploadedTime = json['uploaded_time'];
    socialType = json['social_type'];
    id = json['id'];
    userId = json['user_id'];
    postCreatedTime = json['post_created_time']??"";
    postId = null;
    postLink = json['post_link']??"";
    if(json["post_link"].toString().contains("http")){
      postType = "";
    }else {
      postType = json['post_type'] == null ? "" : json['post_type'] == 'link'
          ? ""
          : json['post_type'];
    }
    postMessage = json["post_message"]??"";
    postMedia = json['post_media']??'';
    if(json['post_preview_data'] != null) {
      postPreviewData = PostPreviewData.fromJson(json['post_preview_data']);
    }else{
      postPreviewData = PostPreviewData(cover: '', images: [], title: '', description: '', video: '', videoType: '');
    }
    postUsername = null;
    userName = json['user_name'];
    socialUserId = null;
    socialTaskPlanId = json['social_task_plan_id'];
    badgeStatus = json['badge_status'];
    priorityOrder = json['priority_order'];
    canViewSh = int.parse("${json['can_view_sh']??0}");
    canViewMp = int.parse("${json['can_view_mp']??0}");
    canViewMla = int.parse("${json['can_view_mla']??0}");
    canViewWorker = int.parse("${json['can_view_worker']??0}");
    postImg = json['post_img'];
    points = json['points'];
    endDate = json['end_date'];
    //isShared = false;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['task_list_id'] = taskListId;
    _data['hide_post'] = hidePost;
    _data['show_done'] = showDone;
    _data['points_status'] = pointsStatus;
    _data['visiblity_hours'] = visiblityHours;
    _data['uploaded_time'] = uploadedTime;
    _data['social_type'] = socialType;
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['post_created_time'] = postCreatedTime;
    _data['post_id'] = postId;
    _data['post_link'] = postLink;
    _data['post_type'] = postType;
    _data['post_message'] = postMessage;
    _data['post_media'] = postMedia;
    _data['post_preview_data'] = postPreviewData.toJson();
    _data['post_username'] = postUsername;
    _data['user_name'] = userName;
    _data['social_user_id'] = socialUserId;
    _data['social_task_plan_id'] = socialTaskPlanId;
    _data['badge_status'] = badgeStatus;
    _data['priority_order'] = priorityOrder;
    _data['can_view_sh'] = canViewSh;
    _data['can_view_mp'] = canViewMp;
    _data['can_view_mla'] = canViewMla;
    _data['can_view_worker'] = canViewWorker;
    _data['post_img'] = postImg;
    _data['points'] = points;
    _data['end_date'] = endDate;
    return _data;
  }
}

class PostPreviewData {
  PostPreviewData({
    required this.cover,
    required this.images,
    required this.title,
    required this.description,
    required this.video,
    required this.videoType,
  });
  late  var cover;
  late final List<String> images;
  late  var title;
  late  var description;
  late  var video;
  late  var videoType;

  PostPreviewData.fromJson(Map<String, dynamic> json){
    cover = json['cover']??"";
    images = List.castFrom<dynamic, String>(json['images']??[]);
    title = json['title'];
    description = json['description']??"";
    video = json['video'];
    videoType = json['videoType'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cover'] = cover;
    _data['images'] = images;
    _data['title'] = title;
    _data['description'] = description;
    _data['video'] = video;
    _data['videoType'] = videoType;
    return _data;
  }
}