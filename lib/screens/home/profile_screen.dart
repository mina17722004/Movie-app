import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mm/screens/home/edit_profile_screen.dart';
import 'package:mm/screens/home/home.dart';
import 'package:mm/theme/app_assets.dart';
import 'package:mm/theme/app_colors.dart';

import '../../model/userDm.dart';

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  Future<UserDm?> getUserData() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid; // Get the logged-in user ID
      if (uid == null) return null;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users') // Firestore collection
          .doc(uid) // Fetch user document using UID
          .get();

      if (!userDoc.exists) return null;
      return UserDm.fromFirestore(userDoc.data() as Map<String, dynamic>); // Convert Firestore data to UserDm object
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: appColors.grey,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              children: [
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blueAccent,
                      child: Image.asset(AppAssets.gamerOne),
                    ),
                    SizedBox(width: 45),
                    _infoBox("12", "Wish List"),
                    SizedBox(width: 55),
                    _infoBox("10", "History"),
                  ],
                ),
                SizedBox(height: 10),

                // Fetch and Display User Name from Firestore
                FutureBuilder<UserDm?>(
                  future: getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Show loading indicator
                    }
                    if (snapshot.hasError || snapshot.data == null) {
                      return Text(
                        "User not found",
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      );
                    }
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        snapshot.data!.name,
                        style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    );

                  },
                ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _profileButton(context, "Edit Profile", appColors.yellow, appColors.black, EditProfileScreen.routeName),
                    SizedBox(width: 10),
                    _profileButton(context, "Exit", appColors.red, appColors.white, HomeScreen.routeName),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _tabButton(Icons.menu, "Watch List", true),
                SizedBox(width: 20),
                _tabButton(Icons.folder, "History", false),
              ],
            ),
          ),

          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.local_movies, size: 60, color: Colors.yellow),
                  SizedBox(height: 10),
                  Text("No movies found", style: TextStyle(color: Colors.white70, fontSize: 16)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileButton(BuildContext context, String text, Color bgColor, Color textColor, String routeName) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        padding: EdgeInsets.symmetric(horizontal: 65, vertical: 10),
      ),
      onPressed: () {
        Navigator.pushReplacementNamed(context, routeName);
      },
      child: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
    );
  }

  Widget _tabButton(IconData icon, String label, bool isSelected) {
    return Column(
      children: [
        Icon(icon, color: isSelected ? Colors.yellow : Colors.white, size: 24),
        SizedBox(height: 4),
        Container(
          height: 3,
          width: 60,
          color: isSelected ? Colors.yellow : Colors.transparent,
        ),
      ],
    );
  }

  Widget _infoBox(String count, String label) {
    return Column(
      children: [
        Text(count, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 14)),
      ],
    );
  }
}
