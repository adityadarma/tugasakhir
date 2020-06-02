import 'dart:convert';
import 'package:flutter/material.dart';
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
  String pf = '0';

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    var token = "Bearer " + prefs.getString('token');
    try {
      await http.get(Uri.encodeFull('http://restapi-ta.kubusoftware.com/pantauan'), headers: { 'accept':'application/json', 'Authorization':token})
      .then((response) async {
        var data = json.decode(response.body);
        setState(() {
          tegangan = data['tegangan'].toString();
          arus = data['arus'].toString();
          daya = data['daya'].toString();
          pf = data['pf'].toString();
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
            child: cardItems("Tegangan",tegangan,"Volt"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: cardItems("Arus",arus,"Ampere"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: cardItems("Daya",daya,"Watt"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: cardItems("Power Factor",pf,""),
          ),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 200.0),
          StaggeredTile.extent(2, 200.0),
          StaggeredTile.extent(2, 200.0),
          StaggeredTile.extent(2, 200.0),
        ],
      )
    );
  }  
}