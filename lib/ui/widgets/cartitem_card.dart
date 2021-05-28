import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:medical_ecommerce/core/provider/cart.dart';
import 'package:medical_ecommerce/res/app_assets.dart';
import 'package:medical_ecommerce/res/app_colors.dart';

import 'package:medical_ecommerce/res/textstyle.dart';
import 'package:medical_ecommerce/ui/widgets/Counter.dart';
import 'package:provider/provider.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    Key key,
    @required double height,
    @required double width,
    @required String productName,
    @required String productId,
  })  : _height = height,
        _width = width,
        productName = productName,
        productId = productId,
        super(key: key);

  final double _height;
  final double _width;
  final String productName;
  final String productId;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Stack(overflow: Overflow.visible, children: [
        Card(
          elevation: 0.5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(width: 1, color: AppColors.lightgrey)),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Image.asset(
                    AppAssets.loginImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: AutoSizeText(
                        productName,
                        style: AppTextStyles.shopNameTextstyle,
                      ),
                    ),
                  ],
                ),
              ),
              CartCounter(height: _height),
              SizedBox(
                width: _width * 0.030,
              )
            ],
          ),
        ),
        Positioned(
          right: -14.0,
          top: -16,
          child: InkWell(
            onTap: () {
              cart.removeItemFromCart(productId);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.pink,
                  borderRadius: BorderRadius.circular(50.0)),
              height: 35,
              width: 35,
              child: Image.asset(AppAssets.cross),
            ),
          ),
        )
      ]),
    );
  }
}
