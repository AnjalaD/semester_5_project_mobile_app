import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:semester_5_project_mobile_app/widgets/custom_button.dart';
import 'package:semester_5_project_mobile_app/widgets/map_container.dart';

class ChangeLocation extends StatefulWidget {
  ChangeLocation({Key key}) : super(key: key);

  @override
  _ChangeLocationState createState() => _ChangeLocationState();
}

class _ChangeLocationState extends State<ChangeLocation> {
  LatLng markerPosition = LatLng(51.5, -0.09);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Location'),
      ),
      body: Column(
        children: <Widget>[
          MapContainer(
            markerPosition: markerPosition,
            onTap: !current ? _setMarker : null,
          ),
          CustomRow(
            value: current,
            title: 'Current Location',
            refresh: true,
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

class CustomRow extends StatelessWidget {
  const CustomRow({
    Key key,
    this.title,
    this.value,
    this.onChanged,
    this.refresh = false,
  }) : super(key: key);

  final bool refresh;
  final String title;
  final bool value;
  final Function onChanged;

  List<Widget> _refreshButton() {
    List<Widget> row = [
      Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Switch(
          value: value,
          onChanged: onChanged,
        ),
      ),
      Text(title),
    ];
    if (refresh) {
      row.add(Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: IconButton(
          icon: Icon(Icons.refresh),
          onPressed: value ? () {} : null,
        ),
      ));
    }
    return row;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.only(left: 60),
      child: Center(
        child: Row(
          children: _refreshButton(),
        ),
      ),
    );
  }
}
