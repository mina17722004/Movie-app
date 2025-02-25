import 'package:flutter/material.dart';
import 'package:mm/screens/Login/login.dart';
import 'package:mm/screens/home/home_screen.dart';
import 'package:mm/theme/app_assets.dart';
import 'package:mm/theme/customButtom.dart';

import '../../theme/text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName= "registerScreen";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {Navigator.pop(context);},
        ),
        title: Text("Register", style: TextStyle(color: Colors.yellow, fontSize: 20)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(radius: 30,
                    backgroundColor: Colors.grey[800],
                    child:
                    Image.asset(AppAssets.gamerOne)),
                SizedBox(width: 16),
                CircleAvatar(radius: 50,
                    backgroundColor: Colors.blue,
                    child:
                    Image.asset(AppAssets.gamerTwo)),
                SizedBox(width: 16),
                CircleAvatar(radius: 30,
                    backgroundColor: Colors.grey[800],
                    child:
                    Image.asset(AppAssets.gamerThree)),
              ],
            ),
            SizedBox(height: 8),
            Text("Avatar", style: TextStyle(color: Colors.white)),
            SizedBox(height: 16),
            CustomTextFormField(text: "Name", PrefixiconData: Icons.person),
            SizedBox(height: 16),

            CustomTextFormField(text: "Email", PrefixiconData: Icons.email),
            SizedBox(height: 16),

            CustomTextFormField(
              text: "Password",
              PrefixiconData: Icons.lock,
              SuffixiconData: isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            SizedBox(height: 16),

            CustomTextFormField(
              text: "Confirm Password",
              PrefixiconData: Icons.lock,
              SuffixiconData: isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            SizedBox(height: 16),

            CustomTextFormField(text: "Phone Number", PrefixiconData: Icons.phone),
            SizedBox(height: 24),


            Custombutton(title: "Create Account", onClick:
                (){Navigator.pushNamed(context, HomeScreen.routeName);} ),

            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already Have Account? ", style: TextStyle(color: Colors.white)),
                GestureDetector(
                  onTap: () {Navigator.pushNamed(context, Login.routeName);},
                  child: Text("Login", style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}