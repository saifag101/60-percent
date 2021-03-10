import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remedium/patient_profile.dart';
import 'package:remedium/report_generate.dart';
import 'package:tflite/tflite.dart';



final _firestore = Firestore.instance;


class covid extends StatefulWidget {
  final doc_id;

  covid({this.doc_id});
  @override
  _covidState createState() => _covidState(doc_id:doc_id);
}

class _covidState extends State<covid> {
  _covidState({this.doc_id,});
  final String doc_id;
  List _outputs;
  File _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  new PreferredSize(
        child: new Container(
          //padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          padding:  EdgeInsets.all(30),
          child: Row(

            children: [
              IconButton(

                  icon: Icon(Icons.arrow_back,color: CupertinoColors.white,),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => report_generate(doc_id: doc_id,
                        ),),
                    );

                  }),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text("Covid-19 X-Ray Image Diagnosis",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ],
          ),
          decoration: new BoxDecoration(

              color: Color(0xFF202125),

              boxShadow: [
                new BoxShadow(
                  color: Colors.blue,
                  blurRadius: 20.0,
                  spreadRadius: 1.0,
                ),
              ]
          ),
        ),
        preferredSize: new Size(MediaQuery.of(context).size.width, 65.0),
      ),
      body: _loading
          ? Container(
        decoration: const BoxDecoration(
          color: Color(0xFF202125),
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          : Container(
        decoration: const BoxDecoration(
          color: Color(0xFF202125),
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null ? Container() : Image.file(_image),
            SizedBox(
              height: 20   ,
            ),
            _outputs != null
                ? Column(
                  children: [
                    Text(
              "${_outputs[0]["label"]}",
              style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 20.0,

              ),
            ),RaisedButton(
                      color: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      onPressed: (){
                        String result;
                        if(_outputs[0]["label"]=="1 positive") {
                                  result = "Positve";
                                }
                        if(_outputs[0]["label"]=="0 negative")
                           result="Negative";
                        print("doc_id :${doc_id}");
                        Firestore.instance
                            .collection('patient')
                            .document(doc_id)
                            .updateData({
                          "result":result
                        });
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => report_generate(doc_id: doc_id,
                            ),),
                      );},
                      child: Text("Return to report creation",style:TextStyle(color:CupertinoColors.white)),
                    ),
                  ],
                )
                : Container(
              decoration: const BoxDecoration(
                color: Color(0xFF202125),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: pickImage,
        child: Icon(Icons.image),
      ),
    );
  }

  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}

