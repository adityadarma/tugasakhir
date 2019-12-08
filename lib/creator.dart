import 'package:flutter/material.dart';

class Creator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        // child: Card(
          child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),

                // Photo Profil
                Image(image: AssetImage('assets/creator.jpg'),),
                SizedBox(height: 20.0),

                // Judul Tugas Akhir
                Text(
                  'JUDUL TUGAS AKHIR',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontFamily: "Serif", height: 1.0,),
                ),
                SizedBox(height: 5.0),
                Text(
                  'MENGONTROL DAN MONITORING SMART HOME MENGGUNAKAN RASPBERRY PI (MEMORI) BERBASIS ANDROID SEBAGAI MEDIA PEMBELAJARAN IOT',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontFamily: "Serif", height: 1.0,),
                ),
                SizedBox(height: 10.0),

                // Nama Pembuat
                Text(
                  'I Putu Hari Aditya Darma',
                  style: TextStyle(fontSize: 16, fontFamily: "Serif", height: 1.0,),
                ),
                Text(
                  '16102901',
                  style: TextStyle(fontSize: 16, fontFamily: "Serif", height: 1.0,),
                ),
                SizedBox(height: 10.0),

                // Nama Dosen Pembimbing I
                Text(
                  'Dosen Pembimbing I',
                  style: TextStyle(fontSize: 16, fontFamily: "Serif", height: 1.0,),
                ),
                Text(
                  'Anak Agung Gde Ekayana.M.pd',
                  style: TextStyle(fontSize: 16, fontFamily: "Serif", height: 1.0,),
                ),
                SizedBox(height: 10.0),

                // Nama Dosen Pembimbing II
                Text(
                  'Dosen Pembimbing II',
                  style: TextStyle(fontSize: 16, fontFamily: "Serif", height: 1.0,),
                ),
                Text(
                  'I Gusti Made Ngurah Desnanjaya,S.T.,M.T',
                  style: TextStyle(fontSize: 16, fontFamily: "Serif", height: 1.0,),
                ),
                SizedBox(height: 10.0),
            ]
          ),
        // )
      ),
    );
  }
}