import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modulo_cidadao/screens/seleciona_ticket.dart';



class maps extends StatefulWidget {
  const maps({Key? key}) : super(key: key);

  @override
  _mapsState createState() => _mapsState();
}

class _mapsState extends State<maps> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<List> getCoordenadas() async {
    HttpsCallable callable = FirebaseFunctions
        .instanceFor(region: "southamerica-east1")
        .httpsCallable('getZonaAzul');
        final results = await callable();
        List coordenada = results.data;
        return coordenada;
  }

  static final CameraPosition _hortolandia = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-22.85250050972797, -47.21071312998611),
      tilt: 59.440717697143555,
      zoom: 18.151926040649414);

  @override
  void initState() {
    super.initState();
    getCoordenadas();
  }

  @override
  Widget build(BuildContext context) {

    final Polygon _Polygon = Polygon(
        consumeTapEvents: true,
        polygonId: PolygonId('_Polygon'),
        strokeWidth: 5,
        fillColor: Colors.lightBlueAccent.withOpacity(0.3),
        onTap: () {
          final AlertDialog infoArea = AlertDialog(
            title: Text('Area Azul do Mapa'),
            //chamar infos do banco da área aqui
            content: Text('Informações da região'),
            actions: [
              FlatButton(
                textColor: Color(0xFF6200EE),
                onPressed: () {
                  Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => seleciona_ticket()),
                  );
                },
                child: Text('Comprar'),
              ),
            ],
          );
          showDialog(context: context, builder: (context) => infoArea);
        }
    );

     final Polyline _Polyline = Polyline(
        polylineId: PolylineId('_Polyline'),
       // points: vetorDeCoordenadas,
        width: 1
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Areas de Zona Azul'),
          backgroundColor: Colors.lightBlueAccent[700],
        ),
        body: Stack(
            children:[
              GoogleMap(
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  polylines: {
                    _Polyline
                  },
                  polygons: {
                    _Polygon
                  },
                  initialCameraPosition: _hortolandia
              ),
            ]
        ),
      ),
    );
  }
}