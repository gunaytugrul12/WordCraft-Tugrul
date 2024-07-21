import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:languagelearningapp/screens/signin_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.deepOrange,
                    child: Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  buildProfileItem(Icons.email, 'Email', user.email ?? 'Not available'),
                  buildProfileItem(Icons.person, 'Username', user.displayName ?? 'Not available'),
                  buildProfileItem(Icons.lock, 'Change Password', 'Change your password'),
                ],
              )
            : Text(
                'User not logged in.',
                style: TextStyle(fontSize: 18),
              ),
      ),
    );
  }

  Widget buildProfileItem(IconData icon, String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 5),
              Text(
                value,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
