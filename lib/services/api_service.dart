import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5105/api';
  static const String _tokenKey = 'loginova_token';
  static const String _usuarioKey = 'loginova_usuario';

  static String? token;

  static Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString(_tokenKey);
  }

  static Future<void> saveSession(String newToken, String usuarioJson) async {
    final prefs = await SharedPreferences.getInstance();
    token = newToken;
    await prefs.setString(_tokenKey, newToken);
    await prefs.setString(_usuarioKey, usuarioJson);
  }

  static Future<String?> loadUsuarioJson() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usuarioKey);
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    token = null;
    await prefs.remove(_tokenKey);
    await prefs.remove(_usuarioKey);
  }

  static Map<String, String> get jsonHeaders {
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}
