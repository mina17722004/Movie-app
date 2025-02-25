import 'package:flutter/material.dart';
import 'package:mm/screens/home/home_screen.dart';
import 'package:mm/theme/app_assets.dart';
import 'package:mm/theme/app_colors.dart';
import 'package:mm/theme/customButtom.dart';
import 'package:mm/theme/text_form_field.dart';

class Login extends StatelessWidget {
  static const String routeName = "login";
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.appLogp,
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              const SizedBox(height: 32),

              // Email Field
     CustomTextFormField(text: "Enter Your Email",
       PrefixiconData: Icons.email,
     ),
              const SizedBox(height: 16),

              // Password Field
              CustomTextFormField(text:"Enter Your Password",
                PrefixiconData: Icons.lock,SuffixiconData: Icons.remove_red_eye,)
              , SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(color: appColors.yellow),
                  ),
                ),
              ),

              const SizedBox(height: 16),

Custombutton(title: "Login",
    onClick:() {Navigator.pushNamed(context, HomeScreen.routeName);} ),
              const SizedBox(height: 16),

              Column(
                children: [
                  Text("Don’t Have Account? ",
                    style: TextStyle(
                        color: appColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Create Account",
                      style: TextStyle(color: appColors.yellow),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Divider(color: appColors.yellow)),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                        child: Text("or",
                            style: TextStyle(color: appColors.yellow,height: 2)),
                      ),
                      Expanded(child: Divider(color: appColors.yellow,height: 2,)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Signup Button

                Custombutton(title: "Login With Google", onClick:(){Navigator.pushNamed(context, HomeScreen.routeName);} ),

            ],
          ),
        ),
      ),
    );
  }
}

