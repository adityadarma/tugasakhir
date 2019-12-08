import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Detail extends StatefulWidget {
  final String relayId;

  Detail({this.relayId});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> with SingleTickerProviderStateMixin {
  final db = Firestore.instance;
  final formatter = new NumberFormat("#.###");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pemakaian'),
        backgroundColor: Colors.red,
      ),
      body: Center(
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
      ),
    );
  }
}