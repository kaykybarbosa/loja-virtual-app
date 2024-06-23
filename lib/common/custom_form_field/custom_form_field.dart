import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    this.hintText = '',
    this.controller,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
    this.suffixOnTap,
    this.validator,
    this.onSaved,
  });

  final String hintText;
  final bool enabled;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final IconData? suffixIcon;
  final Function()? suffixOnTap;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) => TextFormField(
        enabled: enabled,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: suffixOnTap,
                  icon: Icon(suffixIcon),
                )
              : null,
        ),
        keyboardType: keyboardType,
        validator: validator,
        onSaved: onSaved,
      );
}
