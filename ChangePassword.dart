import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gender_selector/gender_selector.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remedium/doctor_inventory.dart';
import 'package:remedium/editprofile.dart';
import 'package:remedium/patient_inventory.dart';
import 'consultation.dart';
import 'doctor_sign_in.dart';
import 'dart:math';

final _firestore = Firestore.instance;
final _auth = Firestore.instance;
FirebaseStorage _storage = FirebaseStorage.instance;
FirebaseUser loggedInUser;

class Password extends StatelessWidget {
  File _image;
  final _auth = FirebaseAuth.instance;

  String password;
  String cpassword;
  Future inputData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    print('start');
    Firestore.instance
        .collection("Patient")
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        final patient_id = result["patient_id"];

        if (patient_id == uid) {
          Firestore.instance
              .collection('Patient')
              .document(result.documentID)
              .updateData({
            "New Password": password,
          }).then((_) {
            print("success!");
          });
        }

        ;
      });
    });
    print('end');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangePassword(),
    );
  }
}

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF202125),
      appBar: AppBar(
        backgroundColor: Color(0xFF202125),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: CupertinoColors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Password Settings"),
        shadowColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 15, right: 16),
        child: ListView(children: [
          Container(
            padding: EdgeInsets.only(left: 16, top: 150, right: 16),
            child: Center(
                child: Text(
              "Create new Password",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 2.2,
                //fontFamily: "Source Sans Pro",
              ),
            )),
          ),
          SizedBox(
            height: 50,
          ),
          TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 20),
                labelText: 'New Password',
                labelStyle: TextStyle(color: Colors.white, fontSize: 20),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onChanged: (value) {
                password = value;
              }),
          SizedBox(
            height: 40,
          ),
          TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 20),
              labelText: 'Re-enter new Password',
              labelStyle: TextStyle(color: Colors.white, fontSize: 20),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            RaisedButton(
              color: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 65),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () async {
                try {
                  StorageReference reference =
                      _storage.ref().child("patient_profile/${email}");

                  //  final newUser = await _auth.createUserWithEmailAndPassword(email: email , password: password);
                  Random random = new Random();

                  int random_number = random.nextInt(100);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => patient_inventory()),
                  );
                } catch (e) {
                  print(e);
                }
              },
              child: Text('CONFIRM PASSWORD CHANGES',
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 2.2,
                    color: Colors.white,
                  )),
            ),
          ]),
        ]),
      ),
    );
  }
}
