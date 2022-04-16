import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fblog1/FirebaseService.dart';

class Drawermain extends StatefulWidget {
  // UserCredential? userCredential;
  // Drawermain({this.userCredential});

  @override
  State<Drawermain> createState() => _DrawermainState();
}

class _DrawermainState extends State<Drawermain> {
  User? user=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return  Drawer(
        child:Column(
        children: [
        DrawerHeader(
        child: CircleAvatar(
          radius: 80,
        //  backgroundImage: NetworkImage(widget.userCredential!.user!.photoURL.toString()),
          backgroundImage: NetworkImage(user!.photoURL!),
        ),
       padding: EdgeInsets.all(20),
    ),


    // Text("Name:  ${widget.userCredential!.user!.displayName}", style: TextStyle(fontSize: 18),),
     Text("Name:  ${user!.displayName}", style: TextStyle(fontSize: 18),),
    Text("Name:  ${user!.displayName}", style: TextStyle(fontSize: 18),),
    Text("Email  ${user!.email}",style: TextStyle(fontSize: 18),),
    ],
    ));
  }
  }










