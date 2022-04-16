import 'package:fblog1/screens/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Drawermail extends StatefulWidget {
  const Drawermail({Key? key}) : super(key: key);

  // final String? uid;
// Drawermail({this.uid});

  @override
  State<Drawermail> createState() => _DrawermailState();
}


class _DrawermailState extends State<Drawermail> {
  User? user=FirebaseAuth.instance.currentUser;
 var vvd;


  // Future<DatabaseEvent> dbRef = FirebaseDatabase.instance.ref().child("Users").child(vvd!).once();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Name: ${user!.email}"),
            ],
          ),
        ],
      ),
    );
  }



}



