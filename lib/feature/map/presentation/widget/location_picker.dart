import 'package:evently/core/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({super.key});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  LatLng? selectedLocation;

  void ontap(LatLng latLang) {
    setState(() {
      selectedLocation = latLang;
    });
  }

  @override
  Widget build(BuildContext context) {
    var locationProvider = Provider.of<LocationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pick a Location",
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context, selectedLocation);
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: GoogleMap(
        onTap: ontap,
        markers: selectedLocation != null
            ? {
                Marker(
                  markerId: MarkerId("Selected Location"),
                  position: selectedLocation!,
                ),
              }
            : {
//LatLng(31.0818406, 29.8935053),
              },
        initialCameraPosition: CameraPosition(
          target:
              locationProvider.userLocation ?? LatLng(31.0818406, 29.8935053),
          zoom: 15,
        ),
      ),
    );
  }
}
