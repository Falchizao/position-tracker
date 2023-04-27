import 'package:flutter/material.dart';
import 'package:suficiencia_flutter_marcelo_falchi/dao/locations_dao.dart';
import 'package:suficiencia_flutter_marcelo_falchi/model/location.dart';
import 'package:suficiencia_flutter_marcelo_falchi/pages/action_edit_page_view.dart';
import 'package:suficiencia_flutter_marcelo_falchi/pages/maps_page._view.dart';
import 'package:suficiencia_flutter_marcelo_falchi/pages/read_location_view.dart';
import 'package:suficiencia_flutter_marcelo_falchi/widget/toast.dart';

import '../service/calculate.dart';

class LocationPage extends StatefulWidget {
  LocationPage({Key? key, required this.location}) : super(key: key);

  final Location location;

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final LocationDao _searchDao = LocationDao();

  Future<void> removeLocation() async {
    try {
      await _searchDao.remove(widget.location.id!);
      handleToast("Sucess!");
    } catch (e) {
      handleToast("Error!");
    }
  }

  void _navigateToOtherPage(BuildContext context, String action) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtherPage(action: action),
      ),
    );
  }

  Future<void> _calculateDistance() async {
    num? distance = 0;

    try {
      distance = await calculateDistance(widget.location.cep);
      handleToast(
          'Distancia entre vc e o ponto turistico ${distance.toString()}');
    } catch (e) {
      handleToast("erro ao calcular distancia");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ActionEditPage(location: widget.location),
                  ),
                );
              },
              child: Text('Edit Location'),
            ),
            ElevatedButton(
              onPressed: () {
                removeLocation();
                Navigator.pop(context);
              },
              child: Text('Remove Location'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ViewLocation(location: widget.location),
                  ),
                );
              },
              child: Text('View Location Info'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MapView(locationCEP: widget.location.cep),
                  ),
                );
              },
              child: Text('View in Maps'),
            ),
            ElevatedButton(
              onPressed: () {
                _calculateDistance();
              },
              child: Text('Calculate Distance in KM'),
            ),
          ],
        ),
      ),
    );
  }
}

class OtherPage extends StatelessWidget {
  final String action;

  OtherPage({Key? key, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Other Page'),
      ),
      body: Center(
        child: Text('You selected to $action'),
      ),
    );
  }
}
