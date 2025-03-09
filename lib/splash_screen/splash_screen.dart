import 'package:flutter/material.dart';

import '../theme/app_assets.dart';
import '../theme/app_colors.dart';
import '../screens/onBoarding/onboarding_one.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName="splashScreen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => onBoardingOne()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.black,
      body: Column(
        children: [
          SizedBox(height: 300,),
          Center(
            child: Image.asset(
                AppAssets.appLogp),
          ),
          SizedBox(height: 200,),
          Image.asset(AppAssets.routeLogo),

        ],
      ),

    );
  }
}