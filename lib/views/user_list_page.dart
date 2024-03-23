import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loginpagevoco/model/user_model.dart';
import 'package:loginpagevoco/provider/provider.dart';
import 'package:loginpagevoco/service/user_service.dart';

class UserListPage extends ConsumerWidget {
  final UserService _userService = UserService();

  UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.read(tokenProvider).asData!.value!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () async {
                (await ref.read(sharedPrefencesProvider.future))
                    .remove('token');
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: FutureBuilder<List<Data>?>(
        future: _userService.fetchUsers(token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('An error occurred'));
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.email!),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar!),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
