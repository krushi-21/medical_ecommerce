import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class ShopsProvider with ChangeNotifier {
  final CollectionReference shopsCollection =
      FirebaseFirestore.instance.collection('Shops');
  DatabaseReference dbRef = FirebaseDatabase.instance.reference();
  // List<ShopModel> shopData = List();

  // List<ShopModel> get shops {
  //   print("getting shops");
  //   dbRef.child('Shops').once().then((DataSnapshot snap) {
  //     shopData.clear();
  //     var data = snap.value;
  //     print("Hellooooo" + data.toString());
  //     data.forEach((key, value) {
  //       ShopModel shop = new ShopModel(
  //         shopId: value["shopId"],
  //         description: value["description"],
  //         gstNumber: value["gstNumber"],
  //         imageUrl: value["imageUrl"],
  //         name: value["name"],
  //         panNumber: value["panNumber"],
  //       );

  //       shopData.add(shop);
  //     });
  //   });
  //   print("shops returned");
  //   print("hiiiiii" + shopData.toString());
  //   return shopData.toList();
  // }

  // Stream<List<ShopModel>> get shop {
  //   return [...shopsFromSnapShot];
  // }

  Future<String> addShop(
      {String id,
      String name,
      String description,
      String panNumber,
      String gstNumber,
      List images}) async {
    DatabaseReference dbRef =
        FirebaseDatabase.instance.reference().child("Shops");
    String _mainurl;
    var file = File(images[0]);
    print(file.toString());
    if (file != null) {
      firebase_storage.Reference firebaseStorageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('uploads/${DateTime.now()}');
      firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(file);
      try {
        await uploadTask.whenComplete(() async {
          _mainurl = (await firebaseStorageRef.getDownloadURL()).toString();
        });
      } catch (e) {
        print("download url error");
      }
    } else {
      print("Not uploaded");
    }

    return dbRef.child(id).set({
      "shopId": id,
      "name": name,
      "description": description,
      "panNumber": panNumber,
      "gstNumber": gstNumber,
      "imageUrl": _mainurl
    }).then((res) {
      return "Shop Added";
    });
  }
}
