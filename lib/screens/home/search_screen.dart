import 'package:flutter/material.dart';
import 'package:mm/theme/app_assets.dart';
import 'package:mm/theme/text_form_field.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 25),
          child: CustomTextFormField(text: "Search",
              PrefixiconData: Icons.search_outlined),
        ),
      Expanded(child: Center(child: Image.asset(AppAssets.empty)))
      ],
    );
  }
}