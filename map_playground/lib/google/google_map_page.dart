import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:map_playground/google/custom_marker_widget.dart';
import 'package:map_playground/google/google_map_helper.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  final Location location = Location();
  GoogleMapController? _controller;
  final GlobalKey _markerKey = GlobalKey();

  // Future<void> _moveCurrentLocation() async {
  //   final LocationData data = await location.getLocation();
  //   if (data.longitude != null && data.latitude != null) {
  //     _controller?.animateCamera(
  //       CameraUpdate.newLatLng(LatLng(data.latitude!, data.longitude!)),
  //     );
  //   }
  // }

  // void _moveZoom(CameraUpdate update, bool isJumpTo) {
  //   if (isJumpTo) {
  //     _controller?.moveCamera(update);
  //   } else {
  //     _controller?.animateCamera(update);
  //   }
  // }

  // void _zoomInAndOut(bool isZoomIn, bool isJumpTo) {
  //   if (isZoomIn) {
  //     _moveZoom(CameraUpdate.zoomIn(), isJumpTo);
  //   } else {
  //     _moveZoom(CameraUpdate.zoomOut(), isJumpTo);
  //   }
  // }

  // void _zoomBy(bool isZoomIn, bool isJumpTo) {
  //   if (isZoomIn) {
  //     _moveZoom(CameraUpdate.zoomBy(2), isJumpTo);
  //   } else {
  //     _moveZoom(CameraUpdate.zoomBy(-4), isJumpTo);
  //   }
  // }

  // void _zoomTo(bool isZoomIn, bool isJumpTo) {
  //   if (isZoomIn) {
  //     _moveZoom(CameraUpdate.zoomTo(20), isJumpTo);
  //   } else {
  //     _moveZoom(CameraUpdate.zoomTo(2), isJumpTo);
  //   }
  // }

  // Future<void> _goToNYC(bool isJumpTo) async {
  //   const LatLng postion = LatLng(40.7128, -74.0060);
  //   if (isJumpTo) {
  //     _controller?.moveCamera(CameraUpdate.newLatLng(postion));
  //   } else {
  //     _controller?.animateCamera(CameraUpdate.newLatLng(postion));
  //   }
  // }

  // Future<void> _resetCameraPostion(bool isJumpTo) async {
  //   const LatLng position = LatLng(37.5642135, 127.0016985);
  //   if (isJumpTo) {
  //     _controller?.moveCamera(CameraUpdate.newCameraPosition(
  //       const CameraPosition(target: position, zoom: 20, bearing: 90, tilt: 45),
  //     ));
  //   } else {
  //     _controller?.animateCamera(CameraUpdate.newCameraPosition(
  //       const CameraPosition(target: position, zoom: 20, bearing: 90, tilt: 45),
  //     ));
  //   }
  // }

  // Future<void> _goKoreaSection(bool isJumpTo) async {
  //   final LatLngBounds bounds = LatLngBounds(
  //     southwest: const LatLng(34.0, 126.0),
  //     northeast: const LatLng(38.0, 130.0),
  //   );
  //   if (isJumpTo) {
  //     _controller?.moveCamera(CameraUpdate.newLatLngBounds(bounds, 20));
  //   } else {
  //     _controller?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 20));
  //   }
  // }

  // Future<void> _scrollTo(
  //   bool isJumpTo, {
  //   double x = 0,
  //   double y = 0,
  // }) async {
  //   if (isJumpTo) {
  // _controller?.moveCamera(CameraUpdate.scrollBy(x, y));
  //   } else {
  //     _controller?.animateCamera(CameraUpdate.scrollBy(x, y));
  //   }
  // }

  BitmapDescriptor? _bikeIcon;
  BitmapDescriptor? _carIcon;
  BitmapDescriptor? _widgetIcon;

  @override
  void initState() {
    super.initState();
    _loadWidgetIcon();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadBikeIcon();
    _loadCarIcon();
    // _loadWidgetIcon();
  }

  Future<void> _loadWidgetIcon() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 50));
      _widgetIcon = await GoogleMapHelper.getMarkerWidgetIcon(_markerKey);
    });
  }

  Future<void> _loadCarIcon() async {
    _carIcon = await GoogleMapHelper.getNetworkMarkerIcon(
        'https://velog.velcdn.com/images/tygerhwang/post/425cec5b-d7a7-4c9a-9075-37e795ffc3c8/image.png');
  }

  Future<void> _loadBikeIcon() async {
    _bikeIcon = await BitmapDescriptor.asset(
      createLocalImageConfiguration(context),
      'assets/images/bike.png',
      width: 64,
      height: 64,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onTap: (LatLng position) {},
            onMapCreated: (GoogleMapController controller) =>
                _controller = controller,
            initialCameraPosition: const CameraPosition(
              zoom: 20,
              tilt: 90,
              target: LatLng(37.5642135, 127.0016985),
              // target: LatLng(40.7128, -74.0060),
            ),
            mapType: MapType.normal,
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
            zoomControlsEnabled: false,
            markers: {
              Marker(
                  markerId: const MarkerId("1"),
                  position: const LatLng(40.7128, -74.0059),
                  // position: const LatLng(37.5642135, 127.0016985),
                  icon: _widgetIcon ?? BitmapDescriptor.defaultMarker,
                  infoWindow: InfoWindow(
                    title: "NYC",
                    snippet: "New York City",
                    anchor: const Offset(0.5, 0),
                    onTap: () {},
                  )),
            },
          ),
          Positioned(
            top: -9999,
            left: -9999,
            child: RepaintBoundary(
              key: _markerKey,
              child: const CustomMarkerWidget(),
            ),
          ),
          // Align(
          //   alignment: Alignment.center,
          //   child: Container(
          //     width: 100,
          //     height: 100,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(20),
          //       color: Colors.black.withOpacity(0.4),
          //     ),
          //     child: Stack(
          //       children: [
          //         ...List.generate(
          //           4,
          //           (i) => Positioned(
          //             top: i == 0
          //                 ? 0
          //                 : i == 2
          //                     ? 60
          //                     : 30,
          //             left: i % 2 == 0
          //                 ? 30
          //                 : i == 1
          //                     ? 60
          //                     : 0,
          //             child: GestureDetector(
          //               onTap: () => _scrollTo(true,
          //                   x: i % 2 != 0 ? (i == 1 ? 300 : -300) : 0,
          //                   y: i % 2 == 0 ? (i == 0 ? -300 : 300) : 0),
          //               child: Container(
          //                 color: Colors.transparent,
          //                 width: 40,
          //                 height: 40,
          //                 child: Icon(
          //                   i == 0
          //                       ? Icons.arrow_upward_rounded
          //                       : i == 1
          //                           ? Icons.arrow_forward_rounded
          //                           : i == 2
          //                               ? Icons.arrow_downward_rounded
          //                               : Icons.arrow_back_rounded,
          //                   size: 24,
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // SafeArea(
          //   child: Align(
          //     alignment: Alignment.bottomCenter,
          //     child: GestureDetector(
          //       onTap: () => _resetCameraPostion(false),
          //       child: Container(
          //         margin: const EdgeInsets.only(bottom: 20),
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(8),
          //             color: Colors.green.withOpacity(0.8)),
          //         child: const Text(
          //           "Animate to Reset",
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 16,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // Align(
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(8),
          //       color: Colors.black.withOpacity(0.8),
          //     ),
          //     child: const Text(
          //       // "Zoom In/Out",
          //       // "Zoom By(+2/-4)",
          //       "Zoom To(+20/-2)",
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 20,
          //         color: Colors.green,
          //       ),
          //     ),
          //   ),
          // ),
          // Positioned(
          //   bottom: 92 + 12,
          //   right: 20,
          //   child: SafeArea(
          //     child: Column(
          //       children: [
          //         ...List.generate(
          //           2,
          //           (i) => GestureDetector(
          //             onTap: () => _zoomInAndOut(i == 0, false),
          //             child: Container(
          //               width: 40,
          //               height: 40,
          //               margin: EdgeInsets.only(bottom: i == 0 ? 8 : 0),
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(4),
          //                 color: Colors.black.withOpacity(0.6),
          //               ),
          //               child: Icon(
          //                 i == 0 ? Icons.add : Icons.remove,
          //                 size: 30,
          //                 color: Colors.white,
          //               ),
          //             ),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // Positioned(
          //   bottom: 20,
          //   right: 20,
          //   child: SafeArea(
          //     child: GestureDetector(
          //       onTap: () => _moveCurrentLocation(),
          //       child: Container(
          //         width: 72,
          //         height: 72,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(72),
          //           color: Colors.black.withOpacity(0.7),
          //         ),
          //         child: Icon(
          //           Icons.my_location_rounded,
          //           size: 36,
          //           color: Colors.white.withOpacity(0.8),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
