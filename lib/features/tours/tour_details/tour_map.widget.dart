import 'dart:async';

import 'package:faircare/global/fc_colors.dart';
import 'package:faircare/features/tours/tour.model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../tour_details.bloc.dart';

class TourMapWidget extends StatefulWidget {
  const TourMapWidget({Key? key, required this.tour, this.visits = const []})
      : super(key: key);

  final TourModel tour;
  final List<TourDetailsItem> visits;

  @override
  State<TourMapWidget> createState() => TourMapWidgetState();
}

class TourMapWidgetState extends State<TourMapWidget> {
  late bool _showMap;

  late final Completer<GoogleMapController> _controller;

  late final CameraPosition cameraPosition;

  late final Circle circle;

  late final Set<Marker> markers;

  late final GoogleMap map;

  @override
  void initState() {
    _controller = Completer<GoogleMapController>();
    cameraPosition = CameraPosition(
      target: LatLng(widget.tour.centerLatitude, widget.tour.centerLongitude),
      zoom:
          10, //TODO calculate optimal zoom based on widget.tour.plannedCommuteRadius
    );

    markers = <Marker>{};
    if (widget.visits.isNotEmpty) {
      for (var e in widget.visits) {
        if (e.patient == null) continue;
        markers.add(Marker(
            position: LatLng(e.patient!.latitude, e.patient!.longitude),
            markerId: MarkerId(e.patient!.id.toString())));
      }
    }

    circle = Circle(
        circleId: CircleId(widget.tour.id.toString()),
        center: LatLng(widget.tour.centerLatitude, widget.tour.centerLongitude),
        radius: widget.tour.plannedCommuteRadius.toDouble(),
        fillColor: FCColors.prime.withOpacity(0.3),
        strokeColor: FCColors.prime.withOpacity(0.6),
        strokeWidth: 3);
    _showMap = false;

    loadMap() async {
      map = GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        initialCameraPosition: cameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: widget.visits.isEmpty ? {} : markers,
        circles: widget.visits.isEmpty ? {circle} : {},
      );
    }

    loadMap().then((value) {
      setState(() {
        _showMap = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: _showMap ? map : Container(),
    );
  }
}
