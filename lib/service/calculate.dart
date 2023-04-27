import 'dart:convert';
import 'dart:ffi';

import 'package:geolocator/geolocator.dart';
import "package:http/http.dart" as http;
import 'package:suficiencia_flutter_marcelo_falchi/widget/toast.dart';

Future<num?> calculateDistance(String cep) async {
  String url = 'https://brasilapi.com.br/api/cep/v2/$cep';

  dynamic response = await http.get(Uri.parse(url));

  try {
    dynamic distanceInMeters = json.decode(response.body);
    distanceInMeters = await Geolocator.distanceBetween(
        52.2165157, 6.9437819, 52.3546274, 4.8285838);
  } catch (e) {
    handleToast(e.toString());
  }
}
