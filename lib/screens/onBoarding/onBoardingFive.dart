

import 'package:flutter/material.dart';
import 'package:mm/theme/app_assets.dart';
import 'package:mm/theme/onboarding.dart';

import 'onBoarding_three.dart';
import 'onboardingSix.dart';



class onboardingFive extends StatelessWidget {
  static const String routeName = "onboardingFive";

  @override
  Widget build(BuildContext context) {
    return onboarding(GradientColor: 0xff601321,
        MovieImage: AppAssets.doctorStrange,
        routeName: onboardingSix.routeName,
        containerHeight: 30,
        fristText: "Start Watching Now",
        secondText: "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.");

  }
}

