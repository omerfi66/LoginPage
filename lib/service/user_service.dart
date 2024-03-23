import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';

class UserService {
  Future<List<Data>?> fetchUsers(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    const String apiUrl =
        'https://reqres.in/api/users?page=2'; //final 'ı const yaptım

    try {
      final Response response = await Dio().get(
        apiUrl,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final usersModel = UsersModel.fromJson(response.data);
        return usersModel.data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
