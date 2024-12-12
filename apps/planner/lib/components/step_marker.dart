import 'package:core_api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class StepMarker extends Marker {
  final StepsDTO step;

  StepMarker({required this.step, required Function() onPressed})
      : super(
          width: 60.0,
          height: 60.0,
          point: LatLng(step.location.lat, step.location.lng),
          child: IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.local_taxi_sharp,
                size: 30,
                color: Colors.red,
              )),
        );
}
