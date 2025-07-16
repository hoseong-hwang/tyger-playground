import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          myLocationEnabled: true,

          initialCameraPosition: CameraPosition(
            zoom: 20,
            target: LatLng(37.5642135, 127.0016985),
          ),
          // markers: {
          //   Marker(
          //     markerId: MarkerId("test"),
          //     position: LatLng(37.5665, 126.9780),
          //   )
          // },
          // minMaxZoomPreference: MinMaxZoomPreference(1, 4),
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
