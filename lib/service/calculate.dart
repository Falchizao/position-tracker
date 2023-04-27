import 'dart:math';
import 'package:geolocator/geolocator.dart';
import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'maps_service.dart';

Future<num?> calculateDistanceCEP(String cep) async {
  String url = 'https://viacep.com.br/ws/${cep}/json/';

  dynamic response = await http.get(Uri.parse(url));
  num distance = 0;
  if (response.statusCode == 200) {
    try {
      dynamic content = json.decode(response.body);
      String logradouro = content["logradouro"];
      String bairro = content["bairro"];
      String localidade = content["localidade"];
      String uf = content["uf"];

      String concat = '${logradouro} ${bairro} ${localidade} ${uf}';

      Position myLoc = await getCurrentLocation();
      List<Location> finallocation = await locationFromAddress(concat);

      distance = calculateDistance(myLoc.latitude, myLoc.longitude,
          finallocation[0].latitude, finallocation[0].longitude);
      String a = '';
    } catch (e) {
      print(e);
    }

    return distance;
  }
}

// Calcula em KM
double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var a = 0.5 -
      cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
