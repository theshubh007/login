import 'package:fblog1/screens/Drawer.dart';
import 'package:fblog1/screens/Drawermail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fblog1/FirebaseService.dart';

class Homepage extends StatelessWidget {
  final bool? signtype;
  Homepage({Key? key, this.signtype}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // dynamic args=ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("main page"),
      ),
      // drawer: Drawermain(userCredential: args),
      // drawer:signtype==true ? Drawermain():Drawermail(uid: this.uid,),
      drawer:signtype==true?Drawer():Drawermail(),

      body: Container(
        child: Column(
          children: [
            FloatingActionButton.extended(onPressed: (){
              FirebaseService.fbinstance.signOutFromGoogle();
              Navigator.pushNamed(context, '/');
              }

                , label: Text("logout"))
          ],
        ),

      ),
    );
  }
}
