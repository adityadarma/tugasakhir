import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:iot/mainpage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = new GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();
  bool isLoading = false;
  bool failed = true; 

  Future<void> doLogin() async {
    try{
      setState(() {
        isLoading = true;
      });

      final prefs = await SharedPreferences.getInstance();
      await http.post(
      Uri.encodeFull('http://restapi-ta.kubusoftware.com/login'),
      body: {'email': email.text, 'password': password.text},
      headers: {"Accept": "application/json"})
      .then((response) async {
        var data = json.decode(response.body);
        print(data);
        if(response.statusCode == 200){
          setState(() {
            prefs.setBool('login', true);
            prefs.setString('token', data['data']['token']);
            Fluttertoast.showToast(
              msg: "Authentication Success!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 3,
              backgroundColor: Colors.grey[400],
              textColor: Colors.white,
              fontSize: 16.0
            );
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
          });
        }else if(response.statusCode == 401){
          Fluttertoast.showToast(
            msg: data['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 3,
            backgroundColor: Colors.red[400],
            textColor: Colors.white,
            fontSize: 16.0
          );
        }
        setState(() {
          isLoading = false;
        }); 
      });
    }catch(e){
      setState(() {
        isLoading = false;
      }); 
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: new Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              //logo
              Hero(
                tag: 'hero',
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 48.0,
                  child: Image.asset('assets/logo.png'),
                ),
              ),
              SizedBox(height: 48.0),

              //email
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Input Email';
                  }
                  return null;
                },
                controller: email,
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Email',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(height: 8.0),

              //password
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Input Password';
                  }
                  return null;
                },
                controller: password,
                autofocus: false,
                obscureText: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Password',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(height: 4.0),

              //loginButton
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                        ),
                      )
                    : RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text(
                          "Log In",
                          style: TextStyle(fontSize: 15.0),
                        ),
                        onPressed: () {
                          doLogin();
                        },
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
