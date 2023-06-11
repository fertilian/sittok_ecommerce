import 'dart:convert';

import 'package:ecommerce_ui/models/model_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RememberUser {
  static Future<void> storeUser(user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
  }

  static Future<Users> readUser() async {
    Users? currentUserInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? user = preferences.getString('user');
    if (user != null) {
      Map<String, dynamic> userDataMap = jsonDecode(user);
      currentUserInfo = Users.fromJson(userDataMap);
    }
    return currentUserInfo!;
  }

  static Future<void> removeUserSessions() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('user');
    await preferences.clear();
    await preferences.commit();
  }
}