import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modulo_cidadao/screens/seleciona_ticket.dart';
import 'package:cloud_functions/cloud_functions.dart';



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

  Future<List> getFruit() async {
    HttpsCallable callable = FirebaseFunctions.instanceFor(region: "southamerica-east1").httpsCallable('getZonaAzul');
    final results = await callable();
    List fruit = results.data;
    return fruit;
  }



  static const vetorDeCordenadas = [LatLng(-22.85660325609261, -47.21124992946328), // R. João Ribeiro Evangelista
    LatLng(-22.856613845955977, -47.21198636919401), // R. Ana Profetisma da Silva
    LatLng(-22.852539156140377, -47.21209803336096), // R. João Barreto da Silva 2
    LatLng(-22.852520046097645, -47.211339634169306), // R. João Barreto da Silva 3
    LatLng(-22.85250050972797, -47.21071312998611), // R. João Barreto da Silva 1
    LatLng(-22.85245688418955, -47.21002234349986), // Vila Real Santista
    LatLng(-22.85648981655519, -47.21000478754708),  // R. Waldemar Simões
    LatLng(-22.85657000230939, -47.210622911608226)]; // R. José Martin dos Anjos






  static final Marker _place1 = Marker(
    markerId: MarkerId('_place'),
    infoWindow: InfoWindow(title: 'R. João Ribeiro Evangelista'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(-22.85660325609261, -47.21124992946328),
  );
  static final Marker _place2 = Marker(
    markerId: MarkerId('_place'),
    infoWindow: InfoWindow(title: 'R. Ana Profetisma da Silva'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(-22.856613845955977, -47.21198636919401),
  );
  static final Marker _place3 = Marker(
    markerId: MarkerId('_place'),
    infoWindow: InfoWindow(title: 'Vila Real Santista'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(-22.85245688418955, -47.21002234349986),
  );
  static final Marker _place4 = Marker(
    markerId: MarkerId('_place'),
    infoWindow: InfoWindow(title: 'R. João Barreto da Silva 1'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(-22.85250050972797, -47.21071312998611),
  );
  static final Marker _place5 = Marker(
    markerId: MarkerId('_place'),
    infoWindow: InfoWindow(title: 'R. João Barreto da Silva 2'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(-22.852539156140377, -47.21209803336096),
  );
  static final Marker _place6 = Marker(
    markerId: MarkerId('_place'),
    infoWindow: InfoWindow(title: 'R. José Martin dos Anjos'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(-22.85657000230939, -47.210622911608226),
  );
  static final Marker _place7 = Marker(
    markerId: MarkerId('_place'),
    infoWindow: InfoWindow(title: 'R. Waldemar Simões'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(-22.85648981655519, -47.21000478754708),
  );
  static final Marker _place8 = Marker(
    markerId: MarkerId('_place'),
    infoWindow: InfoWindow(title: 'R. João Barreto da Silva 3'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(-22.852520046097645, -47.211339634169306),
  );



  static final CameraPosition _hortolandia = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-22.85250050972797, -47.21071312998611),
      tilt: 59.440717697143555,
      zoom: 18.151926040649414);



  static final Polyline _Polyline = Polyline(
      polylineId: PolylineId('_Polyline'),
      points: vetorDeCordenadas,
    width: 1
  );


  static final Polygon _Polygon = Polygon(
      polygonId: PolygonId('_Polygon'),
      points: vetorDeCordenadas,
    strokeWidth: 5,
    fillColor: Colors.lightBlueAccent.withOpacity(0.3)
    
  );

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.lightBlueAccent[700],
        ),
        body: Stack(
            children:[
              GoogleMap(
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                markers: {
                  _place1,
                  _place2,
                  _place3,
                  _place4,
                  _place5,
                  _place6,
                  _place7,
                  _place8,
                },
                  polylines: {
                  _Polyline
                  },
                  polygons: {
                    _Polygon
                  },
                initialCameraPosition: _hortolandia
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  primary: Colors.white,
                ),
                onPressed: () {
                  getFruit();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => seleciona_ticket()),
                  );
                },
                child: Text('Comprar Ticket'),
              )
            ]
        ),
      ),
    );
  }
}
