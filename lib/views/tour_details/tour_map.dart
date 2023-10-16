import 'dart:async';

import 'package:faircare/global/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TourMap extends StatefulWidget {
  const TourMap({Key? key}) : super(key: key);

  @override
  State<TourMap> createState() => TourMapState();
}

class TourMapState extends State<TourMap> {
  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  static const CameraPosition position = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 200,
          child: GoogleMap(
            mapType: MapType.hybrid,
            zoomControlsEnabled: false,
            initialCameraPosition: position,
            onMapCreated: (GoogleMapController c) {
              controller.complete(c);
            },
          ),
        ),
        Positioned(
          top: 32,
          bottom: 32,
          right: 32,
          child: Container(
            height: 140,
            width: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: MyColors.prime, width: 4),
            ),
          ),
        ),
      ],
    );
  }
}
