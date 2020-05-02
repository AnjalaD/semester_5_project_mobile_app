import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:semester_5_project_mobile_app/views/profile/widgets/custom_row.dart';
import 'package:semester_5_project_mobile_app/widgets/custom_button.dart';
import 'package:semester_5_project_mobile_app/widgets/map_container.dart';
import 'package:semester_5_project_mobile_app/widgets/page_wrapper.dart';

class ChangeLocation extends StatefulWidget {
  ChangeLocation({Key key}) : super(key: key);

  @override
  _ChangeLocationState createState() => _ChangeLocationState();
}

class _ChangeLocationState extends State<ChangeLocation> {
  final MapController mapController = new MapController();
  final Location location = new Location();
  LatLng markerPosition = new LatLng(7.9169905, 80.039268);
  LatLng center = new LatLng(7.9169905, 80.039268);
  bool current = true;
  LatLng prevLocation;

  @override
  void initState() {
    super.initState();
    prevLocation = markerPosition;
  }

  void _setMarker(LatLng point) {
    print(point.toString());
    setState(() {
      markerPosition = point;
    });
  }

  void _getLocation() async {
    print('getting location');
    try {
      LocationData locationData = await location.getLocation();
      print(locationData.toString());
      mapController.onReady.then((val) {
        print('ready');
        mapController.move(
            new LatLng(locationData.latitude, locationData.longitude), 10);
      });

      setState(() {
        markerPosition =
            new LatLng(locationData.latitude, locationData.longitude);
      });
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: 'Change Location',
      body: Column(
        children: <Widget>[
          MapContainer(
            center: center,
            markerPosition: markerPosition,
            onTap: !current ? _setMarker : null,
            mapController: mapController,
          ),
          CustomRow(
            value: current,
            title: 'Current Location',
            refresh: true,
            onRefresh: _getLocation,
            onChanged: (bool value) {
              setState(() {
                current = value;
              });
            },
          ),
          CustomRow(
            value: !current,
            title: 'Custom Location',
            onChanged: (bool value) {
              setState(() {
                current = !value;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: CustomButton(
              labelText: 'Set New Location',
              onPressed: markerPosition != prevLocation ? () {} : null,
            ),
          ),
          Text(
            "Lat:${markerPosition.latitude.toStringAsFixed(4)}," +
                " Lng:${markerPosition.longitude.toStringAsFixed(4)}",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
