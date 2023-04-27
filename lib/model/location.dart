import 'dart:convert';
import 'package:intl/intl.dart';

class Location {
  int? id;
  String name;
  String details;
  String differentials;
  String cep;
  String image;
  String? data;
  String registeredDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  Location(
      {required this.id,
      required this.name,
      required this.details,
      required this.differentials,
      required this.cep,
      required this.image,
      required this.data});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cep': cep,
      'name': name,
      'details': details,
      'differentials': differentials,
      'image': image,
      'included': registeredDate,
    };
  }

  static Location fromMap(Map<String, dynamic> map) {
    return Location(
      id: map['id'],
      cep: map['cep'],
      name: map['name'],
      details: map['details'],
      differentials: map['differentials'],
      image: map['image'],
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  static Location fromJson(String source) => fromMap(json.decode(source));

// model: Contains the classes that represent the data models in your application.
// These classes usually have properties and methods to convert to and from JSON,
// as well as any data validation or manipulation logic.

// provider: Contains the classes that manage the state and business logic of your application.
// These classes usually extend ChangeNotifier or use other state management solutions like Bloc or MobX.

// dao: Contains the Data Access Object (DAO) classes that handle the communication between
// your application and a local database (such as SQLite) or a remote API.

// pages: Contains the main screens of your application, usually represented as StatefulWidget
// or StatelessWidget classes. Each page should be responsible for its layout and navigation to other pages.

// services: Contains the classes that provide utility functions and handle communication with
// external services, such as APIs, local databases, or device features (e.g., location, camera, etc.).

// widgets: Contains the reusable UI components of your application, such as buttons, cards, or
// custom input fields. These are usually StatefulWidget or StatelessWidget classes that can be used
// across multiple pages.
}
