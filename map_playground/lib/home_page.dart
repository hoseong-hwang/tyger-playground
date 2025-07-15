import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _mapStyle = '''
  [
    {
      "featureType": "poi",
      "elementType": "labels",
      "stylers": [
        { "visibility": "off" }
      ]
    },
    {
      "featureType": "road",
      "elementType": "geometry",
      "stylers": [
        { "color": "#cccccc" }
      ]
    }
  ]
  ''';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          zoom: 20,
          target: LatLng(37.5642135, 127.0016985),
        ),
        style: '''
  [
    {
      "featureType": "poi",
      "elementType": "labels",
      "stylers": [
        { "visibility": "off" }
      ]
    }
  ]
  ''',
      ),
    );
  }
}
