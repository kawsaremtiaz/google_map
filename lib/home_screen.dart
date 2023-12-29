import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps"),
        centerTitle: false,
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
            target: LatLng(23.792265, 90.4056177),
            zoom: 14,
            bearing: 0,
            tilt: 5),
        onTap: (LatLng position) {
          print(position);
        },
        onLongPress: (LatLng latLng) {
          print("on long press at $latLng");
        },
        onCameraMove: (cameraPosition) {
          print(cameraPosition);
        },
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        compassEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: {
          Marker(
              markerId: const MarkerId("initialPosition"),
              position: const LatLng(23.792265, 90.4056177),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
              infoWindow: const InfoWindow(
                  title: "LatLng(23.792265, 90.4056177)",
                  snippet: "This is snippet"),
              draggable: true,
              onDrag: (LatLng position) {
                print(position);
              },
              onDragStart: (LatLng position) {
                print(position);
              },
              onDragEnd: (LatLng position) {
                print(position);
              },
              onTap: () {
                print("on tapped in map");
              }),
          Marker(
              markerId: const MarkerId("initialPosition"),
              position: const LatLng(23.792265, 90.40785177),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueOrange),
              infoWindow: const InfoWindow(
                  title: "LatLng(23.792265, 90.4056177)",
                  snippet: "This is snippet"),
              draggable: true,
              onDrag: (LatLng position) {
                print(position);
              },
              onDragStart: (LatLng position) {
                print(position);
              },
              onDragEnd: (LatLng position) {
                print(position);
              },

              ),
        },
      ),
    );
  }
}
