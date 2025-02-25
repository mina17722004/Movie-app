import 'package:flutter/material.dart';
import 'package:mm/screens/onBoarding/onboarding_two.dart';
import 'package:mm/theme/app_assets.dart';
import 'package:mm/theme/app_colors.dart';

class onBoardingOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(

          decoration: BoxDecoration(


            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
            image: DecorationImage(
              image: AssetImage(AppAssets.sum), // Replace with your image
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                 Colors.black,Colors.transparent

                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Find Your Next Favorite Movie Here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: appColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Get access to a huge library of movies to suit all tastes. You will surely like it.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: appColors.white,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context,onboardingTwo.routeName);
                      },
                      child:

                        Container(height: 16,width: 400,
                          child: Text(
                            'Explore Now',textAlign: TextAlign.center,
                            style: TextStyle(color: appColors.black, fontWeight: FontWeight.bold),
                          ),
                        ),

                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
