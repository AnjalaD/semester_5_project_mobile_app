import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class MapContainer extends StatelessWidget {
  const MapContainer({
    Key key,
    this.markerPosition,
    this.center,
    this.onTap,
    this.mapController,
  }) : super(key: key);

  final LatLng center;
  final LatLng markerPosition;
  final Function onTap;
  final MapController mapController;

  @override
  Widget build(BuildContext context) {
    print('center :' + center.toString());

    return Container(
      height: 250,
      margin: EdgeInsets.only(top: 8, left: 8, right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: FlutterMap(
        mapController: MapController(),
        options: MapOptions(
          onTap: onTap,
          center: center,
          zoom: 10.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(
            markers: [
              Marker(
                point: markerPosition,
                anchorPos: AnchorPos.align(AnchorAlign.top),
                builder: (context) => Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 36,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
