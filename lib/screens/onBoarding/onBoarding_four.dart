import 'package:flutter/material.dart';
import 'package:mm/screens/onBoarding/onBoardingFive.dart';
import 'package:mm/theme/app_assets.dart';
import 'package:mm/theme/onboarding.dart';

class onboardingFour extends StatelessWidget {
  static const String routeName = "onboardingFour";

  @override
  Widget build(BuildContext context) {
    return onboarding(GradientColor: 0xff4C2471,
    MovieImage: AppAssets.dieMovie,
  routeName: onboardingFive.routeName,
  containerHeight: 35,
  fristText: "Create Watchlists",
  secondText: "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres");

  }
}
