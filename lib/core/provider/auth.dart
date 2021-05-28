import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  User get currentUser => _firebaseAuth.currentUser;

  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("Users");

  Future<void> signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp(
      {@required String email,
      @required String password,
      @required String phone,
      @required String name}) async {
    try {
      print(name + ":name");
      print(email + ":email");
      print(phone + ":phone");
      print(password + ":password");
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) {
        dbRef.child(result.user.uid).set({
          "uid": result.user.uid,
          "email": email,
          "phone no": phone,
          "name": name,
          "isAdmin": false,
        }).then((res) {});
      }).catchError((err) {
        print(err);
      });
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> updateUser(String uid) {
    return dbRef.child(uid).update({'isAdmin': true}).then((value) {
      print("Admin Created");
    }).onError((error, stackTrace) {
      print("error in admin cration");
    });
  }
}
