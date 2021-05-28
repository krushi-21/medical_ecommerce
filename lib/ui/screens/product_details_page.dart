import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:medical_ecommerce/core/model/productModel.dart';
import 'package:medical_ecommerce/core/provider/cart.dart';
import 'package:medical_ecommerce/res/app_assets.dart';
import 'package:medical_ecommerce/res/app_colors.dart';
import 'package:medical_ecommerce/res/routes.dart';
import 'package:medical_ecommerce/res/string_const.dart';
import 'package:medical_ecommerce/res/textstyle.dart';
import 'package:medical_ecommerce/ui/widgets/Counter.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel productData;
  ProductDetailsPage({this.productData});
  double _height = 0;
  double _width = 0;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    //Container list for Carousel Slider
    final List<Widget> imageSliders = productData.imageUrl
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          item,
                          fit: BoxFit.fill,
                          width: 1000.0,
                          height: 350,
                        ),
                      ],
                    )),
              ),
            ))
        .toList();

    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
        child: Column(children: [
          CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 1.5,
                onPageChanged: (index, reason) {}),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 35.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      productData.name,
                      style: AppTextStyles.productName2Textstyle,
                    ),
                    Spacer(),
                    DetailsPageCounter(height: _height),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "\$ ${productData.price}",
                    style: AppTextStyles.productPrice2Textstyle,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("DESCRIPTION",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 15,
                ),
                AutoSizeText(
                  productData.description,
                  style: AppTextStyles.productDescriptionTextstyle,
                ),
                SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    cart.addItemToCart(productData.productId, productData.name,
                        productData.price, productData.imageUrl[0]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.darkblue,
                        borderRadius: BorderRadius.circular(2.0)),
                    height: _height * 0.065,
                    width: _width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_bag_outlined,
                            color: AppColors.white, size: 18),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          StringConstants.addToCart,
                          style:
                              TextStyle(color: AppColors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
