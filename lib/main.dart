import 'package:flutter/material.dart';
import 'package:suficiencia_flutter_marcelo_falchi/pages/locations_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Locations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LocationsView(),
    );
  }
}
