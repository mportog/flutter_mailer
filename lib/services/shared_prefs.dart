import 'package:shared_preferences/shared_preferences.dart';

class InternalCache {
  setPreferences(String pass, String user, {bool keepAlive = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('keepLogged', keepAlive);
    await prefs.setString('user', pass);
    await prefs.setString('pass', user);
  }

  Future<String> getString(String getPref) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(getPref) ?? '';
  }

  Future<bool> getBool(bool getPref) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('getPref') ?? false;
  }
}
