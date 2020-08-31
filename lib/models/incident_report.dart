import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
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

  Future<Map<String, dynamic>> toJson() async {

    Map<String, dynamic> map = {
      'title': title,
      'description': description,
      'data':
          '{"location":{"lat":${location.latitude},"lng":${location.longitude}},"categories":${categories.selected}}'
    };
    if (image != null) {
      map.addAll({
        'image': await MultipartFile.fromFile(
          image.path,
          contentType: MediaType('image', 'jpeg'),
        )
      });
    }
    return map;
  }
}
