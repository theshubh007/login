

import 'package:fblog1/screens/Homepage.dart';
import 'package:fblog1/screens/Signuppage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../FirebaseService.dart';


class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool isLoading = false;
  bool signtype = true;
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();


  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Form(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.2,),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: emailcontroller,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email,color: Colors.white,),

                            fillColor: Colors.black.withOpacity(0.6),
                            filled: true,
                            labelText: "Enter Email Address",
                            labelStyle: TextStyle(color: Colors.white,
                                fontSize: 16.0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style:
                          TextStyle(fontSize: 20.0, color: Colors.white),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Email Address';
                            } else if (!value.contains('@')) {
                              return 'Please enter a valid email address!';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: TextFormField(
                          obscureText: true,
                          controller: passcontroller,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.key,color: Colors.white,),

                            fillColor: Colors.black.withOpacity(0.6),
                            filled: true,
                            labelText: "Enter Password",
                            labelStyle: TextStyle(color: Colors.white,
                                fontSize: 16.0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style:
                          TextStyle(fontSize: 20.0, color: Colors.white),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Password';
                            } else if (value.length < 6) {
                              return 'Password must be atleast 6 characters!';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: 120,
                          child: FloatingActionButton.extended(
                            onPressed: () async {
                              Signinr(context);
                            },
                            label: Text("Login"),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: 120,
                          child: FloatingActionButton.extended(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signuppage()),
                              );
                            },
                            label: const Text("Signup"),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,),
                        ),
                      ),


                    ],

                  )),
            ),

            // SizedBox( height: 20,),
            Padding(
              padding: const EdgeInsets.all(20),

              child: Center(
                child: FloatingActionButton.extended(
                  onPressed: () async {
                    // FirebaseService service = new FirebaseService();
                    UserCredential? usercredential = await FirebaseService
                        .fbinstance.signInWithGoogle();
                    FirebaseService.fbinstance.insert({
                      'uid': usercredential.user!.uid,
                      'name': usercredential.user!.displayName,
                      'email': usercredential.user!.email,
                    });
                    print("UID: ${usercredential.user!.uid}");
                    print("UID: ${usercredential.user!.email}");
                    print("UID: ${usercredential.user!.displayName}");
                    Navigator.pushNamed(
                        context, "homepage", arguments: usercredential);
                    //Navigator.of(context,rootNavigator:true).pushNamed("homepage");
                  },
                  icon: Image.asset(
                    'images/google.png', height: 32, width: 32,),
                  label: Text("sign in with google"),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }


  Future<void> Signinr(BuildContext context) async {

     auth.signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passcontroller.text.trim(),
      ).then((cd) {
        setState(() {
          signtype = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>
              Homepage(signtype: signtype)),
        );
        print(signtype);
      }).catchError((err) {
        displayToastMsg(err.message, context);
      }
      );
    }

    /*try {
      auth.signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passcontroller.text.trim(),
      ).then((cd) {
        setState(() {
          signtype = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>
              Homepage(signtype: signtype)),
        );
        print(signtype);
      });
      }

    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        displayToastMsg('No user found for that email.',context);
      } else if (e.code == 'wrong-password') {
        displayToastMsg('Wrong password provided for that user.',context);
      }
    }*/


    displayToastMsg(String masg, BuildContext context) {
      Fluttertoast.showToast(msg: masg);
    }
  }


