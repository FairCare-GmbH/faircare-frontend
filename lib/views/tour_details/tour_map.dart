import 'dart:async';

import 'package:faircare/global/colors.dart';
import 'package:faircare/models/tour_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TourMap extends StatefulWidget {
  const TourMap(this.model, {Key? key}) : super(key: key);

  final TourModel model;

  @override
  State<TourMap> createState() => TourMapState();
}

class TourMapState extends State<TourMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late final CameraPosition cameraPosition = CameraPosition(
    target: LatLng(widget.model.centerLatitude, widget.model.centerLongitude),
    zoom: 9,
  );

  late final Circle circle = Circle(
      circleId: CircleId(widget.model.id.toString()),
      center: LatLng(widget.model.centerLatitude, widget.model.centerLongitude),
      radius: widget.model.plannedCommuteRadius.toDouble(),
      fillColor: MyColors.prime.withOpacity(0.3),
      strokeColor: MyColors.prime.withOpacity(0.6),
      strokeWidth: 3);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        initialCameraPosition: cameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        circles: {circle},
      ),
    );
  }
}
