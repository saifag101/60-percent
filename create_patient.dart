import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gender_selector/gender_selector.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remedium/doctor_inventory.dart';

import 'doctor_sign_in.dart';
import 'package:intl/intl.dart';

final _firestore = Firestore.instance;
FirebaseStorage _storage = FirebaseStorage.instance;
final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String formatted = formatter.format(now);

class create_patient extends StatefulWidget {
  @override
  _create_patientState createState() => _create_patientState();
}

class _create_patientState extends State<create_patient> {
  File _image;
  final _auth = FirebaseAuth.instance;
  String email;
  String first_name;
  String last_name;
  String age;
  String gender;
  String zip_code;
  String telephone;
  String condition;

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var _value;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new PreferredSize(
        child: new Container(
          padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: new Padding(
              padding:
              const EdgeInsets.only(left: 10.0, top: 20.0, bottom: 20.0),
              child: Row(
                children: [IconButton(

                    icon: Icon(Icons.arrow_back,color: CupertinoColors.white,),
                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => doctor_inventory()),
                      );
                    }),

                  Column(
                    children: [
                      Text("Create Patient Profile!                      ",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      Text(
                          " Fill out the form below so we can get you started.",
                          style:
                          TextStyle(fontSize: 13, color: Colors.white70)),
                    ],
                  ),
                ],
              )),
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
        child: Column(
          children: [
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Colors.blueGrey,
                child: _image != null
                    ? ClipOval(

                  //borderRadius: BorderRadius.circular(30),
                  child: Image.file(
                    _image, width: 100,
                    height: 100,
                    fit: BoxFit.cover,

                    // fit: BoxFit.contain,
                  ),
                )
                    : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50)),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                        "Personal Information                                        ",
                        style: TextStyle(
                            fontSize: 20, color: CupertinoColors.white)),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              first_name = value;
                            },
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(50.0),
                                ),
                              ),
                              filled: true,
                              hintStyle:
                              new TextStyle(color: Color(0XFFDCDDE1)),
                              hintText: "First Name",
                              fillColor: Color(0xFF3C4043),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              last_name = value;
                            },
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(50.0),
                                ),
                              ),
                              filled: true,
                              hintStyle:
                              new TextStyle(color: Color(0XFFDCDDE1)),
                              hintText: "Last Name",
                              fillColor: Color(0xFF3C4043),),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              age = value;
                            },
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(50.0),
                                ),
                              ),
                              filled: true,
                              hintStyle:
                              new TextStyle(color: Color(0XFFDCDDE1)),
                              hintText: "Age",
                              fillColor: Color(0xFF3C4043),),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: DropdownButton(
                            onChanged: (value) {
                              value == 1 ? gender = "Male" : gender = "Female";
                            },
                            hint: Text("gender"),
                            value: 1,
                            items: [
                              DropdownMenuItem(
                                child: Text("Male",style: TextStyle(color:CupertinoColors.white)),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text("Female",style: TextStyle(color:CupertinoColors.white)),
                                value: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "Contact Info                                        ",
                        style: TextStyle(fontSize: 24,color:CupertinoColors.white,)),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(50.0),
                                ),
                              ),
                              filled: true,
                              hintStyle:
                              new TextStyle(color: Color(0XFFDCDDE1)),
                              hintText: "Email",
                              fillColor: Color(0xFF3C4043),),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              zip_code = value;
                            },
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(50.0),
                                ),
                              ),
                              filled: true,
                              hintStyle:
                              new TextStyle(color: Color(0XFFDCDDE1)),
                              hintText: "Zip Code",
                              fillColor: Color(0xFF3C4043),),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(style: TextStyle(color: Colors.white),
                            onChanged: (value) {
                              telephone = value;
                            },
                            decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(50.0),
                                ),
                              ),
                              filled: true,
                              hintStyle:
                              new TextStyle(color: Color(0XFFDCDDE1)),
                              hintText: "Mobile number",
                              fillColor: Color(0xFF3C4043),),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(style: TextStyle(color: Colors.white),
                          onChanged: (value) {
                            condition = value;
                          },
                          obscureText: true,
                          decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(50.0),
                              ),
                            ),
                            filled: true,
                            hintStyle: new TextStyle(color: CupertinoColors.white),
                            hintText: "Pre-Diagnosis Condition:",
                            fillColor: Color(0xFF3C4043),),

                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            Container(
              child: RaisedButton(
                  color: Color(0XFF3C4043),
                  padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () async {
                    try {
                      StorageReference reference = _storage.ref().child("doctor_profile/${email}");

                      //Upload the file to firebase
                      StorageUploadTask uploadTask = reference.putFile(_image);
                      String url = await (await uploadTask.onComplete).ref.getDownloadURL();
                      final FirebaseUser user = await _auth.currentUser();
                      final uid = user.uid;
                      _firestore.collection('patient').add({
                        'doctor_uid': uid,
                        'first_name': first_name,
                        'email': email,
                        'last_name': last_name,
                        'age': age,
                        'gender': gender,
                        'zip_code': zip_code,
                        'telephone': telephone,
                        'condition': condition,
                        'date': formatted,
                        'image' : url,
                      });
                      StorageReference storageReference =
                      FirebaseStorage.instance.ref().child("doctor_profile/$_image");
                      print(_image);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => doctor_inventory()),
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text("Submit", style: TextStyle(color: CupertinoColors.white))),
            ),
          ],
        ),
      ),
    );
  }
}