import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Monthly extends StatefulWidget {
  final String relayId;

  Monthly({this.relayId});
  @override
  _MonthlyState createState() => _MonthlyState();
}

void createRecord(String id) async {
  var db = Firestore.instance;
  db.collection('control').document(id).collection('use').add(
    {
      'created' : DateTime.now(),
      'watt' : 10
    }
  );
}

class _MonthlyState extends State<Monthly> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
            child: Text('Create Record'),
            onPressed: () {
              createRecord(widget.relayId);
            },
          ),
    );
  }
}