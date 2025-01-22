import 'package:geolocator/geolocator.dart';

class LocationServices {
  Future<void> checkLocationPermissions() async {
    LocationPermission permission;

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions denied');
    }

    Position position = await Geolocator.getCurrentPosition();
    print('Location: ${position.latitude}, ${position.longitude}');
  }
}
