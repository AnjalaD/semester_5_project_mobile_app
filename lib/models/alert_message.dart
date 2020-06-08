import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

Map<int, Color> colorMap = {
  5: Colors.red,
  4: Colors.orange,
  3: Colors.yellow,
  2: Colors.green,
  1: Colors.blue,
};

class AlertMessage {
  final String title;
  final String description;
  final int level;
  final String receivedOn;
  final double radius;
  final LatLng center;
  final Color color;

  AlertMessage(this.title, this.description, this.receivedOn, this.level,
      this.radius, this.center, this.color);

  AlertMessage.fromJson(Map<String, dynamic> json)
      : this.title = json["title"],
        this.description = json["body"],
        this.level = int.tryParse(json["level"]),
        this.radius = double.tryParse(json["radius"]),
        this.center = toLatLng(json["center"]),
        this.receivedOn = json['date_time'],
        this.color = colorMap[int.tryParse(json["level"])];

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "body": description,
      "level": level.toString(),
      "date_time": receivedOn,
      "radius": "",
      "center": "",
    };
  }

  static LatLng toLatLng(String center) {
    if (center.length < 5) return null;
    center = center.substring(1, center.length - 1);
    List<String> temp = center.split(',');
    return LatLng(double.tryParse(temp[1]), double.tryParse(temp[0]));
  }

  @override
  String toString() {
    return '--AlertMessage(title:$title, description:$description, level:$level, radius:$radius, center:$center)';
  }
}
