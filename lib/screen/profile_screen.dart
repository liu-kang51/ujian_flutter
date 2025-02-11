import 'package:flutter/material.dart';
import 'package:ujian_flutter/models/user_model.dart';
import 'package:ujian_flutter/screen/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  'https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExMDRpcHAxenV1aTFuNmtucGUxa3Z5dHhrZGl4NG14Mzdydm5kdDVjeiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/dCRVRbdbZUlNt1sRPd/giphy.gif'),
            ),
            const SizedBox(height: 20),
            Text(
              widget.user.username,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.email, color: Colors.purple),
              title: Text(
                'Email',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                widget.user.email,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.purple),
              title: Text(
                'Phone',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                widget.user.phone,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  textStyle: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.bold,),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
