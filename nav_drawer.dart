

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remedium/ChangePassword.dart';
import 'package:remedium/doctor_sign_in.dart';
import 'editprofile.dart';
import 'main.dart';

class nav_drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(

          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(decoration: new BoxDecoration(
                color: Color(0xFF202125),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.blue,
                    blurRadius: 20.0,
                    spreadRadius: 1.0,
                  ),
                ]),
              child: DrawerHeader(
                child: Center(
                  child: Text(
                    'Remedium',
                    style: TextStyle(color: Colors.white, fontSize: 25, letterSpacing: 2.2),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Color(0xFF202125),
                    /*image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/cover.jpg'))*/
                ),
              ),
            ),
            ListTileTheme(
              iconColor: Colors.white,
              textColor: Colors.white,
              tileColor: Color(0xFF202125),
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Settings(),
                    ),
                  ),
                },
              ),
            ),

            /*ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('Profile'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.border_color),
              title: Text('Feedback'),
              onTap: () => {Navigator.of(context).pop()},
            ),*/
            ListTileTheme(
              iconColor: Colors.white,
              textColor: Colors.white,
              tileColor: Color(0xFF202125),
              child: ListTile(
                //tileColor: Colors.blueGrey,
                leading: Icon(Icons.vpn_key),
                title: Text('Change Password'),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePassword(),
                    ),
                  );
                },
              ),
            ),
            ListTileTheme(
              iconColor: Colors.white,
              textColor: Colors.white,
              tileColor: Color(0xFF202125),
              child: ListTile(
              //tileColor: Colors.blueGrey,
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: (){
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              },
            ),
            ),
            Column(
              children: [

              Container(
                width: 500,
                height: 1000,

                decoration: new BoxDecoration(
                    color: Color(0xFF202125),
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.blue,
                        blurRadius: 20.0,
                        spreadRadius: 1.0,
                      ),
                    ]),



              )
            ],)
          ],
        ),
      ),
    );
  }

}




