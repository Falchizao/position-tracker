import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation() async {
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}
