import 'package:ecommerce_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final IconData? icon;
  final bool isPassword;
  final bool obscureText;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final void Function(String)? onFieldSubmitted;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool readOnly;

  InputField({
    required this.controller,
    this.focusNode,
    required this.hintText,
    this.icon,
    this.isPassword = false,
    this.obscureText = false,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        onFieldSubmitted: onFieldSubmitted,
        readOnly: readOnly,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.secondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primary),
          ),
          hintText: hintText,
          fillColor: AppColors.secondary,
          filled: true,
          prefixIcon: Icon(icon),
          suffixIcon: suffixIcon,
        ),
        onChanged: (value) {
          if (onChanged != null) {
            onChanged!(value);
          }
        },
        validator: validator,
      ),
    );
  }
}