import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      required this.labelText,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.autofocus = false,
      this.isPassword = false,
      this.validator,
      this.autovalidateMode,
      this.prefixIcon,
      this.suffixIcon,
      this.fillColor,
      this.onChange});

  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool autofocus;
  final bool isPassword;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;
  final Color? fillColor;
  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      cursorColor: const Color.fromARGB(255, 0, 0, 0),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: labelText,
        labelStyle: const TextStyle(color: Color(0xff9D9D9D)),
        border: InputBorder.none,
        filled: true,
        fillColor: fillColor,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        prefixIcon: prefixIcon,
        prefixIconColor: const Color(0xff9D9D9D),
        suffixIcon: suffixIcon,
        suffixIconColor: const Color(0xff9D9D9D),
      ),
      validator: validator,
      obscureText: isPassword,
      keyboardType: keyboardType,
      autovalidateMode: autovalidateMode,
      onChanged: onChange,
    );
  }
}
