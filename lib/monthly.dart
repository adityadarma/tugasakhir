import 'package:flutter/material.dart';

class Monthly extends StatefulWidget {
  final String relayId;

  Monthly({this.relayId});
  @override
  _MonthlyState createState() => _MonthlyState();
}

class _MonthlyState extends State<Monthly> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Bulanan ' + widget.relayId),
    );
  }
}