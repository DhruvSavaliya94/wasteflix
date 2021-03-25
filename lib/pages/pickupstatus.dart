import 'package:flutter/material.dart';

class PickupStatusPage extends StatefulWidget {
  @override
  _PickupStatusPageState createState() => _PickupStatusPageState();
}

class _PickupStatusPageState extends State<PickupStatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Dashboard'),
      ),
    );
  }
}
