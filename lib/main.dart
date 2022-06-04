import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

List<LatLng> polylineList = [];
Future<void> getZoneCoords() async {
  final result =
  await FirebaseFunctions.instanceFor(region: "southamerica-east1")
      .httpsCallable('getZonaAzulCidadao')
      .call();
  for(var item in result.data[0]["pontos"]) {
    polylineList.add(LatLng(item["_latitude"], item["_longitude"]));
  }
}

List <LatLng> polylineList2 = [];
Future<void> getZoneCoords2() async {
  final result =
  await FirebaseFunctions.instanceFor(region: "southamerica-east1")
      .httpsCallable('getZonaAzulCidadao')
      .call();
  for(var item in result.data[1]["pontos"]) {
    polylineList2.add(LatLng(item["_latitude"], item["_longitude"]));
    print(polylineList2);
  }
}

List <LatLng> zonaAzulComercios = [];
List <LatLng> zonaAzulComercios2 = [];
Future<void> getZonaAzulComercios() async {
  final result =
  await FirebaseFunctions.instanceFor(region: "southamerica-east1")
      .httpsCallable('getComercios')
      .call();
  for(var item in result.data[0]["coordenadasAreaAzul"]) {
    zonaAzulComercios.add(LatLng(item["_latitude"], item["_longitude"]));
  }
  for(var item in result.data[0]["coordenadasAreaRoxa"]) {
    zonaAzulComercios2.add(LatLng(item["_latitude"], item["_longitude"]));
  }
}

Future initialization(BuildContext? context) async{
  getZoneCoords();
  getZoneCoords2();
  getZonaAzulComercios();
  await Future.delayed(const Duration(seconds: 5));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp (
    home: maps(polylineList, polylineList2, zonaAzulComercios, zonaAzulComercios2),
  );
}

