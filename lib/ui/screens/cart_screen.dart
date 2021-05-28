import 'package:flutter/material.dart';
import 'package:medical_ecommerce/core/provider/cart.dart';
import 'package:medical_ecommerce/res/app_assets.dart';
import 'package:medical_ecommerce/res/app_colors.dart';
import 'package:medical_ecommerce/res/string_const.dart';
import 'package:medical_ecommerce/ui/widgets/cartitem_card.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  double _height = 0;
  double _width = 0;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image(image: AssetImage(AppAssets.back))),
      ),
      body: Container(
        height: _height,
        width: _width,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: cart.itemsCount,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return CartItemCard(
                      height: _height,
                      width: _width,
                      productName: cart.cartItems.values.toList()[index].title,
                      productId: cart.cartItems.values.toList()[index].id,
                    );
                  }),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                height: _height * 0.120,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(width: 1, color: AppColors.lightgrey)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Sub Total"),
                        Spacer(),
                        Text(cart.totalPriceAmount.toString())
                      ],
                    ),
                    Row(
                      children: [
                        Text("Estimated Tax"),
                        Spacer(),
                        Text(cart.gstforProducts.toStringAsFixed(2))
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text("Total Payable"),
                        Spacer(),
                        Text(cart.totalPayableAmount.toStringAsFixed(2))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 10, bottom: 20.0),
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.darkblue,
                      borderRadius: BorderRadius.circular(2.0)),
                  height: _height * 0.065,
                  width: _width,
                  child: Center(
                    child: Text(
                      StringConstants.checkOutText,
                      style: TextStyle(color: AppColors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
