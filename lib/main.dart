import 'package:flutter/material.dart';
import 'package:modulo_cidadao/screens/maps.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp (
    home: maps(),
  );
}
