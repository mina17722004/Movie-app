import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mm/screens/Login/Register_screen.dart';
import 'package:mm/screens/Login/forget_password.dart';
import 'package:mm/screens/Login/login_screen.dart';
import 'package:mm/screens/home/four_widgets/home_widget/see_more_screen.dart';
import 'package:mm/screens/home/four_widgets/profile_screen/edit_profile_screen.dart';
import 'package:mm/screens/home/home.dart';
import 'package:mm/screens/home/four_widgets/home_widget/home_screen.dart';
import 'package:mm/screens/home/four_widgets/movie_details/movie_details.dart';

import 'package:mm/screens/onBoarding/onBoardingFive.dart';
import 'package:mm/screens/onBoarding/onBoarding_four.dart';
import 'package:mm/screens/onBoarding/onBoarding_three.dart';
import 'package:mm/screens/onBoarding/onboardingSix.dart';
import 'package:mm/screens/onBoarding/onboarding_one.dart';
import 'package:mm/screens/onBoarding/onboarding_two.dart';
import 'package:mm/splash_screen/splash_screen.dart';
import 'package:mm/theme/app_assets.dart';
import 'package:mm/theme/app_colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
     SplashScreen.routeName:(_)=>SplashScreen(),
        onboardingTwo.routeName:(_)=>onboardingTwo(),
       onboardingThree.routeName:(_)=>onboardingThree(),
        onboardingFour.routeName:(_)=>onboardingFour(),
        onboardingFive.routeName:(_)=>onboardingFive(),
        onboardingSix.routeName:(_)=>onboardingSix(),
        LoginScreen.routeName:(_)=>LoginScreen(),
        HomeScreen.routeName:(_)=>HomeScreen(),
        RegisterScreen.routeName:(_)=>RegisterScreen(),
        ForgetPassword.routeName:(_)=>ForgetPassword(),
        EditProfileScreen.routeName:(_)=>EditProfileScreen(),
        SeeMoreScreen.routeName:(_)=>SeeMoreScreen()






      },
      initialRoute: HomeScreen.routeName,
      title: 'Flutter Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

