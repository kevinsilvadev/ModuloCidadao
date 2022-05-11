import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';



Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final  Future<FirebaseApp> _fbapp = Firebase.initializeApp();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  FutureBuilder(
        future: _fbapp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
          print('You have an error! ${snapshot.error.toString()}');
          return Text('Something went wrong');
        } else if (snapshot.hasData){
          return MyHomePage(title: 'My Amazing Counter App');
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        } },
      ),
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
          onPressed: () async {
            final  functions = FirebaseFunctions.instanceFor(region: "southamerica-east1");
            final result =  await functions.httpsCallable('funcaoTeste').call();
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
