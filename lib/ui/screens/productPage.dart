import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:medical_ecommerce/core/model/shopmodel.dart';
import 'package:medical_ecommerce/core/provider/cart.dart';
import 'package:medical_ecommerce/res/app_assets.dart';
import 'package:medical_ecommerce/res/app_colors.dart';
import 'package:medical_ecommerce/res/routes.dart';

import 'package:medical_ecommerce/res/string_const.dart';
import 'package:medical_ecommerce/res/textstyle.dart';

import 'package:medical_ecommerce/ui/widgets/productList.dart';
import 'package:medical_ecommerce/ui/widgets/searchBar.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  double _height = 0;
  double _width = 0;
  final ShopModel shopData;
  ProductPage({this.shopData});

  Future<bool> _onBackPressed(context, cart) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Your All Cart Items will be removed'),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(" No ")),
              TextButton(
                child: Text(" Yes "),
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop(true);
                  cart.clearCart();
                },
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return _onBackPressed(context, cart);
      },
      child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
                onTap: () {
                  _onBackPressed(context, cart);
                },
                child: Image(image: AssetImage(AppAssets.back))),
            actions: [
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, MyRoutes.cartScreen);
                  },
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0, top: 16),
                      child: Image(image: AssetImage(AppAssets.cart)),
                    ),
                    Positioned(
                      right: 12,
                      top: 14,
                      child: Container(
                        height: 16,
                        width: 16,
                        child: Center(
                            child: AutoSizeText(
                          cart.itemsCount.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                        decoration: BoxDecoration(
                            color: AppColors.darkblue,
                            borderRadius: BorderRadius.circular(50.0)),
                      ),
                    )
                  ])),
            ],
          ),
          body: Container(
              height: _height,
              width: _width,
              child: Column(children: [
                SearchBar(),
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
                ProductList(
                  shopId: shopData.shopId,
                ),
              ]))),
    );
  }
}
