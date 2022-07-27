import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Моя страница"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Вы вошли как: "),
            SizedBox(height: 8),
            Text(user.email!),
            SizedBox(height: 8),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: Icon(Icons.logout, size: 30),
                label: Text("Выйти", style: TextStyle(fontSize: 20),)
            ),
          ],
        ),
      ),
    ));
  }
}
