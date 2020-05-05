import 'package:latlong/latlong.dart';

class NotificationData {
  final String title;
  final String description;
  final String severity;
  final LatLng center;
  final double radius;

  NotificationData(
      this.title, this.description, this.severity, this.center, this.radius);

  NotificationData.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        severity = json['severity'],
        center = new LatLng(
          double.parse(json['lat']),
          double.parse(json['lon']),
        ),
        radius = double.parse(json['radius']);
}
