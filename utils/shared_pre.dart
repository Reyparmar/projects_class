import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPre {
  static final SharedPre _sharedPre = SharedPre._internal();

  factory SharedPre() {
    return _sharedPre;
  }

  SharedPre._internal();

  //shared keys
  static const isLogin = 'isLogin';
  static const userData = 'userData';
  static const userProfile = 'userProfile';
  static const userLocation = 'userLocation';
  static const token = 'token';
  static const fcmToken = 'fcm_token';

  static Future setValue({required String key, required dynamic value}) async {
    final prefs = await SharedPreferences.getInstance();
    if (value.runtimeType == String) {
      prefs.setString(key, value);
    } else if (value.runtimeType == bool) {
      prefs.setBool(key, value);
    } else if (value.runtimeType == int) {
      prefs.setInt(key, value);
    } else if (value.runtimeType == double) {
      prefs.setDouble(key, value);
    } else {}
  }

  static setObj(String key, var toJson) async {
    /// call this method like this
    ///  LoginData data=LoginData.fromJson(loginresponse.data.tojson())
    /// sp.setObj("",data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = jsonEncode(toJson);
    return await prefs.setString(key, user);
  }

  static Future<Map<String, dynamic>> getObj(String key) async {
    /// call this method like this
    ///var data= sp.getObj("key);
    ///Login loginData= Logindata.fromjson(data);
    Map<String, dynamic> json = {};
    if (key.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String str = prefs.getString(key) ?? "";
      if (str.isNotEmpty) {
        json = jsonDecode(str);
      }
      json;
    }
    return json; // get data by calling from json method in model class
  }

  static Future<String> getStringValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  static Future<bool> getBoolValue(String key, {bool defaultValue = false}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<int> getIntValue(String key, {int defaultValue = -1}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? -1;
  }

  static Future clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  /// call this method like this
  ///var data= sp.getObj('key);
  ///Login loginData= Logindata.fromjson(data);
  static Future getObjs(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }
}
