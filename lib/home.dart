import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List chartList = [];

  // void getData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   var token = "Bearer " + prefs.getString('token');
  //   await http.get(Uri.encodeFull('http://192.168.1.6:8082/tanggal'), headers: { 'accept':'application/json', 'Authorization':token})
  //   .then((response) async {
  //     var data = json.decode(response.body);
  //     // setState(() {
  //       chartList = data.map((dynamic chartData) {
  //         String tanggal = chartData['tanggal'];
  //         int jumlah = chartData['jumlah'];
  //         return new UsePerDate(tanggal, jumlah, Colors.red);
  //       }).toList();
  //     // });
  //   });
  //   print(chartList);
  // }

  @override
  void initState() {
    super.initState();
    // getData();
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
                    Text(
                      "+500",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
                    ),
                    const SizedBox(height: 5.0),
                    Text("Leads".toUpperCase())
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
                    Text(
                      "+300",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
                    ),
                    const SizedBox(height: 5.0),
                    Text("Customers".toUpperCase())
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
                    Text(
                      "+1200",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
                    ),
                    const SizedBox(height: 5.0),
                    Text("Orders".toUpperCase())
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }  
}