import 'package:flutter/material.dart';

class Shared extends StatefulWidget {
  @override
  _SharedState createState() => _SharedState();
}

class _SharedState extends State<Shared> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared'),
      ),
    );
  }
}