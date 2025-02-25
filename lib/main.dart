import 'package:flutter/material.dart';
import 'package:mm/screens/home/home_screen.dart';
import 'package:mm/screens/login.dart';
import 'package:mm/screens/onBoarding/onBoardingFive.dart';
import 'package:mm/screens/onBoarding/onBoarding_four.dart';
import 'package:mm/screens/onBoarding/onBoarding_three.dart';
import 'package:mm/screens/onBoarding/onboardingSix.dart';
import 'package:mm/screens/onBoarding/onboarding_one.dart';
import 'package:mm/screens/onBoarding/onboarding_two.dart';
import 'package:mm/screens/splash_screen.dart';
import 'package:mm/theme/app_assets.dart';
import 'package:mm/theme/app_colors.dart';

void main() {
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
        Login.routeName:(_)=>Login(),
        HomeScreen.routeName:(_)=>HomeScreen(),




      },
      initialRoute: SplashScreen.routeName,
      title: 'Flutter Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

