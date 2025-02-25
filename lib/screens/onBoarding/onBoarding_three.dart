
import 'package:flutter/material.dart';
import 'package:mm/screens/onBoarding/onBoardingFive.dart';
import 'package:mm/theme/app_assets.dart';
import 'package:mm/theme/onboarding.dart';

import 'onBoarding_four.dart';

class onboardingThree extends StatelessWidget {
  static const String routeName = "onboardingThree";

  @override
  Widget build(BuildContext context) {
    return onboarding(GradientColor: 0xff85210E,
        MovieImage: AppAssets.openHimer,
        routeName: onboardingFour.routeName,
        containerHeight: 35,
        fristText: "Explore All Genre",
        secondText: "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day");

  }
}
