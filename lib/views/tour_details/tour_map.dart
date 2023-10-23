import 'dart:async';

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
  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  late CameraPosition position = CameraPosition(
    target: LatLng(
      widget.model.centerLatitude,
      widget.model.centerLongitude,
    ),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 200,
          child: GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            initialCameraPosition: position,
            onMapCreated: (GoogleMapController c) {
              controller.complete(c);
            },
          ),
        ),
        // Positioned(
        //   top: 32,
        //   bottom: 32,
        //   right: 32,
        //   child: Container(
        //     height: 136,
        //     width: 136,
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       border: Border.all(color: MyColors.prime, width: 4),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
