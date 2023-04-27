import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:suficiencia_flutter_marcelo_falchi/dao/locations_dao.dart';

import '../model/location.dart';
import '../provider/fetch_location_data.dart';
import '../widget/toast.dart';

class ActionLocation extends StatefulWidget {
  @override
  _ActionLocationState createState() => _ActionLocationState();
}

class _ActionLocationState extends State<ActionLocation> {
  late Future<List<Location>>? locations;

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final LocationDao _locationDao = LocationDao();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _differentialsController =
      TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _imageurlController = TextEditingController();

  Future _addLocation() async {
    String name = _nameController.text;
    String details = _detailsController.text;
    String differentials = _differentialsController.text;
    String cep = _cepController.text;
    String imageurl = _imageurlController.text;

    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    Location location = Location(
        cep: cep,
        name: name,
        details: details,
        differentials: differentials,
        image: imageurl,
        id: null,
        data: null);

    try {
      await onSubmit(location);
      handleToast("Location added with success!");
      Navigator.pop(context);
    } catch (e) {
      handleToast("Erro while trying to add new location, try again");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'New Location',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: TextEditingController(text: _nameController.text),
                  onChanged: (name) {
                    _nameController.text = name;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Location name',
                  ),
                  validator: (name) {
                    if (name != null || name!.isEmpty) {
                      return 'Insert a name ';
                    }
                    return null;
                  },
                  onSaved: (name) {
                    if (name != null || name!.isEmpty) {
                      _nameController.text = name;
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller:
                      TextEditingController(text: _detailsController.text),
                  onChanged: (details) {
                    _detailsController.text = details;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Location details',
                  ),
                  validator: (details) {
                    if (details != null || details!.isEmpty) {
                      return 'Insert the details';
                    }
                    return null;
                  },
                  onSaved: (details) {
                    if (details != null || details!.isEmpty) {
                      _detailsController.text = details;
                    }
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: TextEditingController(
                      text: _differentialsController.text),
                  onChanged: (diff) {
                    _differentialsController.text = diff;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Location differentials',
                  ),
                  validator: (diff) {
                    if (diff != null || diff!.isEmpty) {
                      return 'Insert the differentials';
                    }
                    return null;
                  },
                  onSaved: (diff) {
                    if (diff != null || diff!.isEmpty) {
                      _differentialsController.text = diff;
                    }
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: TextEditingController(text: _cepController.text),
                  onChanged: (cep) {
                    _cepController.text = cep;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Location CEP',
                  ),
                  validator: (cep) {
                    if (cep != null || cep!.isEmpty) {
                      return 'Insert the CEP';
                    }
                    return null;
                  },
                  onSaved: (cep) {
                    if (cep != null || cep!.isEmpty) {
                      _cepController.text = cep;
                    }
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller:
                      TextEditingController(text: _imageurlController.text),
                  onChanged: (image) {
                    _imageurlController.text = image;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Location image',
                  ),
                  validator: (image) {
                    if (image != null || image!.isEmpty) {
                      return 'Insert the image';
                    }
                    return null;
                  },
                  onSaved: (image) {
                    if (image != null || image!.isEmpty) {
                      _imageurlController.text = image;
                    }
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState != null) {
                      _addLocation();
                    }
                  },
                  child: const Text('Register new Location!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
