import 'package:flutter/material.dart';

class Daily extends StatefulWidget {
  final String relayId;

  Daily({this.relayId});
  @override
  _DailyState createState() => _DailyState();
}

class _DailyState extends State<Daily> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Harian ' + widget.relayId),
    );
  }
}