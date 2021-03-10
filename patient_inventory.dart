import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remedium/create_patient.dart';
import 'package:remedium/nav_drawer.dart';
import 'package:remedium/patient_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'consultation.dart';
import 'recieved_result.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class patient_inventory extends StatefulWidget {
  @override
  _doctor_inventoryState createState() => _doctor_inventoryState();
}

class _doctor_inventoryState extends State<patient_inventory> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String messageText;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: nav_drawer(),
      appBar: new PreferredSize(
        child: new Container(
          padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: CupertinoColors.white,
                    ),

                      onPressed: () => _scaffoldKey.currentState.openDrawer(),
                    ),
                SizedBox(
                  width: 5,
                ),
                RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(80.0)),
                  onPressed: () {},
                  color: Color(0xFF3C4043),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    children: [
                      Text("Search for docters with name",
                          style: TextStyle(
                            color: Color(0XFFDCDDE1),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.search,
                        color: CupertinoColors.white,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                RaisedButton(
                  color: Color(0xFF3C4043),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(70.0)),
                  onPressed: () {},
                  padding: EdgeInsets.fromLTRB(1, 10, 1, 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.filter_alt_outlined,
                        color: CupertinoColors.white,
                      )
                    ],
                  ),
                ),
              ],
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
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF202125),
          ),
          child: Column(
            //    color: Color(0xFF202125),

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0XFF3C4043),
        focusColor: Colors.blue,
        focusElevation: 100,
        splashColor: CupertinoColors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => consultation()),
          );
        },
        label: Text(' consultation'),
        icon: Icon(Icons.add),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('consultation').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents;
        List<MessageBubble> messageBubbles = [];

        for (var message in messages) {
          final first_name = message.data['first_name'];
          final last_name = message.data['last_name'];
          final experience = message.data['experience'];
          final degree = message.data['degree'];
          final email = message.data['email'];
          final image = message.data['image'];
          final request=message.data['request'];
          String color;


          final uid = message.data['patient_id'];

          final currentUser = loggedInUser.uid;

          if (currentUser == uid) {
            final messageBubble = MessageBubble(
                first_name: first_name,
                last_name: last_name,
                experience: experience,
                degree: degree,
                email: email,
                image: image,
              request:request

            );

            messageBubbles.add(messageBubble);
          }
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {


  MessageBubble({this.doc_id,this.image,this.email,this.experience, this.last_name, this.degree, this.first_name, this.request, });
  final String first_name;
  final String email;
  final String last_name;
  final String experience;
  final String degree;
  final String image;
  final String doc_id;

final String request;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => recieved_result()),
        );

      },
      child: Card(
        color: Color(0XFF3E3F43),
        //elevation: 15,
        //shadowColor: Colors.blue,
        /*shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),*/
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: ${first_name}${last_name} ",style:TextStyle(color: CupertinoColors.white)),
                  Text("Degree: ${degree}",style:TextStyle(color: CupertinoColors.white)),
                  Text("Experience: ${experience}",style:TextStyle(color: CupertinoColors.white)),
                  Text("Request: ${request}",style:TextStyle(color: CupertinoColors.white)),
                  Text("Result: Awaiting",style:TextStyle(color: CupertinoColors.white)),

                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProfileAvatar(
                    image,

                    borderColor: Colors.purpleAccent,
                    borderWidth: 5,
                    elevation: 2,
                    radius: 50,
                    cacheImage: true,
                  ),
                ),
                Text("id:1233",style:TextStyle(color: CupertinoColors.white))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
