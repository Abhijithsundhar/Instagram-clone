import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstui/home.dart';
import 'package:firstui/main.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'Authentication.dart';
import 'Shared.dart';
import 'homePage.dart';
import 'login.dart';

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {

 bool passwordVisible=true;
 bool confirmPasswordVisible=true;
 // void initState(){
 //   super.initState();
 //
 // }
 TextEditingController _name=TextEditingController();
 TextEditingController _email=TextEditingController();
 TextEditingController _phone=TextEditingController();
 TextEditingController _password=TextEditingController();
 TextEditingController _confirmPassword=TextEditingController();
 Firebase _auth=Firebase();
 FocusNode fl1=FocusNode();
 FocusNode fl2=FocusNode();
 FocusNode fl3=FocusNode();
 FocusNode fl4=FocusNode();
 FocusNode fl5=FocusNode();
 // FocusNode fl1=FocusNode();



  @override

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:  EdgeInsets.only(
            top: 30,
          left: 30,
          right: 30,
          ),
          child: SingleChildScrollView(
            child: Form(
              // key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                      height: height*0.05,
                  ),
                  TextFormField(
                    focusNode: fl1,
                    onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(fl2),
                    controller: _name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'User name',
                      labelText: 'Name',
                    ),
                  ),
                  SizedBox(height: height*(0.02)),
                  TextFormField(
                    focusNode: fl2,
                    controller: _email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'email@.com',
                      labelText: 'Email',
                    ),keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator:  (value) {
                      if(!value!.contains("@")){
                        return "Enter correct email";
                      }
                        else{
                          return null;
                          }
                    },
                  ),
                  SizedBox(height: height*(0.02)),
                  IntlPhoneField(
                    flagsButtonPadding: EdgeInsets.all(1),
                    dropdownIconPosition: IconPosition.trailing,
                    controller: _phone ,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'phone',
                      labelText: 'Phone',
                    ),initialCountryCode: 'IN',

                    // onChanged: (phone) {
                    //   print(phone.completeNumber);
                    // },
                    keyboardType: TextInputType.number,

                  ),
                  SizedBox(height: height*(0.02)),
                  TextFormField(
                    controller:_password ,
                    obscureText: passwordVisible,
                    autofillHints: [AutofillHints.password],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'password',
                      labelText: 'password',
                      suffixIcon: InkWell(
                        child: Icon(passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onTap: () {
                          setState(
                                () {
                              passwordVisible =!passwordVisible;
                            },
                          );
                        },
                      ),
                    ),

                  ),
                  SizedBox(height: height*(0.02)),
                  TextFormField(
                    controller: _confirmPassword,
                    obscureText: confirmPasswordVisible,
                    autofillHints: [AutofillHints.password],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: ' confirm password',
                      labelText: 'confirm password',
                      suffixIcon: InkWell(
                       child: Icon(confirmPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onTap: () {
                          setState(
                                () {
                                  confirmPasswordVisible =!confirmPasswordVisible;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: height*(0.05)),
                  ElevatedButton(
                    onPressed: () {
                      _auth.Signup(context, _name.text, _email.text,
                          _phone.text, _password.text, _confirmPassword);
                    },
                    style: ElevatedButton.styleFrom(elevation: 10,
                      minimumSize: Size(width, height *(0.07)),
                      backgroundColor: Colors.green[400],
                    ),
                    child: Text("Sign Up"),
                  ),
                  SizedBox(height: height*(0.02)),
                  // Divider(
                  //   color: Colors.black,
                  //   height: 25,
                  //   thickness: 2,
                  //   indent: 5,
                  //   endIndent: 5,
                  // ),

                  Text('OR',
                  style: TextStyle(
                    fontSize: 12,fontWeight: FontWeight.bold
                  )),
                  SizedBox(height: height*(0.02)),
                   InkWell(
                     onTap: () {
                       _auth.signInWithGoogle().then((value) =>
                       Navigator.push(context, MaterialPageRoute(builder: (context) =>HomePage())));
                     },
                     child: Container(
                       width:width,
                       height:height *(0.07),
                       decoration: BoxDecoration(border:
                       Border.all(color: Colors.black),
                           borderRadius:
                           BorderRadius.circular(10)),
                       child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                          Image(image: AssetImage('assets/google.png')),
                          SizedBox(width: 0.05,),
                          Text('Sign in with Google'),
                       ]),
                     ),
                   ),
                  SizedBox(height: height*(0.02)),
                  Container(
                    width:width,
                    height:height *(0.07),
                    decoration: BoxDecoration(border:
                    Border.all(color: Colors.black),
                        borderRadius:
                        BorderRadius.circular(10)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage('assets/applelogo.png')),
                          SizedBox(width: 0.05,),
                          Text('Sign in with Apple'),
                        ]),
                  ),
                  SizedBox(height: height*(0.02)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text("Already have an account?",
                        style: TextStyle(fontSize: 15)),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return Login();
                          },));
                        },
                        child: Container(
                          child: Text("Login",
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
            ),
          ),
        ),

      ),);
  }
}
