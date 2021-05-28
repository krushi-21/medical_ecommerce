import 'package:flutter/cupertino.dart';

class UserData with ChangeNotifier {
  final String uid;
  final bool admin;
  UserData({this.uid, this.admin});
}
