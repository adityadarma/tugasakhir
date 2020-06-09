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
  var _pantauan;

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    var token = "Bearer " + prefs.getString('token');
    var result = await http.get(Uri.encodeFull('http://restapi-ta.kubusoftware.com/pantauan'), headers: { 'accept':'application/json', 'Authorization':token});
    setState(() {
      _pantauan = json.decode(result.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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

  Widget _buildData() {
    return _pantauan != null
        ? RefreshIndicator(
            child: Container(
                // color:Color(0xffE5E5E5),
                child:StaggeredGridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: cardItems("Tegangan",_pantauan['tegangan'],"Volt"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: cardItems("Arus",_pantauan['arus'],"Ampere"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: cardItems("Daya",_pantauan['daya'],"Watt"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: cardItems("Power Factor",_pantauan['pf'],""),
                    ),
                  ],
                  staggeredTiles: [
                    StaggeredTile.extent(2, 200.0),
                    StaggeredTile.extent(2, 200.0),
                    StaggeredTile.extent(2, 200.0),
                    StaggeredTile.extent(2, 200.0),
                  ],
                )
              ),
            onRefresh: fetchData,
          )
        : Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _buildData()
    );
  }  
}