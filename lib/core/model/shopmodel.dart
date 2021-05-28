import 'package:flutter/material.dart';

class ShopModel with ChangeNotifier {
  final String name;
  final String shopId;
  final String description;
  final String panNumber;
  final String gstNumber;
  final String imageUrl;

  ShopModel({
    @required this.name,
    @required this.shopId,
    @required this.panNumber,
    @required this.description,
    @required this.gstNumber,
    @required this.imageUrl,
  });
}
