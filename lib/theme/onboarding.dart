import 'package:flutter/material.dart';
import 'app_colors.dart';

class onboarding extends StatelessWidget {
  int GradientColor;
String MovieImage;
  String fristText="";
  String secondText="";
  String routeName="";
  double containerHeight;


   onboarding({required this.GradientColor,required this.MovieImage,required this.routeName,required this.containerHeight ,required this.fristText,required this.secondText});
  @override
  Widget build(BuildContext context,) {
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
                    colors: [ Color(GradientColor),
                      Color(GradientColor),
                    ],
                  ),
                ),
              ),

              Positioned.fill(
                child: Opacity(
                  opacity: 0.7,
                  child: Image.asset(
                    MovieImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 280,
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
                        '$fristText',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: appColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "$secondText",
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
                          Navigator.pushNamed(context,routeName);
                        },
                        child:

                        Container(height: 30,width: 400,
                          child: Text(
                            'Next',textAlign: TextAlign.center,
                            style: TextStyle(color: appColors.black, fontWeight: FontWeight.bold,fontSize: 20),
                          ),
                        ),

                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appColors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(color: appColors.yellow, width: 2),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: containerHeight,
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
