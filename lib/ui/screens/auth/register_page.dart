import 'package:flutter/material.dart';
import 'package:medical_ecommerce/res/app_assets.dart';
import 'package:medical_ecommerce/res/app_colors.dart';

import 'package:medical_ecommerce/res/string_const.dart';
import 'package:medical_ecommerce/res/textstyle.dart';
import 'package:medical_ecommerce/res/validation.dart';
import 'package:medical_ecommerce/ui/screens/auth/password_page.dart';
import 'package:medical_ecommerce/ui/widgets/custom_button.dart';
import 'package:medical_ecommerce/ui/widgets/text_field.dart';

class RegisterPage extends StatelessWidget {
  double _height = 0;
  double _width = 0;

  String email = "", name = "";
  String phone;

  GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
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
        AppAssets.registerImage1,
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
              Padding(
                padding:
                    EdgeInsets.only(left: _width * 0.1, right: _width * 0.1),
                child: CustomTextField(
                  hint: StringConstants.emailid,
                  textEditingController: emailController,
                  onSaved: (String val) {
                    email = val;
                  },
                  validateFunction: Validations.validateEmail,
                ),
              ),
              SizedBox(
                height: _height * 0.036,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: _width * 0.1, right: _width * 0.1),
                child: CustomTextField(
                  hint: StringConstants.fullName,
                  textEditingController: nameController,
                  onSaved: (String val) {
                    name = val;
                  },
                  validateFunction: Validations.validateName,
                ),
              ),
              SizedBox(
                height: _height * 0.036,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: _width * 0.1, right: _width * 0.1),
                child: CustomTextField(
                  hint: StringConstants.phoneNo,
                  textEditingController: phoneController,
                  onSaved: (String val) {
                    phone = val;
                  },
                  validateFunction: Validations.validatePhoneNumber,
                ),
              ),
              SizedBox(
                height: _height * 0.082,
              ),
              CustomButton(
                buttonText: StringConstants.next,
                onTapped: () async {
                  FormState form = _key.currentState;
                  form.save();
                  if (form.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PasswordPage(
                              name: name, email: email, phone: phone),
                        ));
                  } else {}
                },
              ),
              SizedBox(
                height: _height * 0.032,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScreenArguments {
  final String email;
  final String name;
  final String phone;

  ScreenArguments(this.email, this.name, this.phone);
}
