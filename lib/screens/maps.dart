import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modulo_cidadao/main.dart';
import 'package:modulo_cidadao/screens/seleciona_ticket.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:modulo_cidadao/Model/notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class maps extends StatefulWidget {

  List polylineList;
  List zonaAzulComercios;
  List polylineList2;
  List zonaAzulComercios2;
  List zonaAzulComerciosNomes;
  List  zonaAzulComerciosNomes2;

  maps(this.polylineList, this.polylineList2, this.zonaAzulComercios, this.zonaAzulComercios2, this.zonaAzulComerciosNomes, this.zonaAzulComerciosNomes2);


  @override
  _mapsState createState() => _mapsState();
}

class _mapsState extends State<maps> {
  late GoogleMapController mapController;


  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  static const  vetorDeLojas = [LatLng(-22.85664450504122, -47.21118569636944),
    LatLng(-22.856633991780658, -47.212044188759094)];


      static final CameraPosition _hortolandia = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-22.85250050972797, -47.21071312998611),
      tilt: 59.440717697143555,
      zoom: 18.151926040649414);


  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;

      if(notification!=null&&androidNotification!=null){
        flutterLocalNotificationsPlugin.show(
            notification.hashCode.toInt(),
            notification.title.toString(),
            notification.body.toString(),
            NotificationDetails(
                android:AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                    channelDescription: channel.description,
                    color: Colors.blue,
                    playSound: true,
                    icon: '@mipmap/ic_launcher'
                )
            )
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print(polylineList2);

    final Polygon _Polygon = Polygon(
        consumeTapEvents: true,
        polygonId: PolygonId('_Polygon'),
        points: polylineList2,
        strokeWidth: 5,
        fillColor: Colors.lightBlueAccent.withOpacity(0.3),
        onTap: () {
          final AlertDialog infoArea1 = AlertDialog(
                       //Puxa a área do banco
            title: Text('Area Azul do Mapa'),
                 //chamar infos do banco da área aqui
            content: Text('RS 02:00 por hora.\n${zonaAzulComerciosNomes[0]}\n${zonaAzulComerciosNomes[1]}\n${zonaAzulComerciosNomes[2]}'),
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
          showDialog(context: context, builder: (context) => infoArea1);
        }
    );


    final Polygon _Polygon2 = Polygon(
        consumeTapEvents: true,
        polygonId: PolygonId('_Polygon2'),
        points: polylineList,
        strokeWidth: 5,
        fillColor: Colors.deepPurpleAccent.withOpacity(0.3),
        onTap: () {
          final AlertDialog infoArea2 = AlertDialog(
                        //Puxa a área do banco
            title: Text('Area Roxa do Mapa'),
                    //chamar infos do banco da área aqui
            content: Text('RS 02:00 por hora. \n${zonaAzulComerciosNomes2[0]}\n${zonaAzulComerciosNomes2[1]}\n${zonaAzulComerciosNomes2[2]}'),
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
          showDialog(context: context, builder: (context) => infoArea2);
        }
    );


     final Polyline _Polyline = Polyline(
        polylineId: PolylineId('_Polyline'),
        points: vetorDeLojas,
        width: 0
    );

       final Marker _Marker0 = Marker(
         markerId: MarkerId('_Marker0'),
         position: zonaAzulComercios[0],
       );
      final Marker _Marker1 = Marker(
        markerId: MarkerId('_Marker1'),
        position: zonaAzulComercios[1],
      );
      final Marker _Marker2 = Marker(
        markerId: MarkerId('_Marker2'),
        position: zonaAzulComercios[2],
      );
      final Marker _Marker3 = Marker(
        markerId: MarkerId('_Marker3'),
        position: zonaAzulComercios2[0],
      );
      final Marker _Marker4 = Marker(
        markerId: MarkerId('_Marker4'),
        position: zonaAzulComercios2[1],
      );
      final Marker _Marker5 = Marker(
        markerId: MarkerId('_Marker5'),
        position: zonaAzulComercios2[2],
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
                    _Polygon,
                    _Polygon2
                  },
                  markers: {
                    _Marker0,
                    _Marker1,
                    _Marker2,
                    _Marker3,
                    _Marker4,
                    _Marker5,
                  },
                  initialCameraPosition: _hortolandia
              ),
            ]
        ),
      ),
    );
  }
}