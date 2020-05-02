import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class MapContainer extends StatelessWidget {
  const MapContainer({
    Key key,
    @required this.markerPosition,
    this.onTap,
  }) : super(key: key);

  final LatLng markerPosition;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: EdgeInsets.only(top: 8, left: 8, right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: FlutterMap(
        options: MapOptions(
          onTap: onTap,
          center: LatLng(51.5, -0.09),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(
            markers: [
              Marker(
                point: markerPosition,
                builder: (context) => Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 48,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
