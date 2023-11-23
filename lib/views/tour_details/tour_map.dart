import 'dart:async';

import 'package:faircare/global/colors.dart';
import 'package:faircare/models/tour_model.dart';
import 'package:faircare/views/my_tours/tour_details.bloc.dart';
import 'package:faircare/views/my_tours/tour_visit.model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TourMapWidget extends StatefulWidget {
  const TourMapWidget({Key? key, required this.tour, this.visits = const []})
      : super(key: key);

  final TourModel tour;
  final List<TourDetailsItem> visits;

  @override
  State<TourMapWidget> createState() => TourMapWidgetState();
}

class TourMapWidgetState extends State<TourMapWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late final CameraPosition cameraPosition = CameraPosition(
    target: LatLng(widget.tour.centerLatitude, widget.tour.centerLongitude),
    zoom:
        10, //TODO calculate optimal zoom based on widget.tour.plannedCommuteRadius
  );

  late final Circle circle = Circle(
      circleId: CircleId(widget.tour.id.toString()),
      center: LatLng(widget.tour.centerLatitude, widget.tour.centerLongitude),
      radius: widget.tour.plannedCommuteRadius.toDouble(),
      fillColor: MyColors.prime.withOpacity(0.3),
      strokeColor: MyColors.prime.withOpacity(0.6),
      strokeWidth: 3);

  @override
  Widget build(BuildContext context) {
    final markers = <Marker>{};
    if (widget.visits.isNotEmpty) {
      for (var e in widget.visits) {
        if (e.patient == null) continue;
        markers.add(Marker(
            position: LatLng(e.patient!.latitude, e.patient!.longitude),
            markerId: MarkerId(e.patient!.id.toString())));
      }
    }

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
        markers: widget.visits.isEmpty ? {} : markers,
        circles: widget.visits.isEmpty ? {circle} : {},
      ),
    );
  }
}
