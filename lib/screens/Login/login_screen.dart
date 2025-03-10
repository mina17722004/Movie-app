import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mm/screens/Login/forget_password.dart';
import 'package:mm/theme/app_colors.dart';
import 'package:mm/theme/customButton.dart';
import '../../firebaseHelpers/firestore/firestoreHelpers.dart';
import '../../theme/app_assets.dart';
import '../../utils/dialog_utils.dart';
import '../home/home.dart';
import 'Register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login_fire";

  @override
  _LoginFireState createState() => _LoginFireState();
}

class _LoginFireState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.black,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              Image.asset(
                AppAssets.appLogp, // Fixed typo
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              const SizedBox(height: 16),
              TextFormField(
                style: TextStyle(color: appColors.white),
                controller: _emailController,
                decoration: InputDecoration(

                  fillColor: Colors.grey[900],
                  filled: true,
                  prefixIcon: Icon(Icons.email, color: appColors.white),
                  hintText: "Email",
                  hintStyle: TextStyle(color: appColors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return "Please enter an email";
                  }
                  final bool emailValid =
                  RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
                  if (!emailValid) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),
               SizedBox(height: 16),
              TextFormField(
                style: TextStyle(color: appColors.white),
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[900],
                  prefixIcon: Icon(Icons.lock, color: appColors.white),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: appColors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  hintText: "Password",
                  hintStyle: TextStyle(color: appColors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return "Enter password";
                  } else if (password.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
               SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {Navigator.pushReplacementNamed(context, ForgetPassword.routeName);}, // Implement Forgot Password logic
                  child: const Text("Forgot password?", style: TextStyle(color: appColors.yellow)),
                ),
              ),

               SizedBox(height: 16),
              Custombutton(
                onClick: () async {
                  if (!_formKey.currentState!.validate()) return;
                  try {
                    showLoading(context);
                    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    await saveUserToFirestore(credential.user);
                    var userData = await getUserFromFirestore(credential.user!.uid);
                    if (userData == null) {
                      print("User data not found in Firestore.");
                      hideLoading(context);
                      return;
                    }
                    hideLoading(context);
                    await checkFirestoreUser(credential.user!.uid);
                    Navigator.pushNamed(context, HomeScreen.routeName);

                  } on FirebaseAuthException catch (e) {
                    hideLoading(context);
                    showMassege(context, e.message ?? "An error occurred", posButton: "OK");
                  }
                },
                title: "Login",
              ),

               SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?", style: TextStyle(color: appColors.white)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
                    },
                    child: const Text("Create account", style: TextStyle(color: appColors.yellow)),
                  ),
                ],
              ),
              SizedBox(height: 16),

            ],
          ),
        ),
      ),
    );
  }
}
