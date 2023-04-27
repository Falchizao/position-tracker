import 'package:flutter/material.dart';

List<PopupMenuEntry<String>> criarItensMenuPopup() {
  return [
    PopupMenuItem<String>(
        value: 'view',
        child: Row(
          children: const [
            Icon(Icons.remove_red_eye, color: Colors.black),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('View'),
            )
          ],
        )),
    PopupMenuItem<String>(
        value: 'edit',
        child: Row(
          children: const [
            Icon(Icons.edit, color: Colors.black),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Edit'),
            )
          ],
        )),
    PopupMenuItem<String>(
        value: 'remove',
        child: Row(
          children: const [
            Icon(Icons.delete, color: Colors.red),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Delete'),
            )
          ],
        )),
    PopupMenuItem<String>(
        value: 'calculate_route',
        child: Row(
          children: const [
            Icon(Icons.remove_red_eye, color: Colors.red),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Delete'),
            )
          ],
        )),
    PopupMenuItem<String>(
        value: 'view_map',
        child: Row(
          children: const [
            Icon(Icons.remove_red_eye, color: Colors.red),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Delete'),
            )
          ],
        )),
  ];
}
