import 'dart:async';

import 'package:faircare/global/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VisitMapWidget extends StatefulWidget {
  final double latitude, longitude;
  final bool obfuscate;

  const VisitMapWidget(
      {super.key,
      required this.latitude,
      required this.longitude,
      required this.obfuscate});

  @override
  State<VisitMapWidget> createState() => VisitMapWidgetState();
}

class VisitMapWidgetState extends State<VisitMapWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late final CameraPosition cameraPosition = CameraPosition(
    target: LatLng(widget.latitude, widget.longitude),
    zoom: 12,
  );

  late final Circle circle = Circle(
      circleId: const CircleId('1'),
      center: LatLng(widget.latitude, widget.longitude),
      radius: widget.obfuscate ? 3000.toDouble() : 100.toDouble(),
      fillColor: MyColors.prime.withOpacity(0.3),
      strokeColor: MyColors.prime.withOpacity(0.6),
      strokeWidth: 3);

  late final Marker marker = Marker(
      position: LatLng(widget.latitude, widget.longitude),
      markerId: const MarkerId('2'));

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
        markers: widget.obfuscate ? {} : {marker},
        circles: widget.obfuscate ? {circle} : {},
      ),
    );
  }
}
