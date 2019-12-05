import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Daily extends StatefulWidget {
  final String relayId;

  Daily({this.relayId});
  @override
  _DailyState createState() => _DailyState();
}

class _DailyState extends State<Daily> {
  final db = Firestore.instance;
  final formatter = new NumberFormat("#.###");

  @override
  Widget build(BuildContext context) {
    return Center(
     child: Container(
       child: StreamBuilder<QuerySnapshot>(
          stream: db.collection('control').document(widget.relayId).collection('use').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                        );
                  default:
                    return new ListView(
                      children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                          return Card(
                            child: Text(formatter.format(document['watt'])),
                          );
                      }).toList(),
                    );
                }
          },
       ),
     ),
    );
  }
}