import 'package:flutter/material.dart';
import 'package:modulo_cidadao/screens/firebase_options.dart';
import 'package:modulo_cidadao/screens/maps.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initialization(null);

  runApp(MyApp());
}


Future initialization(BuildContext? context) async{
  await Future.delayed(Duration(seconds: 5));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp (
    home: maps(),
  );



}

