import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iot/login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var recentJobsRef =  FirebaseDatabase.instance.reference();
  void doLogout() async {
    Fluttertoast.showToast(
      msg: "Logout Success!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 3,
      backgroundColor: Colors.grey[400],
      textColor: Colors.white,
      fontSize: 16.0
    );

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  void dispose() {
    super.dispose();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Watt Meter"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new, size: 25.0,),
            onPressed: (){
              doLogout();
            },
          )
        ],
      ),
      body: Container(
        color: Color(0xffE5E5E5),
        child: StreamBuilder(
          stream: recentJobsRef.onValue,
          builder: (context, AsyncSnapshot<Event> snap){
            if(snap.hasData){
              Map<dynamic, dynamic> data = snap.data.snapshot.value;
              return StaggeredGridView.count(
                padding: EdgeInsets.only(top: 20.0),
                crossAxisCount: 4,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: cardItems("Tegangan",data['tegangan'].toString(),"Volt"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: cardItems("Arus",data['arus'].toString(),"Ampere"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: cardItems("Power Factor",data['faktor_daya'].toString(),""),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: cardItems("Daya",data['daya'].toString(),"Watt"),
                  ),
                ],
                staggeredTiles: [
                  StaggeredTile.extent(2, 200.0),
                  StaggeredTile.extent(2, 200.0),
                  StaggeredTile.extent(2, 200.0),
                  StaggeredTile.extent(2, 200.0),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        ),
      ),
    );
  }
}