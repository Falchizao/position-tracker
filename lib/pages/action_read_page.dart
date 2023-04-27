import 'package:flutter/material.dart';
import 'package:suficiencia_flutter_marcelo_falchi/dao/locations_dao.dart';
import 'package:suficiencia_flutter_marcelo_falchi/model/location.dart';
import 'package:suficiencia_flutter_marcelo_falchi/pages/action_edit_page_view.dart';
import 'package:suficiencia_flutter_marcelo_falchi/pages/maps_page._view.dart';
import 'package:suficiencia_flutter_marcelo_falchi/pages/read_location_view.dart';
import 'package:suficiencia_flutter_marcelo_falchi/widget/toast.dart';
import '../provider/maps_app_location.dart';
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

  Future<void> _calculateDistance() async {
    num? distance = 0;
    handleToast('Loading....');
    try {
      distance = await calculateDistanceCEP(widget.location.cep);
      handleToast(
          'Distancia em linha reta é de aproximadamente ${distance.toString()} KM!');
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
            SizedBox(
              width: 400,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ActionEditPage(location: widget.location),
                    ),
                  );
                },
                child: const Text('Edit Location'),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 400,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  removeLocation();
                  Navigator.pop(context);
                },
                child: const Text('Remove Location'),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 400,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ViewLocation(location: widget.location),
                    ),
                  );
                },
                child: const Text('View Location Info'),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 400,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MapView(locationCEP: widget.location.cep),
                    ),
                  );
                },
                child: const Text('View in Maps this APP'),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 400,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  getAddress(widget.location.cep);
                },
                child: const Text('View in Google Maps APP'),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 400,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  _calculateDistance();
                },
                child: const Text('Calculate Distance in KM'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
