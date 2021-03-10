import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remedium/patient_inventory.dart';
import 'consultation.dart';
import 'doctor_inventory.dart';
import 'patient_sign_up.dart';
import 'doctor_sign_up.dart';
import 'patient_sign_in.dart';
import 'main.dart';

class patient_sign_in extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new PreferredSize(
        child: new Container(
          padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: new Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 20.0, bottom: 20.0),
            child: Center(
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: CupertinoColors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                        );
                      }),
                  SizedBox(
                    width: 90,
                  ),
                  new Text(
                    'Remedium',
                    style: new TextStyle(
                        fontSize: 23.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          decoration: new BoxDecoration(color: Color(0xFF202125), boxShadow: [
            new BoxShadow(
              color: Colors.blue,
              blurRadius: 20.0,
              spreadRadius: 1.0,
            ),
          ]),
        ),
        preferredSize: new Size(MediaQuery.of(context).size.width, 80.0),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF202125),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Patient",
                      style: TextStyle(fontSize: 25, color: Colors.white))),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  style: TextStyle(color: Colors.white),

                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  // obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF3C4043),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                    ),
                    hintStyle: new TextStyle(color: Color(0XFFDCDDE1)),
                    hintText: "Email",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF3C4043),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                    ),
                    hintStyle: new TextStyle(color: Color(0XFFDCDDE1)),
                    hintText: "Password",
                  ),
                ),
              ),
              RaisedButton(
                  color: Color(0XFF3C4043),
                  padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () async {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => doctor_inventory()),
                    );
                    */
                    try {
                      final newUser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      final FirebaseUser user = await _auth.currentUser();
                      final uid = user.uid;

                      if (newUser != null)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => patient_inventory()),
                        );
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text("Login",
                      style: TextStyle(color: CupertinoColors.white))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: null,
                    child: Text(
                      "forgot_password",
                      style: TextStyle(color: CupertinoColors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => patient_sign_up()),
                      );
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(color: CupertinoColors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
