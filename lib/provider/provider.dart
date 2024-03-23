import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loginpagevoco/service/authentication_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authServiceProvider = Provider<AuthenticationService>((ref) {
  return AuthenticationService();
});

final sharedPrefencesProvider = FutureProvider((ref) async {
  return await SharedPreferences.getInstance();
});

final tokenProvider = FutureProvider((ref) async =>
    (await ref.read(sharedPrefencesProvider.future)).getString('token'));

