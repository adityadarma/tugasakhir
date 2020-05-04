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
    // print(getData());
    // var series = [
    //   charts.Series(
    //     domainFn: (UsePerDate clickData, _) => clickData.tanggal,
    //     measureFn: (UsePerDate clickData, _) => clickData.jumlah,
    //     colorFn: (UsePerDate clickData, _) => clickData.warna,
    //     id: 'Clicks',
    //     data: chartList
    //   ),
    // ];

    // var chartWidget = Padding(
    //   padding: EdgeInsets.all(32.0),
    //   child: SizedBox(
    //     height: 200.0,
    //     child: charts.BarChart(series,animate: true),
    //   ),
    // );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // chartWidget,
        ],
      ),
    ); 
  }  
}

class UsePerDate {
  final String tanggal;
  final int jumlah;
  final Color warna;

  UsePerDate(this.tanggal, this.jumlah, this.warna);
}