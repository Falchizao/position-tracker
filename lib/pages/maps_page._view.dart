import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import "package:http/http.dart" as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:math' show cos, sqrt, asin;

import 'package:suficiencia_flutter_marcelo_falchi/widget/toast.dart';

import '../service/maps_service.dart';

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
      try {
        dynamic content = json.decode(response.body);
        String logradouro = content["logradouro"];
        String bairro = content["bairro"];
        String localidade = content["localidade"];
        String uf = content["uf"];

        String concat = '${logradouro} ${bairro} ${localidade} ${uf}';

        List<Location> finallocation = await locationFromAddress(concat);
        final LatLng attmap =
            LatLng(finallocation[0].latitude, finallocation[0].longitude);

        Marker marker = Marker(
          markerId: MarkerId('Destino'),
          position: attmap,
          infoWindow: InfoWindow(
            title: 'Destino ${widget.locationCEP}',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(1),
        );

        markers.add(marker);

        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: attmap,
              zoom: 18.0,
            ),
          ),
        );
      } catch (e) {
        print(e);
      }
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
