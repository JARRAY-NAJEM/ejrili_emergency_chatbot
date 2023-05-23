import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kPristinaSchoolOfAI = CameraPosition(
    target: LatLng(35.8137892, 10.5977588),
    // Pristini School of AI coordinates
    bearing: 192.8334901395799,
    zoom: 17,
  );

  static const CameraPosition _kKalaaSeghira = CameraPosition(
    target: LatLng(35.8137892, 10.5977588),
    zoom: 17,
    bearing: 192.8334901395799,
    // tilt: 59.440717697143555,
  );

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kKalaaSeghira));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPS'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GoogleMap(
          mapType: MapType.hybrid,
          myLocationEnabled: true,
          initialCameraPosition: _kPristinaSchoolOfAI,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To !'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }
}
