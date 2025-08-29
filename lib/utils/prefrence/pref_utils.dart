import 'package:digitalsaathi/utils/prefrence/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: avoid_classes_with_only_static_members
class PrefUtils {
  static String? setUserId(String id) {
    Prefs.prefs?.setString(Prefs.userId, id);
  }

  static String getUserId() {
    final String? value = Prefs.prefs?.getString(Prefs.userId);
    return value ?? '';
  }

  static String? setToken(String id) {
    Prefs.prefs?.setString(Prefs.api_token, id);
  }

  static String getToken() {
    final String? value = Prefs.prefs?.getString(Prefs.api_token);
    return value ?? '';
  }

  static String? setUserName(String id) {
    Prefs.prefs?.setString(Prefs.username, id);
  }
  static String? setFcmToken(String id) {
    Prefs.prefs?.setString(Prefs.fcmToken, id);
  }
  static String getFcmToken() {
    final String? value = Prefs.prefs?.getString(Prefs.fcmToken);
    return value ?? '';
  }

  static String getUserName() {
    final String? value = Prefs.prefs?.getString(Prefs.username);
    return value ?? '';
  }

  static String getUserToken() {
    final String? value = Prefs.prefs?.getString(Prefs.userId);
    return value ?? '';
  }

  static String? setIntro(bool intro) {
    Prefs.prefs?.setBool(Prefs.isIntro, intro);
  }
  static void removeUserToken(){
    Prefs.prefs?.remove(Prefs.userId);
  }
  static bool containUserKey(){
    final bool? value = Prefs.prefs?.containsKey(Prefs.userId);
    print("userkey ${value.toString()}");
    return value ?? false;
  }

  static bool getIntro() {
    final bool? value = Prefs.prefs?.getBool(Prefs.isIntro);
    return value ?? false;
  }

  static String? setMpConstituencyId(String id) {
    Prefs.prefs?.setString(Prefs.mpConstituencyId, id);
  }

  static String getMpConstituencyId() {
    final String? value = Prefs.prefs?.getString(Prefs.mpConstituencyId);
    return value ?? '';
  }

  static String? setMlaAssemblyId(String id) {
    Prefs.prefs?.setString(Prefs.mlaAssemblyId, id);
  }

  static String getMlaAssemblyId() {
    final String? value = Prefs.prefs?.getString(Prefs.mlaAssemblyId);
    return value ?? '';
  }

  static String? logout() {
    Prefs.prefs?.clear();
  }

  // Font Size Name
  static double getFontSizeName() {
    return Prefs.prefs?.getDouble(Prefs.fontSizeName) ?? 20.0;
  }

  static void setFontSizeName(double value) {
    Prefs.prefs?.setDouble(Prefs.fontSizeName, value);
  }

// Font Size Designation
  static double getFontSizeDesignation() {
    return Prefs.prefs?.getDouble(Prefs.fontSizeDesignation) ?? 14.0;
  }

  static void setFontSizeDesignation(double value) {
    Prefs.prefs?.setDouble(Prefs.fontSizeDesignation, value);
  }



}
