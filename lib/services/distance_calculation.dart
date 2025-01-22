import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';

import '../utlis/text_style.dart';

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadiusKm = 6371;

  double dLat = _degreesToRadians(lat2 - lat1);
  double dLon = _degreesToRadians(lon2 - lon1);

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_degreesToRadians(lat1)) *
          cos(_degreesToRadians(lat2)) *
          sin(dLon / 2) *
          sin(dLon / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return earthRadiusKm * c;
}

double _degreesToRadians(double degrees) {
  return degrees * pi / 180;
}

Future<String> calculateDistanceFromUser(
    double targetLatitude, double targetLongitude) async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  double currentLatitude = position.latitude;
  double currentLongitude = position.longitude;

  double distance = calculateDistance(
      currentLatitude, currentLongitude, targetLatitude, targetLongitude);

  return '${distance.toStringAsFixed(2)} km from you';
}

class DistanceText extends StatelessWidget {
  final double targetLatitude;
  final double targetLongitude;

  const DistanceText({super.key,
    required this.targetLatitude,
    required this.targetLongitude,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: calculateDistanceFromUser(targetLatitude, targetLongitude),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Calculating distance...");
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          return Text(
            snapshot.data!,
            style: AppStyle().greyStyle312,
          );
        } else {
          return const Text("Unable to calculate distance");
        }
      },
    );
  }
}
