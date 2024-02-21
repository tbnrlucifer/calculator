import 'package:calculator/authenticate.dart';
import 'package:calculator/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculator/myuser.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    // return eiter Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
