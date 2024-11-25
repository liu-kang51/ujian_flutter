
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
              backgroundImage: NetworkImage('https://media.tenor.com/Lp97Wy2LPdEAAAAi/nonono-anime-no.gif'),
            ),
            const SizedBox(height: 20),
            Text(
              'Michael',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              '@michael',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.email, color: Colors.red),
              title: Text(
                'Email',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                'michael@example.com',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.red),
              title: Text(
                'Phone',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                '+62 812 3456 7890',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.red),
              title: Text(
                'Location',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                'Jakarta, Indonesia',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  // Add logout functionality
                },
                child: Text('Logout'),
                style: ElevatedButton.styleFrom(
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