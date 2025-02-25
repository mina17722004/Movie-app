import 'package:flutter/material.dart';
import 'package:mm/screens/Login/login.dart';
import 'package:mm/screens/onBoarding/onBoardingFive.dart';

import '../../theme/app_assets.dart';
import '../../theme/app_colors.dart';

class onboardingSix extends StatelessWidget {
  static const String routeName = "onboardingSix";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [

              Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [ Color(0xff4C2471),
                      Color(0xff4C2471),

                    ],
                  ),
                ),
              ),

              // Background Image
              Positioned.fill(
                child: Opacity(
                  opacity: 0.7, // Adjust opacity to make the gradient visible
                  child: Image.asset(
                    AppAssets.film,
                    fit: BoxFit.cover,
                  ),
                ),
              ),


              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 200,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: appColors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Start Watching Now',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: appColors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
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
Navigator.pushNamed(context, Login.routeName);
                        },
                        child:

                        Container(height: 30,width: 400,
                          child: Text(
                            'Finish',textAlign: TextAlign.center,
                            style: TextStyle(color: appColors.black, fontWeight: FontWeight.bold,fontSize: 20),
                          ),
                        ),

                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appColors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: appColors.yellow, width: 2), // Border color and width
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 35,
                          width: 400,
                          child: Text(
                            'Back',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: appColors.yellow,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

