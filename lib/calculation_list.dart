import 'package:calculator/calculation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculator/calc_tile.dart';

class CalculationList extends StatefulWidget {
  const CalculationList({super.key});

  @override
  State<CalculationList> createState() => _CalculationListState();
}

class _CalculationListState extends State<CalculationList> {
  @override
  Widget build(BuildContext context) {
    final calculations = Provider.of<List<Calculation>>(context);

    return ListView.builder(
      itemCount: calculations.length,
      itemBuilder: (context, index) {
        return CalcTile(calculation: calculations[index]);
      },
    );
  }
}
