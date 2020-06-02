import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iot/detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Use extends StatefulWidget {
  @override
  _UseState createState() => _UseState();
}

class _UseState extends State<Use> {
  Future<List> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    var token = "Bearer " + prefs.getString('token');
    final response = await http.get(Uri.encodeFull('http://restapi-ta.kubusoftware.com/penggunaan'), headers: { 'accept':'application/json', 'Authorization':token});
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data;
    } else {
      throw Exception("failed get profiles");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: _getData(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data;
            return Container(
              child: ListView.builder(
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (BuildContext context, int index) { 
                  return Container(
                    child: Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min, children: <Widget>[
                        ListTile(
                          title: Text('Bulan : ' + data[index]['bulan_tahun'], style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),),
                          subtitle: Column(children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('Pemakaian : ', style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(data[index]['daya'].toString() + " KWh"),
                              ],
                            ),
                          ],),
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) {
                                return Detail(bulan: data[index]['bulan'], tahun: data[index]['tahun']);
                              }),
                            );
                          },
                        ),
                      ],),
                    )
                  );
                },
              ),
            ); 
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }  
}