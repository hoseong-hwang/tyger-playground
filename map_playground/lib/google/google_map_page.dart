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
  // GoogleMapController? _controller;
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
    });
  }

  Future<void> _loadCarIcon() async {}

  Future<void> _loadBikeIcon() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onTap: (LatLng position) {
              GoogleMapHelper.fetchGoogleGeocode(position);
              GoogleMapHelper.fetchGoogleReverseGeocode('동탄지성로 394');
            },
            // onMapCreated: (GoogleMapController controller) =>
            //     _controller = controller,
            initialCameraPosition: const CameraPosition(
              zoom: 6,
              // tilt: 90,
              target: LatLng(37.5642135, 127.0016985),
              // target: LatLng(40.7128, -74.0060),
            ),
            mapType: MapType.normal,
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
            zoomControlsEnabled: false,
            // markers: {
            //   Marker(
            //       markerId: const MarkerId("1"),
            //       position: const LatLng(40.7128, -74.0059),
            //       // position: const LatLng(37.5642135, 127.0016985),
            //       // icon: _widgetIcon ?? BitmapDescriptor.defaultMarker,
            //       infoWindow: InfoWindow(
            //         title: "NYC",
            //         snippet: "New York City",
            //         anchor: const Offset(0.5, 0),
            //         onTap: () {},
            //       )),
            // },
            // polygons: {
            //   Polygon(
            //     polygonId: PolygonId("test_1"),
            //     points: [
            //       LatLng(40.70639804724095, -74.00949496775866),
            //       LatLng(40.70958234085036, -74.00639735162258),
            //       LatLng(40.71028759719235, -74.00773610919714),
            //       LatLng(40.70955692606797, -74.00840699672699),
            //       LatLng(40.71035621632957, -74.00958213955163),
            //     ],
            //     strokeColor: Colors.blue,
            //     fillColor: Colors.blue.withOpacity(0.3),
            //   ),
            //   Polygon(
            //     polygonId: PolygonId("test_2"),
            //     points: [
            //       LatLng(40.763656989883, -73.97346150130033),
            //       LatLng(40.79661394757571, -73.94944768399),
            //       LatLng(40.7970611686575, -73.9496525377035),
            //       LatLng(40.800489848124705, -73.95783293992281),
            //       LatLng(40.800370307982824, -73.95835261791945),
            //       LatLng(40.78203192558047, -73.97175762802361),
            //       LatLng(40.783246687496835, -73.97454041987658),
            //       LatLng(40.780674209271794, -73.97640958428383),
            //       LatLng(40.77948555003366, -73.97362645715475),
            //       LatLng(40.768390286792375, -73.98158188909292),
            //       LatLng(40.76786187052331, -73.98138809949161),
            //       LatLng(40.76459732779249, -73.97364757955076),
            //       LatLng(40.763927182856236, -73.97412937134504),
            //     ],
            //     fillColor: Colors.pink.withOpacity(0.3),
            //     strokeColor: Colors.pink.withOpacity(0.7),
            //     strokeWidth: 8,
            //     zIndex: 1,
            //   ),
            //   Polygon(
            //     polygonId: PolygonId("test_5"),
            //     points: [
            //       LatLng(40.8156831446194, -73.95840022712946),
            //       LatLng(40.760845546506154, -73.99844259023666),
            //       LatLng(40.74985562624836, -73.9722340553999),
            //       LatLng(40.79690913413287, -73.93806170672178),
            //     ],
            //     strokeWidth: 4,
            //     strokeColor: Colors.black.withOpacity(0.8),
            //     fillColor: Colors.black.withOpacity(0.4),
            //   ),
            //   Polygon(
            //     polygonId: PolygonId("test_3"),
            //     points: [
            //       LatLng(48.993711379602374, -104.02240332216023),
            //       LatLng(44.9907856020146, -104.12180129438639),
            //       LatLng(44.996258409431746, -111.0470487177372),
            //       LatLng(40.93891896702388, -110.9781638905406),
            //       LatLng(40.97445818820962, -109.07169464975595),
            //       LatLng(31.308992764885996, -109.05496068298817),
            //       LatLng(31.3173336002484, -108.20814806967974),
            //       LatLng(31.75464681459062, -108.2014259907006),
            //       LatLng(31.78217058060004, -106.52161628007889),
            //       LatLng(32.004079962112385, -106.6039939597249),
            //       LatLng(32.01029067031866, -103.06022118777037),
            //       LatLng(36.99803605626975, -102.99957677721977),
            //       LatLng(36.97365701600549, -94.59392096847296),
            //       LatLng(39.1141887022131, -94.53938327729702),
            //       LatLng(42.63081864598465, -96.57022353261709),
            //       LatLng(45.87747178026601, -96.5333629399538),
            //       LatLng(48.96858167471485, -97.17508882284164),
            //     ],
            //     fillColor: Colors.blue.withOpacity(0.3),
            //     strokeColor: Colors.blue.withOpacity(0.7),
            //     strokeWidth: 4,
            //   ),
            //   Polygon(
            //     polygonId: PolygonId("test_6"),
            //     points: [
            //       LatLng(40.9560669492847, -102.0919229462743),
            //       LatLng(36.96498601814849, -102.06585623323917),
            //       LatLng(36.96270332155588, -114.04731407761574),
            //       LatLng(41.97910510741956, -114.14143614470959),
            //       LatLng(41.98700778454318, -111.07469424605371),
            //       LatLng(40.95640269785168, -110.9533876553178),
            //     ],
            //     fillColor: Colors.green.withOpacity(0.3),
            //     strokeColor: Colors.green.withOpacity(0.7),
            //     strokeWidth: 2,
            //     zIndex: 3,
            //   ),
            //   Polygon(
            //       polygonId: PolygonId("test_7"),
            //       points: [
            //         LatLng(48.93888843856517, -116.96160625666381),
            //         LatLng(42.006941927699735, -117.06943240016699),
            //         LatLng(41.97891269344983, -111.11476711928844),
            //         LatLng(44.943723086009285, -111.0501516982913),
            //         LatLng(44.96870175395189, -104.23074960708618),
            //         LatLng(45.97422419642762, -104.06555235385895),
            //         LatLng(45.91686290059706, -96.49467140436172),
            //         LatLng(43.59119668245341, -96.44726034253836),
            //         LatLng(43.502682908000736, -91.15715626627208),
            //         LatLng(44.9453089986043, -93.0849366635084),
            //         LatLng(47.874127089959885, -89.95334431529045),
            //         LatLng(49.355863179619604, -95.05891140550375),
            //         LatLng(48.99754145564026, -95.19912254065277),
            //       ],
            //       fillColor: Colors.orange.withOpacity(0.3),
            //       strokeColor: Colors.orange.withOpacity(0.7),
            //       strokeWidth: 2),
            // },
            // polylines: {
            //   Polyline(
            //     polylineId: PolylineId("test_2"),
            //     points: [
            //       LatLng(40.70639804724095, -74.00949496775866),
            //       LatLng(40.70958234085036, -74.00639735162258),
            //       LatLng(40.71028759719235, -74.00773610919714),
            //       LatLng(40.70955692606797, -74.00840699672699),
            //       LatLng(40.71035621632957, -74.00958213955163),
            //     ],
            //     width: 8,
            //     startCap: Cap.roundCap,
            //     endCap: Cap.roundCap,
            //     color: Colors.orange,
            //     jointType: JointType.round,
            //     patterns: [
            //       PatternItem.dash(10),
            //       PatternItem.gap(5),
            //     ],
            //   ),
            //   Polyline(
            //     polylineId: PolylineId("test_4"),
            //     points: [
            //       LatLng(40.70639804724095, -74.00949496775866),
            //       LatLng(40.70694728458094, -74.00900479406118),
            //       LatLng(40.708317689511354, -74.0112555027008),
            //       LatLng(40.71035621632957, -74.00958213955163),
            //     ],
            //     width: 8,
            //     color: Colors.deepOrange,
            //     geodesic: true,
            //   ),
            //   Polyline(
            //     polylineId: PolylineId("test_3"),
            //     points: [
            //       LatLng(37.00467004471232, 127.14675553143026),
            //       LatLng(28.433656088756575, 67.11662884801628),
            //       LatLng(15.65957041480982, 101.52853533625604),
            //       // LatLng(25.003057498254474, 121.53708469122648),
            //       // LatLng(47.20627646101921, 104.76671867072584)
            //     ],
            //     width: 8,
            //     color: Colors.pink,
            //     geodesic: false,
            //   ),
            //   Polyline(
            //     polylineId: PolylineId("test_1"),
            //     points: [
            //       LatLng(-33.85457426946806, 151.21616262942553),
            //       LatLng(-18.918012522136006, 47.52157688140869),
            //     ],
            //     width: 8,
            //     color: Colors.purpleAccent,
            //     geodesic: false,
            //   ),
            // },
            // circles: {
            //   Circle(
            //     circleId: const CircleId('circle_1'),
            //     center: const LatLng(37.5665, 126.9780),
            //     radius: 1000000,
            //     fillColor: Colors.blue.withOpacity(0.4),
            //     strokeColor: Colors.blue.withOpacity(0.5),
            //     strokeWidth: 2,
            //   ),
            //   Circle(
            //     circleId: const CircleId('circle_2'),
            //     center: const LatLng(33.4996, 126.5312),
            //     radius: 600000,
            //     fillColor: Colors.red.withOpacity(0.3),
            //     strokeColor: Colors.red.withOpacity(0.4),
            //     strokeWidth: 2,
            //     zIndex: 1,
            //   ),
            //   Circle(
            //     circleId: const CircleId('circle_3'),
            //     center: const LatLng(35.1796, 129.0756),
            //     radius: 400000,
            //     fillColor: Colors.black.withOpacity(0.3),
            //     strokeColor: Colors.black.withOpacity(0.4),
            //     strokeWidth: 2,
            //     zIndex: 1,
            //   ),
            // },
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
