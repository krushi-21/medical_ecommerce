import 'package:flutter/material.dart';
import 'package:medical_ecommerce/core/provider/auth.dart';
import 'package:medical_ecommerce/res/routes.dart';
import 'package:medical_ecommerce/res/string_const.dart';
import 'package:provider/provider.dart';

Widget myDrawer(context) {
  final user = Provider.of<AuthenticationService>(context);
  return Drawer(
    child: ListView(
      children: <Widget>[
        ListTile(
          title: Text("Edit Profile"),
          trailing: Icon(Icons.edit),
        ),
        // ListTile(
        //   title: Text(StringConstants.registerShop),
        //   trailing: Icon(Icons.arrow_forward),
        //   onTap: () {
        //     Navigator.pop(context);
        //     Navigator.pushNamed(context, MyRoutes.shopregister);
        //   },
        // ),
        ListTile(
          title: Text("My Orders"),
          trailing: Icon(Icons.arrow_forward),
        ),
        ListTile(
          title: Text("Shop Dashboard"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, MyRoutes.adminWrapper);
          },
        ),
        ListTile(
          title: Text("Sign Out"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () async {
            await user.signOut();
            Navigator.of(context).pushReplacementNamed('/login');
            print(user);
          },
        ),
      ],
    ),
  );
}
