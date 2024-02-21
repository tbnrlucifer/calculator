// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:calculator/button_values.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String num1 = "";
  String operator = "";
  String num2 = "";

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "$num1$operator$num2".isEmpty ? "0" : "$num1$operator$num2",
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
            Wrap(
              children: Btn.buttonValues
                  .map(
                    (value) => SizedBox(
                      width: screenSize.width / 4,
                      height: screenSize.width / 5,
                      child: buildButton(value),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 59, 83, 96),
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: InkWell(
          onTap: () => buttonTap(value),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void buttonTap(String value) {
    if (value == Btn.del) {
      delete();
      return;
    }
    if (value == Btn.clr) {
      clearAll();
      return;
    }
    if (value == Btn.per) {
      convertToPercentage();
      return;
    }
    if (value == Btn.calculate) {
      calculate();
      return;
    }
    appendValue(value);
  }

  void calculate() {
    if (num1.isEmpty) return;
    if (operator.isEmpty) return;
    if (num2.isEmpty) return;

    final double number1 = double.parse(num1);
    final double number2 = double.parse(num2);

    var result = 0.0;
    switch (operator) {
      case Btn.add:
        result = number1 + number2;
        break;
      case Btn.subtract:
        result = number1 - number2;
        break;
      case Btn.multiply:
        result = number1 * number2;
        break;
      case Btn.divide:
        result = number1 / number2;
        break;
      default:
    }

    setState(() {
      num1 = result.toStringAsPrecision(3);
      if (num1.endsWith(".0")) {
        num1 = num1.substring(0, num1.length - 2);
      }
      operator = "";
      num2 = "";
    });
  }

  void convertToPercentage() {
    if (num1.isNotEmpty && operator.isNotEmpty && num2.isNotEmpty) {
      calculate();
    }
    if (operator.isNotEmpty) {
      return;
    }
    final number = double.parse(num1);
    setState(() {
      num1 = "${(number / 100)}";
      operator = "";
      num2 = "";
    });
  }

  void clearAll() {
    setState(() {
      num1 = "";
      operator = "";
      num2 = "";
    });
  }

  void delete() {
    if (num2.isNotEmpty) {
      num2 = num2.substring(0, num2.length - 1);
    } else if (operator.isNotEmpty) {
      operator = "";
    } else if (num1.isNotEmpty) {
      num1 = num1.substring(0, num1.length - 1);
    }
    setState(() {});
  }

  void appendValue(String value) {
    if ((value != Btn.dot) && (int.tryParse(value) == null)) {
      if (operator.isNotEmpty && num2.isNotEmpty) {
        calculate();
      }
      operator = value;
    } else if (num1.isEmpty || operator.isEmpty) {
      if (value == Btn.dot && num1.contains(Btn.dot)) return;
      if (value == Btn.dot && (num1.isEmpty || num1 == Btn.n0)) {
        value = "0.";
      }
      num1 += value;
    } else if (num2.isEmpty || operator.isNotEmpty) {
      if (value == Btn.dot && num2.contains(Btn.dot)) return;
      if (value == Btn.dot && (num2.isEmpty || num2 == Btn.n0)) {
        value = "0.";
      }
      num2 += value;
    }
    setState(() {});
  }

  Color getBtnColor(value) {
    return [Btn.del, Btn.clr].contains(value)
        ? const Color.fromARGB(255, 59, 83, 96)
        : [
            Btn.per,
            Btn.multiply,
            Btn.add,
            Btn.subtract,
            Btn.divide,
            Btn.calculate,
          ].contains(value)
            ? Colors.orange
            : const Color.fromARGB(255, 219, 230, 236);
  }
}
