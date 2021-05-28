import 'dart:ui';
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

class LoginPage extends StatelessWidget {
  GlobalKey<FormState> _key = GlobalKey();
  String _email = "", _password = "";
  final AuthenticationService _authenticationService = AuthenticationService();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("Users");
  double _height = 0;
  double _width = 0;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: _height,
          width: _width,
          child: Stack(clipBehavior: Clip.none, children: [
            buildIamgeContainer(),
            buildLoginContainer(context),
          ]),
        ),
      ),
    );
  }

  Positioned buildLoginContainer(context) {
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
          autovalidateMode: AutovalidateMode.disabled,
          key: _key,
          child: Column(
            children: [
              SizedBox(
                height: _height * 0.059,
              ),
              Text(StringConstants.login, style: AppTextStyles.logintextstyle),
              SizedBox(
                height: _height * 0.044,
              ),

              //Email text field
              Padding(
                padding:
                    EdgeInsets.only(left: _width * 0.1, right: _width * 0.1),
                child: CustomTextField(
                  onSaved: (String val) {
                    _email = val;
                  },
                  textEditingController: emailController,
                  validateFunction: Validations.validateEmail,
                  hint: StringConstants.emailid,
                ),
              ),

              SizedBox(
                height: _height * 0.036,
              ),

              //password textfield
              Padding(
                padding:
                    EdgeInsets.only(left: _width * 0.1, right: _width * 0.1),
                child: CustomTextField(
                  textEditingController: passwordController,
                  hint: StringConstants.password,
                  onSaved: (String val) {
                    _password = val;
                  },
                  obscureText: true,
                  validateFunction: Validations.validatePassword,
                ),
              ),
              SizedBox(
                height: _height * 0.082,
              ),
              CustomButton(
                buttonText: StringConstants.login,
                onTapped: () {
                  FormState form = _key.currentState;
                  form.save();
                  if (form.validate()) {
                    try {
                      _authenticationService.signIn(
                        email: _email,
                        password: _password,
                      );
                      Navigator.pop(context);
                      Navigator.pushNamed(context, MyRoutes.homePage);
                    } on Exception catch (e) {
                      print(e);
                    }
                  } else {}
                },
              ),
              SizedBox(
                height: _height * 0.032,
              ),
              buildRegisterTextRow(context)
            ],
          ),
        ),
      ),
    );
  }

//register text row
  Row buildRegisterTextRow(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          StringConstants.registerText,
          style: TextStyle(color: AppColors.grey, fontSize: 16),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, MyRoutes.emailRegister);
          },
          child: Text(
            StringConstants.register,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                fontSize: 16),
          ),
        ),
      ],
    );
  }

  //image container
  Container buildIamgeContainer() {
    return Container(
      height: _height * 0.3,
      width: _width,
      child: Image.asset(
        AppAssets.loginImage,
        fit: BoxFit.cover,
      ),
    );
  }
}
