import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String tegangan = '0';
  String arus = '0';
  String daya = '0';

  void getDataTop() async {
    final prefs = await SharedPreferences.getInstance();
    var token = "Bearer " + prefs.getString('token');

    await http.get(Uri.encodeFull('http://tugasakhir.kubusoftware.com/pantauan'), headers: { 'accept':'application/json', 'Authorization':token})
    .then((response) async {
      var data = json.decode(response.body);
      setState(() {
        tegangan = data['tegangan'].toString();
        arus = data['arus'].toString();
        daya = data['daya'].toString();
      });
    });
  }

  // setInvalTop() {
  //   Timer.periodic(Duration(milliseconds: 3000), (timer) {
  //    getDataTop();
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // setInvalTop();
    getDataTop();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverGrid.count(
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.5,
            crossAxisCount: 3,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(tegangan, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white)),
                    const SizedBox(height: 5.0),
                    Text("Volt")
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.pink,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(arus,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white)),
                    const SizedBox(height: 5.0),
                    Text("Ampere")
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.green,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(daya,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white)),
                    const SizedBox(height: 5.0),
                    Text("Watt")
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }  
}