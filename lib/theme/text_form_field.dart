import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;
 final IconData PrefixiconData;
  final IconData? SuffixiconData;
   CustomTextFormField({super.key,
     required this.text,required this.PrefixiconData,
    this.SuffixiconData});

  @override
  Widget build(BuildContext context,) {
    return Container(
      child: TextFormField(
          decoration: InputDecoration(
          prefixIcon: Icon(PrefixiconData, color: appColors.white),
              suffixIcon: Icon(SuffixiconData,color: appColors.white,),
            hintText: "$text",
      hintStyle: TextStyle(color: appColors.white),
      filled: true,
      fillColor: Colors.grey[900],
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
      ),
      ),
      ),
    );
  }
}
