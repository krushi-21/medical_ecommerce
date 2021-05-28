import 'package:flutter/foundation.dart';

class ProductModel with ChangeNotifier {
  final String productId;
  final String shopId;
  final String name;
  final String description;
  final double price;
  final List<dynamic> imageUrl;

  ProductModel({
    @required this.productId,
    @required this.shopId,
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
  });
}
