import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iot/control.dart';
import 'package:iot/login.dart';

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
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            // header
            UserAccountsDrawerHeader(
              accountName: Text(name),
              accountEmail: Text(email),
              currentAccountPicture:
                  CircleAvatar (
                    backgroundImage: NetworkImage(photo),
                  ),
              decoration: BoxDecoration(color: Colors.red[400]),
            ),
 
            // menu
            new Column(children: drawerOptions),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Log Out'),
              onTap: () {
                doLogout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
