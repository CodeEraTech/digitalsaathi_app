
class AppUrl {
  static var baseUrl = 'https://newdgs.mydigitalsaathi.com' ;
  static var meettingBaseImageUrl = 'https://newdgs.mydigitalsaathi.com/public/' ;

  static final String BASE_URL_AWS = "https://newdgs.mydigitalsaathi.com/public/uploads/";
  static final String BASE_IMAGE_URL = "https://newdgs.mydigitalsaathi.com/public/uploads/users/";
   static final String BASE_POSTER_URL = BASE_URL_AWS + "poster/";
   static final String EVENT_URL = "https://newdgs.mydigitalsaathi.com/public/uploads/event/";

//Dev url
//   static var baseUrl = 'https://newds.codegenit.org' ;
//   static var meettingBaseImageUrl = 'https://newds.codegenit.org/public/' ;
//
//   static final String BASE_URL_AWS = "https://newds.codegenit.org/public/uploads/";
//   static final String BASE_IMAGE_URL = "https://newds.codegenit.org/public/uploads/users/";
//   static final String BASE_POSTER_URL = BASE_URL_AWS + "poster/";
//   static final String EVENT_URL = "https://newds.codegenit.org/public/uploads/event/";
   static final String BASE_SOCIAL_MEDIAATTACHMENT_W = BASE_URL_AWS + "social_post/whatsapp/";

  //Get All Feeds on Dashboard
  static var getAllFeeds = '$baseUrl/api/v3/getallfeeds' ;

  //Get All Meeting List of worker
  static var getMeetingList = '$baseUrl/api/v3/meeting-list' ;

  //Get Meeting Detail of particular meeting
  static var getMeetingDetail = '$baseUrl/api/v3/meeting-detail' ;

  //Get Report of all meetings
  static var getMeetingReport = '$baseUrl/api/v3/meeting-report' ;

  //Meeting Review

  static var meetingReview = '$baseUrl/api/v3/meeting-review' ;

  //Add new participant in a meeting
  static var addMeetingParticipant = '$baseUrl/api/v3/add-participants' ;

  //Update meeting participants
  static var updateMeetingParticipants = '$baseUrl/api/v3/update-meeting-partipants' ;

  //Mark individual meeting attendance
  static var markMeetingAttendance = '$baseUrl/api/v3/mark-attandance' ;

  //List All Added Complaints
  static var getAllComplaints = '$baseUrl/api/v3/getallcomplaint' ;

  //Get Roles
  static var getRoleList = '$baseUrl/api/v3/getallroles' ;

  //Get Task List
  static var getTaskList = '$baseUrl/api/v3/gettasklist' ;
  static var getAllPoster = '$baseUrl/api/v3/getallposter' ;
  static var getPartySymbols = '$baseUrl/api/v3/symbols' ;
  static var getAllLeaders = '$baseUrl/api/v3/leaders' ;
  static var postSocialPoint = '$baseUrl/api/v3/increasescoreofpeson' ;
  static var markTaskDone = '$baseUrl/api/v3/mark-task-done' ;
  static var getUserPerformance = '$baseUrl/api/v3/getuserperformance' ;
  static var getPoliticalProfile = '$baseUrl/api/v3/poltical-profile' ;
  static var deletePoliticalProfile = '$baseUrl/api/v3/delete-poltical-profile';
  static var createPosterProfile = '$baseUrl/api/v3/create-poltical-profile' ;
  static var posterLike = '$baseUrl/api/v3/eventliketype' ;
  static var getPosterComment = '$baseUrl/api/v3/geteventbyid' ;
  static var postComment = '$baseUrl/api/v3/addeventcomment' ;
  static var deleteEventComment = '$baseUrl/api/v3/deleteeventfeedcomment' ;
  static var changePoliticalStatus = '$baseUrl/api/v3/change-status-poltical-profile' ;
  static var getMlaAndCategoryList = '$baseUrl/api/v3/getmlaandcategorylist' ;
  static var createComplaint = '$baseUrl/api/v3/createcomplaint' ;
  static var deleteComplaintt = '$baseUrl/api/v3/delete-complaint' ;
  static var getState = '$baseUrl/api/v3/getstateslist' ;
  static var getDistrict = '$baseUrl/api/v3/getdistrictlist' ;
  static var getConstituency = '$baseUrl/api/v3/getmpconstituencylist' ;
  static var getAssembly = '$baseUrl/api/v3/getmlaassemblylist' ;
  static var registerUser = '$baseUrl/api/v3/register' ;
  static var loginUser = '$baseUrl/api/v3/login' ;
  static var getProfile = '$baseUrl/api/v3/profile' ;
  static var checkEpicNumber = '$baseUrl/api/v3/check-epic-number' ;
  static var sendOtp = '$baseUrl/api/v3/sendOTP' ;
  static var verifyOtp = '$baseUrl/api/v3/verifyOTP' ;
  static var loginOtp = '$baseUrl/api/v3/newloginOTP' ;
  static var getNewsLetter = '$baseUrl/api/v3/get-news-letter' ;
  static var getContent = '$baseUrl/api/v3/get-content' ;
  static var shareContent = '$baseUrl/api/v3/add-content-share-see';
  static var updateProfile = '$baseUrl/api/v3/updateprofile' ;
  static var createPost = '$baseUrl/api/v3/createfeed' ;
  static var unreadNotificationCount = '$baseUrl/api/v3/unread-notification-count' ;
  static var notificationList = '$baseUrl/api/v3/notificationlist' ;
  static var readAllNotification = '$baseUrl/api/v3/read-all-notifications' ;
  static var deleteAllNotification = '$baseUrl/api/v3/delete-notifications' ;
  static var markAsReadNotify = '$baseUrl/api/v3/mark-as-read' ;
  static var deleteSingleNotification = '$baseUrl/api/v3/delete-single-notification' ;
  static var deleteFeed = '$baseUrl/api/v3/deletefeed' ;
  static var getMemberId = '$baseUrl/api/v3/idcard' ;
  static var getSurveyReport = '$baseUrl/api/v3/survey-report' ;
  static var getVoterReport = '$baseUrl/api/v3/voter-report' ;
  static var getMlaList = '$baseUrl/api/v3/getmlalist' ;
  static var getTagMlaList = '$baseUrl/api/v3/gettagmlalist' ;
  static var followMLA = '$baseUrl/api/v3/followmla' ;
  static var submitFontSize = '$baseUrl/api/v3/submitFontSize';

   // static var apiToken = "THM0N2hGdUdCRFFYeFFmS1ZUcGZ4dE5kVFQyWEViTkc2VU1xRFJ3U0BAMjY=";
    static var apiToken = "RnpZRGw1R3RpSXJwRTM5RFJ4OW9qbWdvMlJtS3pmcmV6dE5rTTVyYkBANTAxMw==";
    static var roleId = 3;
  // Login app user role id's
   static final int mRoleUser = 4;
   static final int mRoleWorker = 3;
   static final int mRoleMLA = 2;
   static final int mRoleNationalHead = 5;
   static final int mRoleStateHead = 6;
   static final int mRoleMP = 7;

   //FCM
  static  String FCM_TOKEN = "";


}