import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  var dio = Dio();
  var logger = Logger();

  Future<String?> login(String email, String password) async {
    const String apiUrl = 'https://reqres.in/api/login';
    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    try {
      final Response response = await Dio().post(apiUrl, data: loginData);
      if (response.statusCode == 200) {
        final String token = response.data['token'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token); // Tokeni kaydet
        return token;
      } else {
        return null;
      }
    } catch (e) {
      logger.e("Login failed: $e");
      return null;
      //throw Exception('Failed to load data');
    }
  }

  Future<bool> verifyCredentials(String email, String password) async {
    const String apiUrl = 'https://reqres.in/api/login';
    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    try {
      final Response response = await Dio().post(apiUrl, data: loginData);
      if (response.statusCode == 200) {
        // Giriş başarılı
        return true;
      } else {
        // Giriş başarısız
        return false;
      }
    } catch (e) {
      logger.e("Verification failed: $e");
      return false;
      //throw Exception('Failed to load data');
    }
  }
}
