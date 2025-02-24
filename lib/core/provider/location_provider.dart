import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationProvider extends ChangeNotifier {
  LatLng? userLocation;

  //update Location
 Future<void> getCurrentLocation(BuildContext context) async {
    PermissionStatus permission = await Permission.location.request();

    if (permission.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      userLocation = LatLng(
        position.latitude,
        position.longitude,
      );
      notifyListeners();
    } else if (permission.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Location Permission Denied"),
        ),
      );
    } else if (permission.isPermanentlyDenied){
      openAppSettings();
    }
  }
}
