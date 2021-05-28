import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:medical_ecommerce/core/model/shopmodel.dart';
import 'package:medical_ecommerce/core/model/user.dart';
import 'package:medical_ecommerce/core/provider/shops.dart';
import 'package:medical_ecommerce/core/provider/shops.dart';

import 'package:medical_ecommerce/ui/widgets/shop_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopsList extends StatefulWidget {
  @override
  _ShopsListState createState() => _ShopsListState();
}

List<ShopModel> shopData = List();
DatabaseReference dbRef = FirebaseDatabase.instance.reference();
var user;
bool admin = false;

class _ShopsListState extends State<ShopsList> {
  @override
  void initState() {
    fetchData();
    fetchuser();
  }

  @override
  Widget build(BuildContext context) {
    return shopData.isNotEmpty
        ? Expanded(
            child: ListView.builder(
                itemCount: shopData.length,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ShopCard(
                    shopData: shopData[index],
                  );
                }))
        : Center(
            child: CircularProgressIndicator(
            backgroundColor: Colors.red,
          ));
  }

  void fetchuser() async {
    user = FirebaseAuth.instance.currentUser.uid;
    await dbRef.child('Users').child(user).once().then((DataSnapshot snap) {
      var data = snap.value;
      admin = data["isAdmin"] ?? false;
      print("printing admin");
      print(admin);
      print("printing admin");
      UserData(uid: user, admin: admin);
      print("SF called");
      addBoolToSF(admin);
    });
  }

  addBoolToSF(value) async {
    print("In SF");
    try {
      SharedPreferences.setMockInitialValues({});
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('admin', value).then((value) => print("data enterd"));
    } on Exception catch (e) {
      print("helloooooooo" + e.toString()); // TODO
    }
  }

  void fetchData() {
    dbRef.child('Shops').once().then((DataSnapshot snap) {
      shopData.clear();
      var data = snap.value;
      data.forEach((key, value) {
        ShopModel shop = new ShopModel(
          shopId: value["shopId"],
          description: value["description"],
          gstNumber: value["gstNumber"],
          imageUrl: value["imageUrl"],
          name: value["name"],
          panNumber: value["panNumber"],
        );

        shopData.add(shop);
      });

      setState(() {
        print(shopData);
      });
    });
  }
}
