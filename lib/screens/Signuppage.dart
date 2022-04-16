import 'package:fblog1/FirebaseService.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Homepage.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({Key? key}) : super(key: key);

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
 bool signtype=true;
  static DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Users");
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        prefixIcon:Icon(Icons.account_circle,color: Colors.white,),

                        fillColor: Colors.black.withOpacity(0.6),
                        filled: true,
                        labelText: "Enter User Name",
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
                          return 'Enter User Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  /////////////////////////
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        prefixIcon:Icon(Icons.email,color: Colors.white,),
                        fillColor: Colors.black.withOpacity(0.6),
                        filled: true,
                        labelText: "Enter Email",
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
                          return 'Enter an Email Address';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  ////////////////////////////

                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: phonecontroller,
                      decoration: InputDecoration(
                        prefixIcon:Icon(Icons.phone,color: Colors.white,),
                        fillColor: Colors.black.withOpacity(0.6),
                        filled: true,
                        labelText: "Enter phone",
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
                          return 'Enter phone';
                        }
                        return null;
                      },
                    ),
                  ),
                  ///////////////////////


                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: passcontroller,
                      decoration: InputDecoration(
                        prefixIcon:Icon(Icons.key,color: Colors.white,),

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
                  ////////////////////////////

                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                          registerNewUser();
                        }
                      },
                      child: Text('Submit'),
                    ),
                  )

                ],
              ),
            ),

          )),
    );
  }


  void registerNewUser() async {
    auth.createUserWithEmailAndPassword(
    email: emailcontroller.text, password: passcontroller.text)
        .then((result) {
    dbRef.child(result.user!.uid).set({
    "email": emailcontroller.text,
    "age": phonecontroller.text,
    "name": namecontroller.text,
      "pass":passcontroller.text,
    }).then((res) {
     setState(() {
       signtype=false;
     });
    Navigator.pushNamed(context, "/");
    });
    }).catchError((err) {

 displayToastMsg(err.message, context);
    });
    }




    



  displayToastMsg(String masg,BuildContext context){
    Fluttertoast.showToast(msg: masg);
  }


  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    emailcontroller.dispose();
    passcontroller.dispose();
    phonecontroller.dispose();
  }}

