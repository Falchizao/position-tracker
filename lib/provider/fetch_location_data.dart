import 'dart:convert';

import 'package:suficiencia_flutter_marcelo_falchi/model/location.dart';
import "package:http/http.dart" as http;
import 'package:suficiencia_flutter_marcelo_falchi/widget/toast.dart';
import '../dao/locations_dao.dart';

Future<void> onSubmit(Location location) async {
  String url = 'https://viacep.com.br/ws/${location.cep}/json/';

  dynamic response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    dynamic result = json.decode(response.body);
    Location location3 = Location.fromMap(result);
    try {
      final LocationDao _locationDao = LocationDao();
      _locationDao.insertLocation(location);
      handleToast("Location added with success!");
    } catch (e) {
      handleToast(e.toString());
    }
  } else {
    handleToast("INVALID CEP!");
  }
}

Future<void> editLocation(Location location) async {
  final LocationDao _locationDao = LocationDao();
  try {
    num resp = await _locationDao.edit(location);
    if (resp > 0) {
      handleToast("updated location!");
    } else {
      handleToast("error while editing location!");
    }
  } catch (e) {
    handleToast("error att the location");
  }
}
