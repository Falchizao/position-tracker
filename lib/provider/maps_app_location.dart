import "dart:convert";
import 'package:maps_launcher/maps_launcher.dart';
import "package:http/http.dart" as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import "package:http/http.dart" as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<void> getAddress(String cep) async {
  String url = 'https://viacep.com.br/ws/$cep/json/';

  dynamic response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    dynamic result = json.decode(response.body);

    String localidade = result["localidade"];
    String logradouro = result["logradouro"];
    String bairro = result["bairro"];
    String uf = result["uf"];

    String concated = '$localidade $logradouro $bairro $uf';

    MapsLauncher.launchQuery(concated);
  }
}
