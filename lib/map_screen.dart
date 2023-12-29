import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final Location _location = Location();
  final Set<Marker> _markers = {};
  final List<LatLng> _polylineCoordinates = [];

  @override
  void initState() {
    super.initState();
    _location.onLocationChanged.listen((LocationData currentLocation) {
      _updateMarker(currentLocation);
      _updatePolyline(currentLocation);
    });
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      LocationData currentLocation = await _location.getLocation();
      _updateMarker(currentLocation);
      _updatePolyline(currentLocation);
      _animateToUser(currentLocation);
    } catch (e) {
      Text("Error: $e");
    }
  }

  void _updateMarker(LocationData locationData) {
    setState(() {
      _markers.add(Marker(
        markerId: const MarkerId('user_location'),
        position: LatLng(locationData.latitude!, locationData.longitude!),
        onTap: () {
          _showInfoWindow(locationData);
        },
      ));
    });
  }

  void _updatePolyline(LocationData locationData) {
    setState(() {
      _polylineCoordinates.add(LatLng(
        locationData.latitude!,
        locationData.longitude!,
      ));
    });
  }

  void _animateToUser(LocationData locationData) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(locationData.latitude!, locationData.longitude!),
          zoom: 15.0,
        ),
      ),
    );
  }

  void _showInfoWindow(LocationData locationData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('My current location'),
          content: Text(
            'Latitude: ${locationData.latitude}\nLongitude: ${locationData.longitude}',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Tracker'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: LatLng(24.954330800240278, 89.87291743714356),
          zoom: 14,
        ),
        markers: _markers,
        polylines: {
          Polyline(
            polylineId: const PolylineId('user_route'),
            color: Colors.blue,
            points: _polylineCoordinates,
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}