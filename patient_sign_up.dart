import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gender_selector/gender_selector.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remedium/doctor_inventory.dart';
import 'package:remedium/patient_inventory.dart';
import 'consultation.dart';
import 'doctor_sign_in.dart';
import 'dart:math';

final _firestore = Firestore.instance;
FirebaseStorage _storage = FirebaseStorage.instance;
class patient_sign_up extends StatefulWidget {
  @override
  _doctor_sign_upState createState() => _doctor_sign_upState();
}

class _doctor_sign_upState extends State<patient_sign_up> {
  File _image;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String first_name;
  String last_name;
  String age;
  String gender;
  String zip_code;
  String telephone;

  String previous_illness;
  String symptoms;

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

  /* Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('doctor_profile/${_image.path}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
  }
*/

  @override
  Widget build(BuildContext context) {
    var _value;
    String _uploadedFileURL;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new PreferredSize(
        child: new Container(
          padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: new Padding(
              padding:
                  const EdgeInsets.only(left: 30.0, top: 20.0, bottom: 20.0),
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
                          MaterialPageRoute(
                              builder: (context) => doctor_sign_in()),
                        );
                      }),
                  Column(
                    children: [
                      Text("Let\'s get you set up!                      ",
                          style: TextStyle(
                              fontSize: 20, color: CupertinoColors.white)),
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
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF202125),
          ),
          child: ListView(
            children: [
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
                            child: TextField(
                              style: TextStyle(color: Colors.white),
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
                            child: TextField(
                              style: TextStyle(color: Colors.white),
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
                                fillColor: Color(0xFF3C4043),
                              ),
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
                            child: TextField(
                              style: TextStyle(color: Colors.white),
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
                                fillColor: Color(0xFF3C4043),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: DropdownButton(
                              iconDisabledColor: Color(0xFF3C4043),
                              onChanged: (value) {
                                value == 1
                                    ? gender = "male"
                                    : gender = "female";
                              },
                              hint: Text("gender"),
                              value: 1,
                              items: [
                                DropdownMenuItem(
                                  child: Text("Male"),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text("Female"),
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
                          style: TextStyle(
                              fontSize: 24, color: CupertinoColors.white)),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              onChanged: (value) {
                                password = value;
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
                                hintText: "Password",
                                fillColor: Color(0xFF3C4043),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextField(
                              style: TextStyle(color: Colors.white),
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
                                fillColor: Color(0xFF3C4043),
                              ),
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
                            child: TextField(
                              style: TextStyle(color: Colors.white),
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
                                fillColor: Color(0xFF3C4043),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextField(
                              style: TextStyle(color: Colors.white),
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
                                hintText: "Telephone",
                                fillColor: Color(0xFF3C4043),
                              ),
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
                          "Medical History                                       ",
                          style: TextStyle(
                              fontSize: 24, color: CupertinoColors.white)),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              onChanged: (value) {
                                previous_illness = value;
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
                                hintText: "Previous ilness",
                                fillColor: Color(0xFF3C4043),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    symptoms = value;
                  },
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(color: Color(0XFFDCDDE1)),
                    hintText: "Symptoms",
                    fillColor: Color(0xFF3C4043),
                  ),
                ),
              ),
              Container(
                child: RaisedButton(
                    color: Color(0XFF3C4043),
                    padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: () async {
                      StorageReference reference = _storage.ref().child("patient_profile/${email}");

                      //Upload the file to firebase
                      StorageUploadTask uploadTask = reference.putFile(_image);
                      String docUrl = await (await uploadTask.onComplete).ref.getDownloadURL();



                      Random random = new Random();
                      int random_number = random.nextInt(100);


                      try {
                        final newUser =
                        await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                        _firestore.collection('Patient').add({
                          'first_name': first_name,
                          'email': email,
                          'last_name': last_name,
                          'age': age,
                          'gender': gender,
                          'zip_code': zip_code,
                          'telephone': telephone,
                          'Previous illness': previous_illness,
                          'Symptoms': symptoms,
                          'password': password,
                          'unique_id': random_number,
                          'image': docUrl,
                          'patient_id': newUser.uid,
                        });


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
                    child:
                        Text("Submit", style: TextStyle(color: Colors.white))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
