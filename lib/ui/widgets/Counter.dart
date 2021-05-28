import 'package:flutter/material.dart';
import 'package:medical_ecommerce/res/app_assets.dart';
import 'package:medical_ecommerce/res/app_colors.dart';

class CartCounter extends StatelessWidget {
  const CartCounter({
    Key key,
    @required double height,
  })  : _height = height,
        super(key: key);

  final double _height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(width: 1, color: AppColors.lightgrey)),
      height: _height * 0.099,
      width: 24,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
            child: Image.asset(AppAssets.minus),
          ),
          SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text("1"),
          ),
          SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.asset(AppAssets.plus),
          ),
        ],
      ),
    );
  }
}

class DetailsPageCounter extends StatelessWidget {
  const DetailsPageCounter({
    Key key,
    @required double height,
  })  : _height = height,
        super(key: key);

  final double _height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(width: 1, color: AppColors.lightgrey)),
      height: _height * 0.040,
      child: Row(
        children: [
          SizedBox(
            width: 4,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.asset(AppAssets.minus),
          ),
          SizedBox(
            width: 6,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text("1"),
          ),
          SizedBox(
            width: 6,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.asset(AppAssets.plus),
          ),
          SizedBox(
            width: 4,
          ),
        ],
      ),
    );
  }
}
