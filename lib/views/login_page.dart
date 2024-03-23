import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loginpagevoco/provider/provider.dart';

class LoginPage extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authServiceProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context)
                    .padding
                    .top), // Ekranın üst kısmındaki sistem çubuğu (status bar) yüksekliği kadar boşluk bırakır
            Container(
              width: MediaQuery.of(context).size.width *
                  0.5, // Ekran genişliğinin yarısı kadar genişlik
              height: MediaQuery.of(context).size.height *
                  0.2, // Ekran yüksekliğinin beşte biri kadar yükseklik
              margin: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 20), // İstenirse başka bir boşluk da ekleyebilirsiniz
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images.png'),
                ),
              ),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                bool isVerified = await authService.verifyCredentials(
                  emailController.text,
                  passwordController.text,
                );
                if (isVerified) {
                  final String? token = await authService.login(
                    emailController.text,
                    passwordController.text,
                  );
                  if (token != null) {
                    ref.refresh(tokenProvider);
                    Future.delayed(const Duration(milliseconds: 100));
                    Navigator.pushReplacementNamed(context, '/userList');
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid Credentials')),
                  );
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
