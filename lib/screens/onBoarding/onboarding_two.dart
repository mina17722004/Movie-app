
import 'package:flutter/material.dart';
import 'package:mm/theme/app_assets.dart';
import 'package:mm/theme/onboarding.dart';

import 'onBoarding_three.dart';



class onboardingTwo extends StatelessWidget {
  static const String routeName = "onboardingTwo";

  @override
  Widget build(BuildContext context) {
    return onboarding(GradientColor: 0xff084250,
        MovieImage: AppAssets.superMan,
        routeName: onboardingThree.routeName,
        containerHeight: 30,
        fristText: "Discover Movies",
        secondText: "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.");

  }
}
