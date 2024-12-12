import 'package:core_api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class StepMarker extends Marker {
  final StepsDTO step;
  final bool isSelected;

  StepMarker(
      {required this.step, required this.isSelected, Function()? onPressed})
      : super(
          width: isSelected ? 96 : 64,
          height: isSelected ? 96 : 64,
          point: LatLng(step.location.lat, step.location.lng),
          child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.local_taxi_sharp,
                size: isSelected ? 48 : 32,
                color: isSelected ? Colors.red : Colors.green,
              )),
        );
}
