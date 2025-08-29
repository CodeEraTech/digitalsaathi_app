import 'package:shared_preferences/shared_preferences.dart';

// ignore: avoid_classes_with_only_static_members
class Prefs {

  static String userId = 'user_id';
  static String api_token = 'api_token';
  static String username = 'user_name';
  static String isIntro = 'intro';
  static String fcmToken = "fcmToken";
  static String mlaAssemblyId = "mlaAssemblyId";
  static String mpConstituencyId = "mpConstituencyId";
  static String fontSizeName = 'font_size_name';
  static String fontSizeDesignation = 'font_size_designation';


  static SharedPreferences? prefs;
  static Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    return prefs != null;
  }
}
