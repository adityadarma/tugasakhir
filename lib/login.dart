import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iot/home.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = new GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();
  bool isLoading = false;

  Future<void> doLogin() async {
    setState(() {
      isLoading = true;
    });

    try{
      AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
      FirebaseUser user = result.user;

      if(user != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
      }       
    }catch(e){
      setState(() {
        isLoading = false;
      }); 
      print(e.message);
    }

    // Fluttertoast.showToast(
    //   msg: "Email or Password is wrong!!",
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   timeInSecForIos: 3,
    //   backgroundColor: Colors.grey[400],
    //   textColor: Colors.white,
    //   fontSize: 16.0
    // );

    setState(() {
      isLoading = false;
    }); 
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
