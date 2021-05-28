import 'package:flutter/material.dart';
import 'package:medical_ecommerce/res/app_assets.dart';
import 'package:medical_ecommerce/res/app_colors.dart';
import 'package:medical_ecommerce/res/string_const.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        elevation: 1,
        color: AppColors.searchbarColor,
        child: TextField(
          decoration: InputDecoration(
            fillColor: Colors.black,
            border: InputBorder.none,
            icon: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image.asset(
                AppAssets.searchImage,
                color: AppColors.grey,
              ),
            ),
            hintText: StringConstants.discoverShop,
          ),
        ),
      ),
    );
  }
}
