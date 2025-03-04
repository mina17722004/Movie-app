import 'package:flutter/material.dart';
import 'package:mm/theme/app_colors.dart';

class Custombutton extends StatelessWidget {
  final String title;
  final VoidCallback onClick;

  const Custombutton({super.key, required this.title, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(

        onPressed: onClick,
        style: FilledButton.styleFrom(
          backgroundColor: appColors.yellow,
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(title, style: TextStyle(fontSize: 16,color: appColors.black)),
      ),
    );
  }
}
