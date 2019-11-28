import 'package:flutter/material.dart';
import 'package:iot/monthly.dart';
import 'package:iot/daily.dart';
class Detail extends StatefulWidget {
  final String relayId;

  Detail({this.relayId});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        backgroundColor: Colors.red,
        bottom: new TabBar(
          controller: controller,
          tabs: <Widget>[
            new Tab(icon: new Icon(Icons.access_time), text: "Harian",),
            new Tab(icon: new Icon(Icons.access_time), text: "Bulanan",)
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          new Daily(relayId : widget.relayId),
          new Monthly(relayId : widget.relayId)
        ],
      )
    );
  }
}