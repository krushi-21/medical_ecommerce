import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:medical_ecommerce/core/provider/auth.dart';
import 'package:medical_ecommerce/res/app_assets.dart';
import 'package:medical_ecommerce/res/app_colors.dart';
import 'package:medical_ecommerce/res/routes.dart';

import 'package:medical_ecommerce/res/string_const.dart';
import 'package:medical_ecommerce/res/textstyle.dart';
import 'package:medical_ecommerce/res/validation.dart';
import 'package:medical_ecommerce/ui/widgets/custom_button.dart';
import 'package:medical_ecommerce/ui/widgets/text_field.dart';

// ignore: must_be_immutable
class PasswordPage extends StatelessWidget {
  String name;
  String email;
  String phone;
  PasswordPage({Key key, this.name, this.email, this.phone}) : super(key: key);
  String _password = "", _confirmpass = "";
  GlobalKey<FormState> _key = GlobalKey();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("Users");
  AuthenticationService _authenticationService = AuthenticationService();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  double _height = 0;
  double _width = 0;
  @override
  Widget build(BuildContext context) {
    print("front page");
    print(email.toString() + "helluu");
    print(name);
    print(phone);
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: _height,
          width: _width,
          child: Stack(clipBehavior: Clip.none, children: [
            buildIamgeContainer(),
            buildRegisterContainer(context),
          ]),
        ),
      ),
    );
  }

  Container buildIamgeContainer() {
    return Container(
      height: _height * 0.3,
      width: _width,
      child: Image.asset(
        AppAssets.registerImage2,
        fit: BoxFit.cover,
      ),
    );
  }

  Positioned buildRegisterContainer(context) {
    return Positioned(
      top: _height * 0.28,
      child: Container(
        height: _height * 0.8,
        width: _width,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.backGroundColor,
                spreadRadius: 1.0,
              )
            ],
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        child: Form(
          key: _key,
          child: Column(
            children: [
              SizedBox(
                height: _height * 0.059,
              ),
              Text(StringConstants.register,
                  style: AppTextStyles.logintextstyle),
              SizedBox(
                height: _height * 0.044,
              ),
              buildPasswordTextField(),
              SizedBox(
                height: _height * 0.036,
              ),
              buildConfirmPasswordTextField(),
              SizedBox(
                height: _height * 0.082,
              ),
              buildSubmitButton(context),
              SizedBox(
                height: _height * 0.032,
              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomButton buildSubmitButton(context) {
    return CustomButton(
      buttonText: StringConstants.signin,
      onTapped: () {
        FormState form = _key.currentState;
        form.save();
        if (form.validate()) {
          if (_password == _confirmpass) {
            try {
              _authenticationService
                  .signUp(
                email: email,
                name: name,
                phone: phone,
                password: _password,
              )
                  .then((value) {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushNamed(context, MyRoutes.homePage);
              });
            } on Exception catch (e) {
              print(e);
            }
          }
        } else {}
      },
    );
  }

  Padding buildConfirmPasswordTextField() {
    return Padding(
      padding: EdgeInsets.only(left: _width * 0.1, right: _width * 0.1),
      child: CustomTextField(
        hint: StringConstants.confirmPassword,
        obscureText: true,
        onSaved: (String val) {
          _confirmpass = val;
        },
        validateFunction: Validations.validatePassword,
      ),
    );
  }

  Padding buildPasswordTextField() {
    return Padding(
      padding: EdgeInsets.only(left: _width * 0.1, right: _width * 0.1),
      child: CustomTextField(
        hint: StringConstants.password,
        obscureText: true,
        onSaved: (String val) {
          _password = val;
        },
        validateFunction: Validations.validatePassword,
      ),
    );
  }
}
