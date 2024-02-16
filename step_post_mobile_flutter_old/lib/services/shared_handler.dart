import 'package:shared_preferences/shared_preferences.dart';

class SharedHandler {
  Future<bool> addTokens(Map<String, String> tokens) async {
    final instance = await SharedPreferences.getInstance();
    tokens.forEach((key, value) async {
      await instance.setString(key, value);
    });
    return true;
  }

  Future<String> getToken(String key) async {
    final instance = await SharedPreferences.getInstance();
    final String? token = instance.getString(key);
    return token ?? "";
  }

  Future<bool> removeTokens() async {
    final instance = await SharedPreferences.getInstance();
    await instance.remove('accessToken');
    await instance.remove('refreshToken');
    return true;
  }
}
