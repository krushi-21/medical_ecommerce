import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:medical_ecommerce/core/model/shopmodel.dart';
import 'package:medical_ecommerce/res/app_colors.dart';

import 'package:medical_ecommerce/res/string_const.dart';
import 'package:medical_ecommerce/res/textstyle.dart';
import 'package:medical_ecommerce/ui/screens/productPage.dart';

class ShopCard extends StatelessWidget {
  final ShopModel shopData;
  const ShopCard({
    Key key,
    this.shopData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20.0, right: 20.0, top: 7, bottom: 7),
      child: Card(
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
                  child: Image(
                    image: NetworkImage(
                      shopData.imageUrl,
                    ),
                    fit: BoxFit.fill,
                  )),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: AutoSizeText(
                        shopData.name,
                        style: AppTextStyles.shopNameTextstyle,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: AutoSizeText(
                        shopData.description,
                        style: AppTextStyles.shopDescriptionTextstyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 6.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                    shopData: shopData,
                                  ),
                                ));
                          },
                          child: Container(
                            height: 35,
                            width: 120,
                            decoration: BoxDecoration(
                                color: AppColors.skyblue,
                                borderRadius: BorderRadius.circular(16)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    StringConstants.orderNow,
                                    style: AppTextStyles.orderNowTextstyle,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppColors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
