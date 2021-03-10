import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remedium/create_patient.dart';
import 'package:remedium/nav_drawer.dart';
import 'package:remedium/patient_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'doctor_inventory.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;


class doctor_message extends StatefulWidget {
  @override
  _doctor_messageState createState() => _doctor_messageState();
}

class _doctor_messageState extends State<doctor_message> {

  final _auth = FirebaseAuth.instance;



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

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: new PreferredSize(
        child: new Container(

          padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [IconButton(


                icon: Icon(Icons.arrow_back_rounded,color: CupertinoColors.white,),
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>doctor_inventory()),
                    );
                  }
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Patient Requests",style:TextStyle(fontSize: 25,color:CupertinoColors.white,

                ),),


              ],
            ),
          ),
          decoration: new BoxDecoration(
              color: Color(0xFF202125),
              boxShadow: [
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
        backgroundColor:Color(0XFF3C4043),
        focusColor: Colors.blue,
        focusElevation: 100,
        splashColor: CupertinoColors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => create_patient()),
          );
        },
        label: Text('Add Patient'),
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
          final patient_first_name = message.data['patient_first_name'];
          final patient_last_name = message.data['patient_last_name'];
          final patient_date = message.data['patient_date'];

          final patient_gender = message.data['patient_gender'];
final doc_id =message.documentID;
final request=message.data['request'];

          final email = message.data['email'];
          // message.data['result']="negative";
          //String result = message.data['result'];
          String image = message.data['patient_image'];
          //  print("result is : ${result}");
          String color;

          final currentUser = loggedInUser.email;

          if(currentUser ==email && request=="awaiting"){
            final messageBubble = MessageBubble(
              image: image,
              last_name: patient_last_name,
              gender: patient_gender,
              date: patient_date,
                first_name:patient_first_name,
              doc_id:doc_id

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
  MessageBubble({this.image, this.first_name, this.gender, this.date, this.last_name, this.doc_id, });

  final String first_name;
  final String last_name;
  final String gender;
  final String date;
  final doc_id;

  final String image;


  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: null,
      child: Card(
        color: Color(0XFF3E3F43),
       /* elevation: 15,
        shadowColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),*/
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: ${first_name} ${last_name}",style:TextStyle(color: CupertinoColors.white)),
                  Text("Gender: ${gender}",style:TextStyle(color: CupertinoColors.white)),
                  Text("Date: ${date}",style:TextStyle(color: CupertinoColors.white)),
                  SizedBox(height:5),
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      MaterialButton(onPressed: (){


                        Firestore.instance
                            .collection('consultation')
                            .document(doc_id)
                            .updateData({
                          "request": "accepted"
                        });
                      },
                      padding: EdgeInsets.all(2),

                      child: Card(color:Colors.green,child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("ACCEPT",style:TextStyle(color: CupertinoColors.white)),
                      )),),

                      MaterialButton(onPressed: (){


                        Firestore.instance
                            .collection('consultation')
                            .document(doc_id)
                            .updateData({
                          "request": "rejected"
                        });
                      },
                        padding: EdgeInsets.all(2),
                        child: Card(color:Colors.red,child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("REJECT",style:TextStyle(color: CupertinoColors.white)),
                        )),
                      ),


                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                CircularProfileAvatar(
                  image,
                  //child: FlutterLogo(),
                  cacheImage: true,
                  borderColor: Colors.purpleAccent,
                  borderWidth: 5,
                  elevation: 2,
                  radius: 50,
                ),
                Text("id:",style:TextStyle(color: CupertinoColors.white))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
