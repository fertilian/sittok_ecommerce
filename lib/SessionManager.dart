import 'dart:convert';

import 'package:ecommerce_ui/models/model_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String KEY_USER_DATA = 'user_data';
  static const String KEY_LOGGED_IN = 'logged_in';
  static const String KEY_ID_CUSTOMER = 'idCust';
  static const String KEY_GAMBAR = 'gambar';

  static Future<void> saveUserData(Users user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_USER_DATA, user.toJson().toString());
    await prefs.setBool(KEY_LOGGED_IN, true);
    await prefs.setInt(KEY_ID_CUSTOMER, user.idCustomer ?? 0);
    await prefs.setString(KEY_GAMBAR, user.profil.toString() );
  }

  static Future<Users?> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userDataString = prefs.getString(KEY_USER_DATA);
    if (userDataString != null) {
      final Map<String, dynamic> userDataMap =
      Map<String, dynamic>.from(jsonDecode(userDataString));
      return Users.fromJson(userDataMap);
    }
    return null;
  }

  static Future<int?> getIdCustomer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(KEY_ID_CUSTOMER);
  }
  static Future<String?> getProfil() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_GAMBAR);
  }

  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(KEY_LOGGED_IN) ?? false;
  }

  static Future<void> clearSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(KEY_USER_DATA);
    await prefs.remove(KEY_LOGGED_IN);
    await prefs.remove(KEY_ID_CUSTOMER);
    await prefs.remove(KEY_GAMBAR);
  }
}
