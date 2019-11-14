import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iot/control.dart';
import 'package:iot/login.dart';
import 'package:iot/created.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class Home extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Control", Icons.person)
  ];

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TabController controller;

  String name = '';
  String email = '';
  String photo = '';

  void doLogout() async {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));

  }

  @override
  void initState() {
    super.initState();
    getUser();
    
  }

  getUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      email = prefs.getString('email');
      photo = prefs.getString('photo');
    });
  }

  int _selectedDrawerIndex = 0;
  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new Control();

      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
        new ListTile(
          leading: new Icon(d.icon),
          title: new Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        )
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('MeMoRi'),
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
      body: _getDrawerItemWidget(_selectedDrawerIndex),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(name),
              accountEmail: Text(email),
              currentAccountPicture:
                  CircleAvatar (
                    backgroundImage: NetworkImage(photo),
                  ),
              decoration: BoxDecoration(color: Colors.red[400]),
            ),
            new Column(children: drawerOptions),
          ],
        ),
      ),
    );
  }
  void choiceAction(String choice){
    if(choice == Constants.Pembuat){
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) {
          return Created();
        }),
      );
    }else if(choice == Constants.SignOut){
      doLogout();
    }
  }
}

class Constants{
  static const String Pembuat = 'Pembuat';
  static const String SignOut = 'Sign out';

  static const List<String> choices = <String>[
    Pembuat,
    SignOut
  ];
}