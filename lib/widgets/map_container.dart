import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

typedef OnTap = void Function(LatLng location);

class MapContainer extends StatefulWidget {
  final LatLng markerPosition;
  final OnTap onTap;
  final bool tappable;

  const MapContainer(
      {Key key, this.markerPosition, this.onTap, this.tappable = false})
      : super(key: key);

  @override
  MapContainerState createState() {
    return MapContainerState();
  }
}

class MapContainerState extends State<MapContainer>
    with TickerProviderStateMixin {
  MapController mapController;
  LatLng markerPosition;
  Location location;

  @override
  void initState() {
    super.initState();
    location = new Location();
    mapController = MapController();
    markerPosition = this.widget.markerPosition;
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final _latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  void _getLocation() async {
    try {
      LocationData locationData = await location.getLocation();
      LatLng point = new LatLng(locationData.latitude, locationData.longitude);
      setState(() {
        markerPosition = point;
      });
      _animatedMapMove(point, 10);
      this.widget.onTap(point);
    } catch (err) {
      print('get location error :$err');
    }
  }

  void _onTap(LatLng point) {
    setState(() {
      markerPosition = point;
    });
    this.widget.onTap(point);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
              onTap: this.widget.tappable ? _onTap : null,
              center: new LatLng(6.9169905, 80.079268),
              zoom: 10.0,
              maxZoom: 15.0,
              minZoom: 6.0),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c']),
            MarkerLayerOptions(markers: [
              Marker(
                point: markerPosition,
                anchorPos: AnchorPos.align(AnchorAlign.top),
                builder: (context) => Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 36,
                ),
              )
            ])
          ],
        ),
        Positioned(
          right: 15,
          top: 15,
          child: MyLocationButton(
            onPressed: _getLocation,
          ),
        )
      ],
    );
  }
}

class MyLocationButton extends StatelessWidget {
  const MyLocationButton({
    Key key,
    this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              color: Colors.grey,
            ),
          ]),
      child: Center(
        child: IconButton(
          tooltip: 'My Location',
          iconSize: 24,
          icon: Icon(
            Icons.my_location,
            color: Colors.white,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
