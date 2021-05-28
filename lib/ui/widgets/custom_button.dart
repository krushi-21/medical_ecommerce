import 'package:flutter/material.dart';
import 'package:medical_ecommerce/res/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final void Function() onTapped;
  CustomButton({
    this.buttonText = "",
    this.onTapped,
  });
  double _height = 0;
  double _width = 0;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTapped,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.darkblue, borderRadius: BorderRadius.circular(50)),
        height: _height * 0.065,
        width: _width * 0.8,
        child: Center(
            child: Text(
          buttonText,
          style: TextStyle(color: AppColors.white, fontSize: 26),
        )),
      ),
    );
  }
}
