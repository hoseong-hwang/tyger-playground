import 'package:flutter/material.dart';
import 'package:map_playground/google/google_map_page.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isGranted = false;
  @override
  void initState() {
    super.initState();
    _permissionCheck();
  }

  Future<void> _permissionCheck() async {
    PermissionStatus status = await Permission.locationWhenInUse.request();
    setState(() => _isGranted = status.isGranted);
  }

  @override
  Widget build(BuildContext context) {
    if (_isGranted) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Maps",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _button(
                context,
                title: "Go to Google Map",
                page: const GoogleMapPage(),
              ),
            ],
          ),
        ),
      );
    }
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  GestureDetector _button(
    BuildContext context, {
    required String title,
    required Widget page,
  }) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => page)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width - 40,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
