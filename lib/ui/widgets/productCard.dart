import 'package:flutter/material.dart';
import 'package:medical_ecommerce/core/model/productModel.dart';
import 'package:medical_ecommerce/res/app_colors.dart';

import 'package:medical_ecommerce/res/textstyle.dart';
import 'package:medical_ecommerce/ui/screens/product_details_page.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productData;
  final double _height;
  final double _width;
  const ProductCard({
    Key key,
    @required double height,
    @required double width,
    @required this.productData,
  })  : _height = height,
        _width = width,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 3,
      borderOnForeground: true,
      shadowColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                print("utut tututu tutu");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(
                        productData: productData,
                      ),
                    ));
              },
              child: Container(
                height: _height * 0.21,
                width: _width * 0.43,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: Center(
                    child: Image(
                  image: NetworkImage(productData.imageUrl[0]),
                  fit: BoxFit.fill,
                )),
              ),
            ),
            Text(
              productData.name ?? "hello",
              style: AppTextStyles.productNameTextstyle,
            ),
            Text(
              productData.price.toString() ?? "15",
              style: AppTextStyles.productPriceTextstyle,
            )
          ],
        ),
      ),
    );
  }
}
