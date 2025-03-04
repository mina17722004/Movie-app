import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mm/theme/app_assets.dart';
import 'package:mm/theme/app_colors.dart';
import 'package:mm/theme/customButton.dart';
import 'package:mm/theme/text_form_field.dart';

class ForgetPassword extends StatefulWidget {
  static const String routeName = "ForgetScreen";

  const ForgetPassword({super.key});

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) return;

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password reset link sent to ${emailController.text}")),
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Failed to reset password")),
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
        title: Text("Forget Password", style: TextStyle(color: appColors.yellow, fontSize: 20)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset(AppAssets.forgetPassword),
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: emailController,
                text: "Enter your email",
                PrefixiconData: Icons.email,
                validator: (email) {
                  if (email!.isEmpty) return "Enter an email";
                  if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Custombutton(title: "Reset Password", onClick: resetPassword),
            ],
          ),
        ),
      ),
    );
  }
}
