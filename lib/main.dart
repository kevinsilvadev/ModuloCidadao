import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//void main() {
//  runApp(const MyApp());
//}


Future<void> main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  String placa = '';
  String CPF = '';


  Widget _body(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          child: Column(
            children: [
              TextField(
                onChanged: (text){
                  placa = text;
                },
                decoration: InputDecoration(
                  labelText: 'Placa do Veículo',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                onChanged: (text){
                  CPF = text;
                },
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  labelText: 'CPF',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor : MaterialStateProperty.all<Color>(Colors.blueAccent),
          ),
          onPressed: () {
            print("Você enviou os dados");
          },
          child: const Text("Prosseguir")
          ,)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
        padding: const EdgeInsets.all(8.0),
    child: Stack(
      children: [
        Container(color: Colors.blueGrey),
        _body(),

      ],
    )

    ),
        ),
    );
  }
}
