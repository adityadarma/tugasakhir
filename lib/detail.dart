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
  List data;

  Future<String> getData() async {
    final prefs = await SharedPreferences.getInstance();
    var token = "Bearer " + prefs.getString('token');
    var link = "http://tugasakhir.kubusoftware.com/penggunaan/detail?bulan=" + widget.bulan + "&tahun=" + widget.tahun;

    var res = await http.get(Uri.encodeFull(link), headers: { 'accept':'application/json', 'Authorization':token});
    
    setState(() {
      data = json.decode(res.body);
    });
    return 'success!';
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pemakian'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: data == null ? 0:data.length,
          itemBuilder: (BuildContext context, int index) { 
            return Container(
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min, children: <Widget>[
                  ListTile(
                    // leading: Text(data[index]['tanggal'], style: TextStyle(fontSize: 30.0),),
                    title: Text(data[index]['tanggal'], style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),),
                    // trailing: Image.asset(data[index]['type'] == 'mekah' ? 'mekah.jpg':'madinah.png', width: 32.0, height: 32.0,),
                    subtitle: Column(children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('Pemakaian : ', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(data[index]['daya'].toString() + " KWh"),
                        ],
                      ),
                      // Row(
                      //   children: <Widget>[
                      //     Text('Arus : ', style: TextStyle(fontWeight: FontWeight.bold),),
                      //     Text(data[index]['arus'].toString() + " Ampere")
                      //   ],
                      // ),
                      // Row(
                      //   children: <Widget>[
                      //     Text('Daya : ', style: TextStyle(fontWeight: FontWeight.bold),),
                      //     Text(data[index]['daya'].toString() + " Watt")
                      //   ],
                      // ),
                    ],),
                  ),
                ],),
              )
            );
          },
        ),
      ),
    );
  }
}