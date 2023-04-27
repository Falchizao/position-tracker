import 'dart:convert';

import 'package:maps_launcher/maps_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import "package:http/http.dart" as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:math' show cos, sqrt, asin;

import 'package:suficiencia_flutter_marcelo_falchi/widget/toast.dart';

class MapView extends StatefulWidget {
  final String locationCEP;

  MapView({required this.locationCEP});

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  late GoogleMapController mapController;
  Set<Marker> markers = {};

  late Location _currentPosition;
  late final Future myFuture;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late LatLng initial;

  _getAddress() async {
    String url = 'https://viacep.com.br/ws/${widget.locationCEP}/json/';

    dynamic response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      dynamic result = json.decode(response.body);

      String localidade = result["localidade"];
      String logradouro = result["logradouro"];
      String bairro = result["bairro"];
      String uf = result["uf"];

      String concated = '$localidade $logradouro $bairro $uf';

      MapsLauncher.launchQuery(concated);

      List<Location>? destinationPlacemark =
          await locationFromAddress(concated);

      // await Geolocator.getCurrentPosition(
      //         desiredAccuracy: LocationAccuracy.high)
      //     .then((Position position) async {
      //   setState(() {
      //     mapController.animateCamera(
      //       CameraUpdate.newCameraPosition(
      //         CameraPosition(
      //           target: LatLng(position.latitude, position.longitude),
      //           zoom: 18.0,
      //         ),
      //       ),
      //     );
      //   });
      //   await _getAddress();
      //   }).catchError((e) {
      //     print(e);
      //   });
      // } else {
      //   print("erro");
    }
  }

  @override
  void initState() {
    super.initState();
    myFuture = _getAddress();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            FutureBuilder<dynamic>(
              future: myFuture,
              builder: (context, snapshot) {
                return GoogleMap(
                    markers: Set<Marker>.from(markers),
                    initialCameraPosition: _initialLocation,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    mapType: MapType.normal,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
