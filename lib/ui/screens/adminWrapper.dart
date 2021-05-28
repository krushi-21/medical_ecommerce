import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:medical_ecommerce/core/model/user.dart';
import 'package:medical_ecommerce/core/provider/auth.dart';
import 'package:medical_ecommerce/ui/screens/auth/register_page.dart';
import 'package:medical_ecommerce/ui/screens/auth/shop_register.dart';
import 'package:medical_ecommerce/ui/screens/shopdashboard.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminWrapper extends StatefulWidget {
  @override
  _AdminWrapperState createState() => _AdminWrapperState();
}

class _AdminWrapperState extends State<AdminWrapper> {
  DatabaseReference dbRef = FirebaseDatabase.instance.reference();
  bool admin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBoolValuesSF();
  }

  void getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool boolValue = prefs.getBool('admin');
    admin = boolValue;
    print("printing SF");
    setState(() {
      print(admin);
    });
    print("printing SF");
  }

  @override
  Widget build(BuildContext context) {
    return admin == null
        ? Center(child: CircularProgressIndicator())
        : admin == true
            ? ShopDashBoard()
            : ShopRegister();
  }
}
