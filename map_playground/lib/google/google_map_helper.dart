import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class GoogleMapHelper {
  static Future<void> fetchGoogleReverseGeocode(String address) async {
    const String key = 'AIzaSyDHbQ19UMybWjUZuCkjUbi0Ubdsh3-VwaE';
    final String url = ''
        'https://maps.googleapis.com/maps/api/geocode/json?address=$address&language=ko&key=$key';
    final http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('HTTP ${response.statusCode}');
    }

    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String status = data['status'] as String? ?? 'UNKNOWN_ERROR';

    if (status != 'OK') {
      final msg = data['error_message'] ?? status;
      throw Exception('Geocoding failed: $msg');
    }

    final List<dynamic> results = data['results'];
    for (int i = 0; i < results.length; i++) {
      print('$i: ${results[i]['geometry']['location']}');
    }
  }

  static Future<void> fetchGoogleGeocode(LatLng position) async {
    const String key = 'AIzaSyDHbQ19UMybWjUZuCkjUbi0Ubdsh3-VwaE';
    final String url = ''
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&language=ko&key=$key';
    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception('HTTP ${response.statusCode}');
    }

    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String status = data['status'] as String? ?? 'UNKNOWN_ERROR';

    if (status != 'OK') {
      final msg = data['error_message'] ?? status;
      throw Exception('Geocoding failed: $msg');
    }

    final List<dynamic> results = data['results'];
    for (int i = 0; i < results.length; i++) {
      print('$i: ${results[i]['geometry']['location']}');
    }
  }

  static Future<BitmapDescriptor> getNetworkMarkerIcon(String imageUrl) async {
    final http.Response response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode != 200) {
      throw Exception("Failed to load image.");
    }

    final Uint8List imageBytes = response.bodyBytes;

    final ui.Codec codec = await ui.instantiateImageCodec(
      imageBytes,
      targetWidth: 100,
      targetHeight: 100,
    );
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ByteData? byteData =
        await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) return BitmapDescriptor.defaultMarker;

    return BitmapDescriptor.bytes(byteData.buffer.asUint8List());
  }

  static Future<BitmapDescriptor> getMarkerWidgetIcon(GlobalKey key) async {
    final RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;

    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) return BitmapDescriptor.defaultMarker;
    final Uint8List markerIcon = byteData.buffer.asUint8List();
    return BitmapDescriptor.bytes(markerIcon);
  }
}
