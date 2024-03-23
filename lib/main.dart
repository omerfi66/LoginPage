import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loginpagevoco/provider/provider.dart';
import 'package:loginpagevoco/views/login_page.dart';
import 'package:loginpagevoco/views/user_list_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(tokenProvider);

    return token.when(
      data: (data) {
        var initialRoute2 = data != null ? '/userList' : '/login';
        //print(initialRoute2);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Riverpod Demo',
          initialRoute: initialRoute2,
          routes: {
            '/login': (context) => LoginPage(),
            '/userList': (context) => UserListPage(),
            '/': (context) => const Center(child: CircularProgressIndicator()),
          },
        );
      },
      error: (error, stackTrace) => Text('$error'),
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }
}
