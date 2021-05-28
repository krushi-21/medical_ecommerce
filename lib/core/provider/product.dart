import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ShopProducts {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('Products');

  Future<void> uploadProduct({
    String shopId,
    String productId,
    String name,
    String description,
    double price,
    List<dynamic> images,
  }) async {
    //
    DatabaseReference dbRef =
        FirebaseDatabase.instance.reference().child("Products");
    String key = dbRef.push().key;
    List<String> imgUrl = [];
    String _mainurl;
    try {
      for (int i = 0; i < images.length; i++) {
        print("for loop running");
        print(i);
        var file = File(images[i]);
        print(file.toString());
        if (file != null) {
          firebase_storage.Reference firebaseStorageRef = firebase_storage
              .FirebaseStorage.instance
              .ref()
              .child('uploads/${DateTime.now()}');
          firebase_storage.UploadTask uploadTask =
              firebaseStorageRef.putFile(file);
          try {
            await uploadTask.whenComplete(() async {
              _mainurl = (await firebaseStorageRef.getDownloadURL()).toString();
            });

            imgUrl.add(_mainurl);
          } catch (e) {
            print("download url error");
          }
        } else {
          print("Not uploaded");
        }
      }
    } on Exception catch (e) {
      print(e);
    }
    return dbRef.child(shopId).child(key).set({
      "productId": productId,
      "name": name,
      "description": description,
      "price": price.toDouble(),
      "imageUrl": imgUrl
    }).then((res) {});
  }
}
