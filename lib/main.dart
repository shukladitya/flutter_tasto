import 'package:flutter/material.dart';
import 'package:tasto/screens/details.dart';
import 'package:tasto/screens/home.dart';
import 'package:tasto/screens/result.dart';
import 'package:tasto/screens/search.dart';
import 'package:asuka/asuka.dart' as asuka;

void main() {
  runApp(Tasto());
}

class Tasto extends StatefulWidget {
  @override
  _TastoState createState() => _TastoState();
}

class _TastoState extends State<Tasto> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home(), builder: asuka.builder, routes: {
      'search': (context) => Search(),
      'result': (context) => Result(),
      'details': (context) => Details(),
    });
  }
}
