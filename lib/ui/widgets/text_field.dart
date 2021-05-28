import 'package:flutter/material.dart';
import 'package:medical_ecommerce/res/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final FormFieldValidator<String> validateFunction;
  final void Function(String) onSaved;
  final void Function(String) onChange;

  CustomTextField(
      {this.hint = "",
      this.textEditingController,
      this.keyboardType = TextInputType.name,
      this.obscureText = false,
      this.validateFunction,
      this.onSaved,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.white,
      elevation: 2,
      child: TextFormField(
        validator: validateFunction,
        obscureText: obscureText,
        cursorColor: AppColors.lightgrey,
        decoration: InputDecoration(
          hintText: hint,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        onChanged: onChange,
        onSaved: onSaved,
      ),
    );
  }
}
