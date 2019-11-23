import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iot/customcard.dart';
import 'package:iot/login.dart';
import 'package:iot/creator.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class Home extends StatefulWidget {
  final drawerItems = [new DrawerItem("Control", Icons.person)];

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TabController controller;
  final db = Firestore.instance;

  void doLogout() async {
    FirebaseAuth.instance.signOut()
    .then((e){
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: Icon(Icons.home),
        title: Text('MEMORI'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context){
              return Constants.choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Center(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: db.collection('control').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          return new CustomCard(
                            id : document['id'],
                            name : document['name'],
                            value : document['value'],
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

  void choiceAction(String choice) {
    if (choice == Constants.Pembuat) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) {
          return Creator();
        }),
      );
    } else if (choice == Constants.SignOut) {
      doLogout();
    }
  }
}

class Constants {
  static const String Pembuat = 'Pembuat';
  static const String SignOut = 'Sign out';

  static const List<String> choices = <String>[Pembuat, SignOut];
}