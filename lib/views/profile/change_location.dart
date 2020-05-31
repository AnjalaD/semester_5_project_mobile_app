import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:semester_5_project_mobile_app/widgets/custom_button.dart';
import 'package:semester_5_project_mobile_app/widgets/map_container.dart';
import 'package:semester_5_project_mobile_app/widgets/page_wrapper.dart';

class ChangeLocation extends StatefulWidget {
  ChangeLocation({Key key}) : super(key: key);

  @override
  _ChangeLocationState createState() => _ChangeLocationState();
}

class _ChangeLocationState extends State<ChangeLocation> {
  LatLng markerPosition = new LatLng(6.9169905, 80.079268);
  LatLng prevLocation;

  @override
  void initState() {
    super.initState();
    prevLocation = markerPosition;
  }

  void _setMarker(LatLng point) {
    print('marker pos: $point');
    setState(() {
      markerPosition = point;
    });
  }

  void _setLocation() {
    setState(() {
      prevLocation = markerPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: 'Change Location',
      body: Stack(
        children: <Widget>[
          MapContainer(
            markerPosition: markerPosition,
            tappable: true,
            onTap: _setMarker,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(blurRadius: 4, color: Colors.grey),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CustomButton(
                    labelText: 'Set New Location',
                    onPressed:
                        markerPosition != prevLocation ? _setLocation : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8),
                    child: Text(
                      "Lat:${markerPosition.latitude.toStringAsFixed(4)}," +
                          " Lng:${markerPosition.longitude.toStringAsFixed(4)}",
                      style: Theme.of(context).primaryTextTheme.caption,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
