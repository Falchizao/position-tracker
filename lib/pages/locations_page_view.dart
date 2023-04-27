import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:suficiencia_flutter_marcelo_falchi/pages/action_form_page_view.dart';

import '../dao/locations_dao.dart';
import '../model/location.dart';
import '../widget/location_card.dart';

class LocationsView extends StatefulWidget {
  @override
  _LocationsViewState createState() => _LocationsViewState();
}

class _LocationsViewState extends State<LocationsView> {
  final TextEditingController _searchController = TextEditingController();
  final LocationDao _searchDao = LocationDao();
  late Future<List<Location>> _searches;
  List<Location> searcheds = [];

  @override
  void initState() {
    super.initState();
    _searches = _searchDao.getSearches();
    setState(() {});
  }

  String? resultado;

  Future<List<Location>> fetchPastLocations() async {
    List<Location> searchLocations = [];

    if (_searchController.text == null || _searchController.text == "") {
      searchLocations = await _searchDao.getSearches();
    } else {
      searchLocations = await _searchDao.list(_searchController.text);
    }

    setState(() {
      searcheds = searchLocations;
    });
    return searchLocations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Search Page')),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActionLocation(),
                      ),
                    );
                  },
                  child: const Text('Add Location'),
                ),
              ),
              TextField(
                  controller: _searchController,
                  onSubmitted: null,
                  decoration: InputDecoration(
                    labelText:
                        'Search by include date, name, details or differentials',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        fetchPastLocations();
                      },
                    ),
                  )),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: searcheds.length,
                  itemBuilder: (BuildContext context, int index) {
                    return LocationCard(location: searcheds[index]);
                  },
                ),
              )
            ])));
  }
}
