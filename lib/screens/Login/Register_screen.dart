import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mm/screens/Login/login_screen.dart';
import 'package:mm/screens/home/home_screen.dart';
import 'package:mm/theme/app_assets.dart';
import 'package:mm/theme/app_colors.dart';
import 'package:mm/theme/customButton.dart';
import '../../theme/text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "registerScreen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> registerUser() async {
    if (!formKey.currentState!.validate()) return;

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      User? user = userCredential.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          "uid": user.uid,
          "name": nameController.text,
          "email": emailController.text,
        });

        Navigator.pushNamed(context, HomeScreen.routeName);
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Registration failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appColors.yellow),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Register", style: TextStyle(color: appColors.yellow, fontSize: 20)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 30, backgroundColor: Colors.grey[800], child: Image.asset(AppAssets.gamerOne)),
                  SizedBox(width: 16),
                  CircleAvatar(radius: 50, backgroundColor: Colors.blue, child: Image.asset(AppAssets.gamerTwo)),
                  SizedBox(width: 16),
                  CircleAvatar(radius: 30, backgroundColor: Colors.grey[800], child: Image.asset(AppAssets.gamerThree)),
                ],
              ),
              SizedBox(height: 8),
              Text("Avatar", style: TextStyle(color: Colors.white)),
              SizedBox(height: 16),
              CustomTextFormField(controller: nameController, text: "Name", PrefixiconData: Icons.person),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: emailController,
                text: "Email",
                PrefixiconData: Icons.email,
                validator: (email) {
                  if (email!.isEmpty) return "Enter an email";
                  if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: passwordController,
                text: "Password",
                PrefixiconData: Icons.lock,
                SuffixiconData: isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                obscureText: !isPasswordVisible,
                validator: (password) {
                  if (password!.isEmpty) return "Enter a password";
                  if (password.length < 6) return "Password must be at least 6 characters";
                  return null;
                },
                suffixOnTap: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: confirmPasswordController,
                text: "Confirm Password",
                PrefixiconData: Icons.lock,
                SuffixiconData: isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                obscureText: !isConfirmPasswordVisible,
                validator: (confirmPassword) {
                  if (confirmPassword != passwordController.text) return "Passwords do not match";
                  return null;
                },
                suffixOnTap: () {
                  setState(() {
                    isConfirmPasswordVisible = !isConfirmPasswordVisible;
                  });
                },
              ),
              SizedBox(height: 24),
              Custombutton(title: "Create Account", onClick: registerUser),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Have Account? ", style: TextStyle(color: Colors.white)),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, LoginScreen.routeName),
                    child: Text("Login", style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
