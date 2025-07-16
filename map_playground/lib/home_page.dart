import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            zoom: 20,
            // target: LatLng(37.5642135, 127.0016985),
            target: LatLng(40.750298, -73.993324),
          ),

          trafficEnabled: false,
          // markers: {
          //   Marker(
          //     markerId: MarkerId("test"),
          //     position: LatLng(37.5665, 126.9780),
          //   )
          // },
          // cameraTargetBounds: CameraTargetBounds(
          //   LatLngBounds(
          //     southwest: LatLng(33.0, 124.0),
          //     northeast: LatLng(39.5, 131.0),
          //   ),
          // ),
        ),
      ),
    );
  }
}
