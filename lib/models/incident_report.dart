import 'dart:io';

import 'package:latlong/latlong.dart';

class IncidentReport {
  final String type;
  final String details;
  final LatLng location;
  final File image;

  IncidentReport(
    this.type,
    this.details,
    this.location,
    this.image,
  );

  Map<String, dynamic> toJson() => {
        'title': type,
        'description': details,
        'location': {'lat': location.latitude, 'lng': location.longitude}
      };
}
