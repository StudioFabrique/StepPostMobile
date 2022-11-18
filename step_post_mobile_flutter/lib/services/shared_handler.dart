import 'package:shared_preferences/shared_preferences.dart';

class SharedHandler {
  final String key = "token";

  Future<bool> addToken(String token) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString(key, token);
    return true;
  }

  Future<String> getToken() async {
    final instance = await SharedPreferences.getInstance();
    final String? token = instance.getString("token");
    return token ?? "";
  }

  Future<bool> removeToken(String value) async {
    final instance = await SharedPreferences.getInstance();
    await instance.remove(key);
    return true;
  }
}
