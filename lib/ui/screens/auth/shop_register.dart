import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multiple_image_picker/flutter_multiple_image_picker.dart';
import 'package:medical_ecommerce/core/provider/auth.dart';
import 'package:medical_ecommerce/core/provider/shops.dart';
import 'package:medical_ecommerce/res/app_assets.dart';
import 'package:medical_ecommerce/res/app_colors.dart';
import 'package:medical_ecommerce/res/routes.dart';
import 'package:medical_ecommerce/res/string_const.dart';
import 'package:medical_ecommerce/res/textstyle.dart';
import 'package:medical_ecommerce/res/validation.dart';
import 'package:medical_ecommerce/ui/widgets/custom_button.dart';
import 'package:medical_ecommerce/ui/widgets/text_field.dart';

class ShopRegister extends StatefulWidget {
  @override
  _ShopRegisterState createState() => _ShopRegisterState();
}

class _ShopRegisterState extends State<ShopRegister> {
  GlobalKey<FormState> _key = GlobalKey();

  //Shop Provider
  ShopsProvider _shopsProvider = new ShopsProvider();

  final FirebaseAuth firebaseUser = FirebaseAuth.instance;
  final AuthenticationService _authenticationService = AuthenticationService();

  String _shopName = "",
      _shopDescription = "",
      _shopPanNumber = '',
      _shopGstNumber = '';

  //multi image picker
  double _height = 0;
  double _width = 0;
  String _platformMessage = '';
  List images;
  int maxImageNo = 1;
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
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image(image: AssetImage(AppAssets.back))),
      ),
      body: Container(
        height: _height,
        width: _width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.backGroundColor,
              spreadRadius: 1.0,
            )
          ],
          color: AppColors.primaryColor,
        ),
        child: SingleChildScrollView(child: buildRegisterContainer(context)),
      ),
    );
  }

  Form buildRegisterContainer(context) {
    return Form(
      key: _key,
      child: Padding(
        padding: EdgeInsets.only(left: _width * 0.1, right: _width * 0.1),
        child: Column(
          children: [
            SizedBox(
              height: _height * 0.059,
            ),
            Text(StringConstants.registerShop,
                style: AppTextStyles.logintextstyle),
            SizedBox(
              height: _height * 0.044,
            ),
            //Shop Name TextField

            CustomTextField(
              hint: StringConstants.shopName,
              validateFunction: Validations.validateName,
              onSaved: (value) {
                _shopName = value;
              },
            ),
            SizedBox(
              height: _height * 0.036,
            ),

            //Pan Number TextField
            CustomTextField(
              hint: StringConstants.panNumber,
              validateFunction: Validations.validatePanNumber,
              onSaved: (value) {
                _shopPanNumber = value;
              },
            ),
            SizedBox(
              height: _height * 0.036,
            ),

            //Gst Number TextField
            CustomTextField(
              hint: StringConstants.gstNumber,
              validateFunction: Validations.validateGstNumber,
              onSaved: (value) {
                _shopGstNumber = value;
              },
            ),
            SizedBox(
              height: _height * 0.036,
            ),
            buildShopDescriptionTextField(),
            SizedBox(
              height: _height * 0.026,
            ),
            Row(children: [
              Text(
                "Shop Image",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Container(
                child: IconButton(
                  onPressed: initMultiPickUp,
                  icon: new Icon(Icons.add_photo_alternate_outlined),
                ),
              ),
            ]),
            images == null ? buildNullImage() : buildSelectedImage(context),
            SizedBox(
              height: _height * 0.042,
            ),
            buildSubmitButton(context),
            SizedBox(
              height: _height * 0.032,
            ),
          ],
        ),
      ),
    );
  }

  Material buildShopDescriptionTextField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.white,
      elevation: 2,
      child: TextFormField(
        minLines: 1,
        maxLines: 5,
        onSaved: (value) {
          _shopDescription = value;
        },
        cursorColor: AppColors.lightgrey,
        decoration: InputDecoration(
          hintText: "Shop Description",
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  GestureDetector buildNullImage() {
    return GestureDetector(
      onTap: initMultiPickUp,
      child: new Container(
        height: 150.0,
        width: 150.0,
        child: new Icon(
          Icons.image,
          size: 50.0,
        ),
      ),
    );
  }

  SizedBox buildSelectedImage(context) {
    return new SizedBox(
      height: 150.0,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: new Image.file(
            new File(images[0].toString()),
          ),
        ),
      ),
    );
  }

  CustomButton buildSubmitButton(context) {
    return CustomButton(
      buttonText: StringConstants.submit,
      onTapped: () {
        FormState form = _key.currentState;
        form.save();
        try {
          if (_authenticationService.updateUser(firebaseUser.currentUser.uid) !=
              null) {
            _shopsProvider.addShop(
                id: firebaseUser.currentUser.uid,
                name: _shopName,
                gstNumber: _shopGstNumber,
                panNumber: _shopPanNumber,
                description: _shopDescription,
                images: images);
          }
          Navigator.pushNamed(context, MyRoutes.homePage);
        } catch (e) {
          print("Not Saved" + e);
        }
      },
    );
  }
}
