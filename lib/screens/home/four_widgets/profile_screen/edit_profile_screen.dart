import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mm/screens/home/home.dart';
import 'package:mm/theme/app_assets.dart';
import 'package:mm/theme/app_colors.dart';
import 'package:mm/theme/customButton.dart';
import 'package:mm/theme/text_form_field.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName="editProfile";
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _selectedAvatar;
  String? _uid;

  final List<String> avatarOptions = [
    "gamerOne.png",
    "gamerTwo.png",
    "gamerThree.png",
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      _uid = FirebaseAuth.instance.currentUser?.uid;
      if (_uid == null) return;

      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(_uid).get();

      if (userDoc.exists) {
        setState(() {
          _nameController.text = userDoc['name'] ?? "";
          _emailController.text = userDoc['email'] ?? "";
          _selectedAvatar = userDoc['iconUrl'] ?? "gamerOne.png";
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _updateUserData() async {
    if (_uid == null) return;

    try {
      await FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'name': _nameController.text,
        'email': _emailController.text,
        'iconUrl': _selectedAvatar,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile updated successfully")),
      );
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appColors.black,
        title: Text("Pick Avatar", style: TextStyle(color:appColors.yellow)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appColors.yellow),
          onPressed: () =>
              Navigator.pushReplacementNamed(context,HomeScreen.routeName),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  AppAssets.getAvatar(_selectedAvatar?? "gamerOne.png")),
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              controller: _nameController,
              text:"Name" , PrefixiconData: Icons.person,

            ),
            SizedBox(height: 10),
            CustomTextFormField(
              controller: _emailController,
              text:"Email" , PrefixiconData: Icons.email,

            ),
            SizedBox(height: 20),
            Text("Pick an Avatar", style: TextStyle(color: Colors.white)),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: avatarOptions.length,
                itemBuilder: (context, index) {
                  String avatar = avatarOptions[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatar = avatar;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedAvatar == avatar
                              ? appColors.yellow
                              : Colors.transparent,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(AppAssets.getAvatar(avatar)),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Custombutton(
              title: "Update Data",
              onClick: _updateUserData,
            ),
          ],
        ),
      ),
    );
  }
}
