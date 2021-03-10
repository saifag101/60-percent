
import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remedium/covid.dart';
import 'package:remedium/patient_profile.dart';

final _firestore = Firestore.instance;
class report_generate extends StatefulWidget {
  final doc_id;
  report_generate({this.doc_id});
  @override
  _report_generateState createState() => _report_generateState(doc_id: doc_id);
}

class _report_generateState extends State<report_generate> {
  _report_generateState({this.doc_id});
  final String doc_id;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:
      new PreferredSize(

        child: new Container(
          padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: new Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 20.0, bottom: 20.0),
            child: Center(
              child: Row(

                children: [
                  IconButton(

                      icon: Icon(Icons.arrow_back,color: CupertinoColors.white,),
                      onPressed: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => patient_profile(doc_id: doc_id,)),
                        );
                      }),


                  new Text(
                    'ONE MORE STEP TO GO!',
                    style: new TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white, ),
                  ),
                ],
              ),
            ),
          ),
          decoration: new BoxDecoration(
              color: Color(0xFF202125),
              boxShadow: [
                new BoxShadow(
                  color: Colors.blueGrey,
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
        //print(recieved);
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
          date = message.data['date'];
          result = message.data['result'];

          if(result==null) {
            result="pending";
            colour =Colors.yellowAccent;
          }
          if(result=="0 negative") {
            colour= Colors.green ;
          }
          if(result=="1 positive")colour= Colors.red;







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
            //print(recieved);
            for (var message in messages) {


              if(message.documentID== doc_id)
              {  email = message.data['_patient_email'];
              first_name =message.data['_patient_first_name'];
              last_name =message.data['_patient_last_name'];
              gender = message.data['_patient_gender'];
              condition = message.data['_patient_condition'];
              //final date = message.data['date'];
              telephone = message.data['_patient_telephone'];
              age = message.data['_patient_age'];
              date = message.data['_patient_date'];
              result = message.data['_patient_result'];

              if(result==null) {
                result="pending";
                colour =Colors.yellowAccent;
              }
              if(result=="0 negative") {
                colour= Colors.green ;
              }
              if(result=="1 positive")colour= Colors.red;







              }
            }

            return Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF202125),
                ),
                child: Column(
                  children: [
                    Card( color: Color(0XFF3E3F43),
                      elevation: 10,


                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 15),

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
                                          child: Text("First Name: ${first_name}",style:TextStyle(color:CupertinoColors.white),)
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text("Last Name: ${last_name}",style:TextStyle(color:CupertinoColors.white),)
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text("Gender: ${gender}",style:TextStyle(color:CupertinoColors.white),)
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text("Age: ${age}",style:TextStyle(color:CupertinoColors.white),)
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
                                          child: Text("Email: ${email}",style:TextStyle(color:CupertinoColors.white),)
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text("Phone #: ${telephone}",style:TextStyle(color:CupertinoColors.white),)
                                      ),
                                    ),

                                  ],
                                ),
                                Row(children: [
                                  Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text("Result: ${result}",style:TextStyle(color:CupertinoColors.white),)
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),

                    Card(elevation: 10,
                      color: Color(0XFF3E3F43),


                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Row(
                          children: [
                            SizedBox(width: 30,),
                            Text("Select X-Ray image for Diagnosis",style:TextStyle(color:CupertinoColors.white)),
                            SizedBox(width: 30,),
                            Card(
                              color: Colors.blueGrey,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),

                              child: IconButton(

                                  icon: Icon(Icons.add_a_photo_sharp,color: CupertinoColors.white,),
                                  onPressed: () {

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => covid(doc_id: doc_id)),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),

                    ),

                    Container(
                      child: RaisedButton(
                          color: Color(0XFF3C4043),
                          padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          onPressed: () {


                            /*   Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context)),
                        );*/

                          },
                          child: Text("Send Report", style: TextStyle(color: CupertinoColors.white))),
                    ), ],
                ),

              ),
            );
          },
        );
      },
    );
  }


}