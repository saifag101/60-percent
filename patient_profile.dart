
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


import 'package:remedium/doctor_inventory.dart';
import 'package:remedium/report_generate.dart';


import 'doctor_sign_in.dart';

final _firestore = Firestore.instance;


class patient_profile extends StatefulWidget {
  final doc_id;
  patient_profile({this.doc_id});

  @override
  _patient_profileState createState() => _patient_profileState(doc_id: doc_id);
}

class _patient_profileState extends State<patient_profile> {
  final _auth = FirebaseAuth.instance;
  _patient_profileState({this.doc_id});
  final String doc_id;



  @override
  Widget build(BuildContext context) {
    var _value;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                Text("Patient Profile",style:TextStyle(fontSize: 25,color:CupertinoColors.white,

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            MessagesStream(doc_id: doc_id),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor:Color(0XFF3C4043),
        focusColor: Colors.blue,
        focusElevation: 100,
        splashColor: CupertinoColors.white,
        onPressed: () {
          //print(doc_id);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => report_generate(doc_id: doc_id,)),
          );
        },
        label: Text('Create Report'),
        icon: Icon(Icons.add),

      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  MessagesStream({this.doc_id});


  final String doc_id;

  String email;
  String first_name;
  String last_name;
  String gender;
  String condition;
  String telephone;
  String result;
  String age;
  String date;
  Color colour;
  String image;


  @override
  Widget build(BuildContext context) {


    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('patient').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents;
        // List<MessageBubble> messageBubbles = [];

        for (var message in messages) {

          if(message.documentID== doc_id)
          {  email = message.data['email'];
          first_name =message.data['first_name'];
          last_name =message.data['last_name'];
          gender = message.data['gender'];
          condition = message.data['condition'];
          //final date = message.data['date'];
          telephone = message.data['telephone'];
          age = message.data['age'];
          image = message.data['image'];
          date = message.data['date'];
          result = message.data['result'];


          if(result==null) {
            result="pending";
            colour =Colors.yellowAccent;
          }
          if(result=="negative") {
            colour= Colors.green ;
          }
          if(result=="positive")colour= Colors.red;




          final currentUser = loggedInUser.email;



          }
        }

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
            // List<MessageBubble> messageBubbles = [];

            for (var message in messages) {

              if(message.documentID== doc_id)
              {  email = message.data['patient_email'];
              first_name =message.data['patient_first_name'];
              last_name =message.data['patient_last_name'];
              gender = message.data['patient_gender'];
              condition = message.data['patient_condition'];
              //final date = message.data['date'];
              telephone = message.data['patient_telephone'];
              age = message.data['patient_age'];
              image = message.data['patient_image'];
              date = message.data['patient_date'];
              result = message.data['patient_result'];


              if(result==null) {
                result="pending";
                colour =Colors.yellowAccent;
              }
              if(result=="negative") {
                colour= Colors.green ;
              }
              if(result=="positive")colour= Colors.red;




              final currentUser = loggedInUser.email;



              }
            }

            return Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF202125),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Card(


                              color: Color(0XFF3E3F43),
                              elevation: 10,
                              //shadowColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Row(

                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(40.0),
                                    child: CircularProfileAvatar(
                                      image,
                                      child: FlutterLogo(),
                                      cacheImage: true,
                                      borderColor: Colors.purpleAccent,
                                      borderWidth: 5,
                                      elevation: 2,
                                      radius: 50,
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(30, 10, 10, 20),
                                    child: Card(

                                      color: Color(0XFF3E3F43),
                                      // elevation: 50,

                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("Name : ",style:TextStyle(color: Colors.white70),),
                                              Text("${first_name} ${last_name}",style:TextStyle(color: CupertinoColors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Gender : ",style:TextStyle(color: Colors.white70),),
                                              Text("${gender}",style:TextStyle(color: CupertinoColors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Age : ",style:TextStyle(color: Colors.white70),),
                                              Text("${age}",style:TextStyle(color: CupertinoColors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                            ],
                                          ),

                                        ],
                                      ),

                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30,),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Card(

                                color: Color(0XFF3E3F43),
                                elevation: 10,

                                //shadowColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Column(

                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("Email : ",style:TextStyle(color: Colors.white70),),
                                              Text("${email}",style:TextStyle(color: CupertinoColors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                            ],
                                          ),
                                          Row
                                            (
                                            children: [
                                              Text("Phone : ",style:TextStyle(color: Colors.white70),),
                                              Text("${telephone}",style:TextStyle(color: CupertinoColors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("Date : ",style:TextStyle(color: Colors.white70),),
                                              Text("${date}",style:TextStyle(color: CupertinoColors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                            ),

                            Column(

                              children: [
                                Text("Pre-Diagnosis Condition: ",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: CupertinoColors.white),),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Card(

                                color: Color(0XFF3E3F43),
                                elevation: 10,

                                //shadowColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text("${condition}",style:TextStyle(fontSize: 18,color: CupertinoColors.white)),
                                ),

                              ),
                            ),
                            SizedBox(height: 30,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("STATUS: ",style:TextStyle(fontSize: 20,color: CupertinoColors.white) ),
                                    Text("${result}",style:TextStyle(fontSize: 20,color: colour) ),
                                  ],
                                )
                              ],
                            ),


                          ],
                        ),
                      ),
                    ],
                  ),
                )
            );
          },
        );
      },
    );
  }


}
