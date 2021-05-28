import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multiple_image_picker/flutter_multiple_image_picker.dart';
import 'package:medical_ecommerce/core/provider/product.dart';
import 'package:medical_ecommerce/res/app_assets.dart';
import 'package:medical_ecommerce/res/app_colors.dart';
import 'package:medical_ecommerce/res/routes.dart';
import 'package:medical_ecommerce/res/string_const.dart';
import 'package:medical_ecommerce/res/textstyle.dart';
import 'package:medical_ecommerce/ui/widgets/custom_button.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  //keys
  GlobalKey<FormState> _key = GlobalKey();

  final FirebaseAuth firebaseUser = FirebaseAuth.instance;

  //Comntrollers
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDescriptonController =
      TextEditingController();
  final TextEditingController productPriceController = TextEditingController();

  String _productName = "", _productDescription = "";
  double _productPrice;

  //product provider
  final ShopProducts _shopProduct = new ShopProducts();

  //Multi image upload
  String _platformMessage = 'No Error';
  List images;
  int maxImageNo = 8;
  bool selectSingleImage = false;

  initMultiPickUp() async {
    setState(() {
      images = null;
      _platformMessage = 'No Error';
    });
    List resultList;
    String error;
    try {
      resultList = await FlutterMultipleImagePicker.pickMultiImages(
          maxImageNo, selectSingleImage);
    } on PlatformException catch (e) {
      error = e.message;
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _platformMessage = 'No Error Dectected';
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // productNameController.dispose();
    // productDescriptonController.dispose();
    // productPriceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizedBox sizedBox = new SizedBox(
      height: 16,
    );
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image(image: AssetImage(AppAssets.back))),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizedBox,
                  Row(
                    children: [
                      Text(
                        "Attach Image",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Container(
                        child: IconButton(
                          onPressed: initMultiPickUp,
                          icon: new Icon(Icons.add_photo_alternate_outlined),
                        ),
                      )
                    ],
                  ),
                  sizedBox,
                  SingleChildScrollView(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: images == null
                        ? buildImageNotSelected()
                        : buildSelectedImages(context),
                  ),
                  sizedBox,
                  Text(
                    "Product Name",
                    style: AppTextStyles.addProductTextStyle,
                  ),
                  sizedBox,
                  textField("Product Name", productNameController, _productName,
                      null, null),
                  sizedBox,
                  Text(
                    "Price",
                    style: AppTextStyles.addProductTextStyle,
                  ),
                  sizedBox,
                  textField(
                      "Price", productPriceController, _productPrice, 1, 5),
                  sizedBox,
                  Text(
                    "Description",
                    style: AppTextStyles.addProductTextStyle,
                  ),
                  sizedBox,
                  textField("Description", productDescriptonController,
                      _productDescription, null, null),
                  sizedBox,
                  sizedBox,
                  buildSubmitButton(context),
                  sizedBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector buildImageNotSelected() {
    return GestureDetector(
      onTap: initMultiPickUp,
      child: new Container(
        height: 180.0,
        width: 150.0,
        child: new Icon(
          Icons.image,
          size: 50.0,
        ),
      ),
    );
  }

  SizedBox buildSelectedImages(BuildContext context) {
    return new SizedBox(
      height: 180.0,
      width: MediaQuery.of(context).size.width,
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) => new Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: new Image.file(
              new File(images[index].toString()),
            ),
          ),
        ),
        itemCount: images.length,
      ),
    );
  }

  Align buildSubmitButton(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CustomButton(
        buttonText: StringConstants.add,
        onTapped: () {
          FormState form = _key.currentState;
          form.save();
          print("products price" + productNameController.text);
          print("product description" + productDescriptonController.text);
          print(double.parse(productPriceController.text));
          try {
            _shopProduct.uploadProduct(
                shopId: firebaseUser.currentUser.uid,
                productId: DateTime.now().toString(),
                name: productNameController.text,
                description: productDescriptonController.text,
                price: double.parse(productPriceController.text),
                images: images);
            Navigator.pushNamed(context, MyRoutes.homePage);
          } catch (e) {
            print("Not Saved" + e);
          }
        },
      ),
    );
  }

  Widget textField(hinttext, controller, _value, minLines, maxLines) {
    return Material(
      borderRadius: BorderRadius.circular(8.0),
      elevation: 1,
      color: AppColors.searchbarColor,
      child: TextFormField(
        minLines: minLines,
        maxLines: maxLines,
        onSaved: (String val) {
          _value = val;
        },
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.black,
          border: InputBorder.none,
          icon: Padding(
            padding: const EdgeInsets.only(left: 8.0),
          ),
          hintText: hinttext,
        ),
      ),
    );
  }
}
