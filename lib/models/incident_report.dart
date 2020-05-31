import 'dart:io';

import 'package:dio/dio.dart';
import 'package:latlong/latlong.dart';
import 'package:semester_5_project_mobile_app/util/classes/report_category.dart';

class IncidentReport {
  final ReportCategory categories;
  final String title;
  final String description;
  final LatLng location;
  final File image;

  IncidentReport({
    this.categories,
    this.title,
    this.description,
    this.location,
    this.image,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'title': title,
      'description': description,
      'data':
          '{"location":{"lat":${location.latitude},"lng":${location.longitude}},"categories":${categories.selected}}'
    };
    if (image != null) {
      map.addAll({
        'image': MultipartFile.fromFile(image.path),
      });
    }
    return map;
  }
}
