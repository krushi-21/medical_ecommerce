import 'package:flutter/material.dart';

import 'package:medical_ecommerce/res/app_assets.dart';
import 'package:medical_ecommerce/res/app_colors.dart';
import 'package:medical_ecommerce/res/string_const.dart';
import 'package:medical_ecommerce/res/textstyle.dart';
import 'package:medical_ecommerce/ui/widgets/drawer.dart';

import 'package:medical_ecommerce/ui/widgets/shopsList.dart';

class HomePage extends StatelessWidget {
  double _height = 0;
  double _width = 0;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldKey,
      drawer: myDrawer(context),
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              scaffoldKey.currentState.openDrawer();
              print("clicked");
            },
            child: Image(image: AssetImage(AppAssets.menu))),
      ),
      body: Container(
        height: _height,
        width: _width,
        child: Column(
          children: [
            buildSearchBar(),
            Padding(
              padding: const EdgeInsets.only(
                  right: 20.0, left: 20.0, top: 20.0, bottom: 7.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  StringConstants.shops,
                  style: AppTextStyles.shopTextStyle,
                ),
              ),
            ),
            ShopsList(),
          ],
        ),
      ),
    );
  }

  Padding buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        elevation: 1,
        child: TextField(
          decoration: InputDecoration(
            fillColor: AppColors.searchbarColor,
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
