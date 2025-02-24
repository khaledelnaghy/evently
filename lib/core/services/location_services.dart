import 'package:evently/feature/map/presentation/widget/location_picker.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationServices {
// return pickLocation  => اللي انا اخترتة من علي الماب
  static Future<LatLng?> pickLocation(BuildContext context) async {
    LatLng? pickLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPicker(),
      ),
    );
    return pickLocation;
  }

  static Future<String> getLocationDetails(LatLng postion) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(postion.latitude, postion.longitude);
    return "${placemarks[0].thoroughfare} , ${placemarks[0].locality} , ${placemarks[0].country}";
  }
}
