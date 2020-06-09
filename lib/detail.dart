import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Detail extends StatefulWidget {
  Detail({@required this.bulan, this.tahun});
  final bulan;
  final tahun;
  
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Future<List> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    var token = "Bearer " + prefs.getString('token');
    final link = "http://restapi-ta.kubusoftware.com/penggunaan/detail?bulan=" + widget.bulan + "&tahun=" + widget.tahun;
    final response = await http.get(Uri.encodeFull(link), headers: { 'accept':'application/json', 'Authorization':token});
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pemakian'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: SafeArea(
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
                return ListView.builder(
                    itemCount: data == null ? 0:data.length,
                    itemBuilder: (BuildContext context, int index) { 
                      return Container(
                        child: Card(
                          margin: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min, children: <Widget>[
                            ListTile(
                              title: Text(data[index]['tanggal'], style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),),
                              subtitle: Column(children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('Pemakaian : ', style: TextStyle(fontWeight: FontWeight.bold),),
                                    Text(data[index]['daya'].toString() + " KWh"),
                                  ],
                                ),
                              ],),
                            ),
                          ],),
                        )
                      );
                    },
                  ); 
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      )
    );
  }
}