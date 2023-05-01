import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();

  final List<Marker> _marker = [];
  // List<Marker> _markers = [];
  final List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(18.646246429682737, 73.75922403957193),
      infoWindow: InfoWindow(title: "Current Location"),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(18.637628257949874, 73.76525185767176),
      infoWindow: InfoWindow(title: "Saahas For Animals"),
    ),
    Marker(
      markerId: MarkerId('3'),
      position: LatLng(18.635178723575876, 73.75847446024937),
      infoWindow: InfoWindow(title: "Paws Foundation"),
    ),
    Marker(
      markerId: MarkerId('4'),
      position: LatLng(18.634636938385736, 73.67357819887516),
      infoWindow: InfoWindow(title: "Make New Life"),
    ),
    Marker(
      markerId: MarkerId('5'),
      position: LatLng(18.593268642772745, 73.8190945466951),
      infoWindow: InfoWindow(title: "Pranimal Foundation"),
    ),
    Marker(
      markerId: MarkerId('6'),
      position: LatLng(18.610323504400572, 73.68864730574613),
      infoWindow: InfoWindow(title: "Casa_di_pelliccia"),
    ),
    Marker(
      markerId: MarkerId('7'),
      position: LatLng(18.6082502779315, 73.91018839887516),
      infoWindow: InfoWindow(title: "Paws Care"),
    ),Marker(
      markerId: MarkerId('7'),
      position: LatLng(18.50680981228602, 73.87359916024936),
      infoWindow: InfoWindow(title: "Mission Possible Pet House"),
    ),
  ];

  static const CameraPosition _CamPosition = CameraPosition(
    target: LatLng(18.646246429682737, 73.75922403957193),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
    // loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5DC),
        body: GoogleMap(
          initialCameraPosition: _CamPosition,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        )
        );
  }
}
