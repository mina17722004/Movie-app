import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;
  final IconData PrefixiconData;
  final IconData? SuffixiconData;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? suffixOnTap;

  CustomTextFormField({
    super.key,
    required this.text,
    required this.PrefixiconData,
    this.SuffixiconData,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.suffixOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(PrefixiconData, color: Colors.white),
        suffixIcon: SuffixiconData != null
            ? GestureDetector(
          onTap: suffixOnTap,
          child: Icon(SuffixiconData, color: Colors.white),
        )
            : null,
        hintText: text,
        hintStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
