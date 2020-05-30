import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:flutter_circular_chart/flutter_circular_chart.dart';
// import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    var token = "Bearer " + prefs.getString('token');
    try {
      await http.get(Uri.encodeFull('http://tugasakhir.kubusoftware.com/pantauan'), headers: { 'accept':'application/json', 'Authorization':token})
      .then((response) async {
        var data = json.decode(response.body);
        setState(() {
          tegangan = data['tegangan'].toString();
          arus = data['arus'].toString();
          daya = data['daya'].toString();
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Material cardItems(String title, String priceVal,String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(title, style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(priceVal, style: TextStyle(
                      fontSize: 30.0,
                    ),),
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Text(subtitle, style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.blueGrey,
                    ),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color:Color(0xffE5E5E5),
      child:StaggeredGridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: cardItems("Tegangan","220","Volt"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: cardItems("Arus","1.20","Ampere"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: cardItems("Daya","280","Watt"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: cardItems("Power Factor","0.20",""),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: cardItems("Power","0.020","Kwh"),
          ),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 150.0),
          StaggeredTile.extent(2, 150.0),
          StaggeredTile.extent(2, 150.0),
          StaggeredTile.extent(2, 150.0),
          StaggeredTile.extent(4, 150.0),
        ],
      )
    );
    // return CustomScrollView(
    //   slivers: <Widget>[
    //     SliverPadding(
    //       padding: const EdgeInsets.all(16.0),
    //       sliver: SliverGrid.count(
    //         crossAxisSpacing: 16.0,
    //         mainAxisSpacing: 16.0,
    //         childAspectRatio: 1.5,
    //         crossAxisCount: 3,
    //         children: <Widget>[
    //           Container(
    //             padding: const EdgeInsets.all(8.0),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(10.0),
    //               color: Colors.blue,
    //             ),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: <Widget>[
    //                 Text(tegangan, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white)),
    //                 const SizedBox(height: 5.0),
    //                 Text("Volt")
    //               ],
    //             ),
    //           ),
    //           Container(
    //             padding: const EdgeInsets.all(8.0),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(10.0),
    //               color: Colors.pink,
    //             ),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: <Widget>[
    //                 Text(arus,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white)),
    //                 const SizedBox(height: 5.0),
    //                 Text("Ampere")
    //               ],
    //             ),
    //           ),
    //           Container(
    //             padding: const EdgeInsets.all(8.0),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(10.0),
    //               color: Colors.green,
    //             ),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: <Widget>[
    //                 Text(daya,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white)),
    //                 const SizedBox(height: 5.0),
    //                 Text("Watt")
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }  
}