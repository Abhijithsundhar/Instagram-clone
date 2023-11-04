import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstui/main.dart';
import 'package:firstui/sign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Authentication.dart';
import 'Shared.dart';

class Login extends StatefulWidget {
  // String? validation;
  const Login({super.key,});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisible=true;
  Firebase _auth=Firebase();

  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            right: 50,
            left: 50,
            top: 200
          ),
          child: ListView(
            children :[ Column(
              children: [Text("Login",
                  style:TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 25,) ),
                SizedBox(height: height*(0.02)),
                TextFormField(
                  textInputAction: TextInputAction.next,

                  // autofocus: true,
               // onTap: ()
               //    {
               //      // print();
               //    },
                  controller:email ,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'email',
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: height*(0.02)),
                TextField(
                  // focusNode: ,
                  controller:password,
                  obscureText: passwordVisible,
                  textInputAction: TextInputAction.next,
                  autofillHints: [AutofillHints.password],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'password',
                    labelText: 'password',

                    suffixIcon: InkWell(
                     child:  Icon(passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onTap: () {
                        setState(() {
                            passwordVisible =!passwordVisible;
                          },
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: height*(0.03),),
                InkWell(
                  onTap: (){
                    FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);

                  },
                  child: Text('Forgot password',
                  style: TextStyle(color: Colors.green[400])),
                ),
                SizedBox(height: height*(0.03)),
                ElevatedButton(
                  onPressed: () {
                    _auth.Login(context, email.text, password.text);
                  },
                  style: ElevatedButton.styleFrom(elevation: 8,
                    minimumSize: Size(width, height *(0.07)),
                    backgroundColor: Colors.green[400],
                  ),
                  child: Text("Login"),
                ),
                SizedBox(height: height*(0.03)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Doesn't have an account?",
                      style: TextStyle(fontSize: 15)),
                    ),
                    InkWell(
                      onTap: () {

                        // getuser(email: email.text, password: password.text);
                        // _auth.createUserWithEmailAndPassword(email: email.text, password: password.text);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Sign()));
                      },
                      child: Container(
                        child: Text("Sign up",
                            style: TextStyle(
                              color: Colors.green.shade500,
                              fontSize: height *(0.03),
                            )),
                      ),
                    )
                  ],
                ),
              ],
            ),
            ],
          ),
        ));
  }
}
