import 'package:flutter/material.dart';
import 'package:calculator/calculation.dart';

class CalcTile extends StatelessWidget {
  final Calculation calculation;
  CalcTile({required this.calculation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,
          ),
          title: Text(calculation.name),
          subtitle: Text(calculation.calculation),
        ),
      ),
    );
  }
}
