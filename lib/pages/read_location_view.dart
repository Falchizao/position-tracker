import 'package:flutter/material.dart';
import 'package:suficiencia_flutter_marcelo_falchi/model/location.dart';
import 'package:suficiencia_flutter_marcelo_falchi/pages/action_read_page.dart';

class ViewLocation extends StatelessWidget {
  final Location location;

  ViewLocation({required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text("Name : ${location.name}"),
            SizedBox(
              height: 20,
            ),
            Text("Details: ${location.details}"),
            SizedBox(
              height: 20,
            ),
            Text("Differential: ${location.differentials}"),
            SizedBox(
              height: 20,
            ),
            Text("CEP: ${location.cep}"),
            SizedBox(
              height: 20,
            ),
            Text("Included At: ${location.registeredDate}"),
          ],
        ),
      ),
    );
  }
}
