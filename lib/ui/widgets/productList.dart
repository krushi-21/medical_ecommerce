import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:medical_ecommerce/core/model/productModel.dart';

import 'package:medical_ecommerce/ui/widgets/productCard.dart';

class ProductList extends StatefulWidget {
  final String shopId;
  ProductList({this.shopId});
  @override
  _ProductListState createState() => _ProductListState();
}

List<ProductModel> productData = List();
DatabaseReference dbRef = FirebaseDatabase.instance.reference();

class _ProductListState extends State<ProductList> {
  double _height = 0;
  double _width = 0;

  @override
  void initState() {
    try {
      fetchData();
    } on Exception catch (e) {
      // TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return productData.isEmpty
        ? Center(
            child: CircularProgressIndicator(
            backgroundColor: Colors.red,
          ))
        : Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: GridView.count(
                primary: true,
                crossAxisCount: 2,
                childAspectRatio: 0.90,
                mainAxisSpacing: 25,
                crossAxisSpacing: 14,
                children: List.generate(productData.length, (index) {
                  return ProductCard(
                      height: _height,
                      width: _width,
                      productData: productData[index]);
                }),
              ),
            ),
          );
  }

  void fetchData() {
    dbRef
        .child('Products')
        .child(widget.shopId)
        .once()
        .then((DataSnapshot snap) {
      productData.clear();
      var data = snap.value;
      data.forEach((key, value) {
        ProductModel shop = new ProductModel(
            productId: value["productId"],
            shopId: value["shopId"],
            name: value["name"],
            description: value["description"],
            price: value["price"].toDouble(),
            imageUrl: value["imageUrl"]);
        print(key);
        productData.add(shop);
      });

      setState(() {
        print(productData);
      });
    });
  }
}
