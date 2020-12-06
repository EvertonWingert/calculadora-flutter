import 'package:flutter/material.dart';

import 'package:calculadora/button.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculadora(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Calculadora extends StatefulWidget {
  Calculadora({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final bgPrimarysColor = const Color(0xff222831);
  final bgSecundaryColor = const Color(0xff393e46);
  final highlightColor = const Color(0xff00adb5);

  var screenOperation = '';
  var screenResult = '';
  var anterior = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    "4",
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPrimarysColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.centerLeft,
                        child: Text(screenOperation,
                            style:
                                TextStyle(fontSize: 20, color: Colors.white))),
                    Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.centerRight,
                        child: Text(screenResult,
                            style:
                                TextStyle(fontSize: 40, color: Colors.white)))
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Center(
                  child: GridView.builder(
                      itemCount: buttons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (BuildContext contex, int index) {
                        return Button(
                          buttonTapped: () {
                            if (buttons[index] == 'C') {
                              clearScreenOp();
                              clearScreenResult();
                            } else if (buttons[index] == 'DEL') {
                              removeLastChar();
                            } else if (buttons[index] == '=') {
                              equalPressed();
                            } else if (isOperator(anterior) &&
                                isOperator(buttons[index])) {
                              return;
                            } else {
                              setState(() {
                                screenOperation += buttons[index];
                                anterior = buttons[index];
                              });
                            }
                          },
                          buttonText: buttons[index],
                          color: isOperator(buttons[index])
                              ? highlightColor
                              : bgSecundaryColor,
                          textColor: Colors.white,
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '+' || x == '-' || x == '*' || x == '%' || x == '=' || x == '/') {
      return true;
    }
    return false;
  }

  void clearScreenOp() {
    setState(() {
      screenOperation = '';
      anterior = '';
    });
  }

  void clearScreenResult() {
    setState(() {
      screenResult = '';
      anterior = '';
    });
  }

  void removeLastChar() {
    setState(() {
      screenOperation =
          screenOperation.substring(0, screenOperation.length - 1);
    });
  }

  void equalPressed() {
    String a = screenOperation;
    Parser p = Parser();
    Expression exp = p.parse(a);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    setState(() {
      screenResult = eval.toString();
      clearScreenOp();
    });
  }
}
