import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  GoogleMapController? _controller;

  Future<void> _moveCurrentLocation() async {
    final Position position = await Geolocator.getCurrentPosition();

    _controller?.animateCamera(
      CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) =>
                _controller = controller,
            initialCameraPosition: const CameraPosition(
              zoom: 20,
              target: LatLng(37.5642135, 127.0016985),
            ),
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
            zoomControlsEnabled: false,
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: SafeArea(
              child: GestureDetector(
                onTap: () => _moveCurrentLocation(),
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(72),
                    color: Colors.black.withOpacity(0.7),
                  ),
                  child: Icon(
                    Icons.my_location_rounded,
                    size: 36,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
