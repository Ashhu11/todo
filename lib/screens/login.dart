import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:todo/screens/sign_in.dart';
import 'package:todo/home.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late User fuGoogle;
  int personal = 0;
  int business = 0;

  taskno() async {
    var doc = await FirebaseFirestore.instance
        .collection('taskno')
        .doc("TXiEEzPm7T5bdPaqL69b")
        .get();
    if (doc.exists) {
      // Replace field by the field you want to check.
      var valueOfField = doc.get("personal");
      var valueOfField1 = doc.get("business");
      setState(() {
        personal = valueOfField;
        business = valueOfField1;
      });

      print(valueOfField.toString());
    }
  }

  createUserInFireStore(user, String loginType) async {
    try {
      print('createUserInFireStore starts here');

      circularProgress(context, "Please Wait", true);
      print("user data");
      print(user);
      print(user.uid);
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        "createddate": DateTime.now(),
        "email": user.email,
        "userid": user.uid,
        "name": user.displayName,
      });

      circularProgress(context, '', false);
      return user.uid;
    } catch (e) {
      circularProgress(context, '', false);
      print(e);
    }
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Do you want to exit?"),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('yes selected');
                            exit(0);
                          },
                          child: Text("Yes"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurpleAccent),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          print('no selected');
                          Navigator.of(context).pop();
                        },
                        child:
                            Text("No", style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    taskno();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showExitPopup(context);
      },
      child: Material(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/splash.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Container(),
              ),
              Expanded(
                flex: 10,
                child: Column(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'To-Do ',
                            style: TextStyle(
                                fontSize: 33,
                                fontFamily: "BalooBhai2",
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextSpan(
                            text: '\nPlan your day ahead!',
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: GestureDetector(
                        onTap: () async {
                          try {
                            //login with google
                            User newUser = await loginWithGmail();
                            print(newUser);
                            if (newUser != null) {
                              print('new not null');
                              circularProgress(context, "Signing In", true);
                              DocumentSnapshot doc = await FirebaseFirestore
                                  .instance
                                  .collection('users')
                                  .doc(newUser.uid)
                                  .get();
                              print('printing doc');
                              print(doc.data());
                              if (doc.data() == null) {
                                print('doc data null');
                                circularProgress(context, "Signing In", false);
                                String newUserID = await createUserInFireStore(
                                    newUser, "GMAIL");
                                if (newUserID != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                  );
                                }
                              } else {
                                print('doc data not null');
                                circularProgress(context, "Signing In", false);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()),
                                );
                              }
                            }
                          } catch (e) {
                            print(e.toString());
                            // checkException(id, e.toString(), "userlogin.dart", "Google_login", "Register failed due to error in Google Login");
                            // exceptionFlushBar(
                            //     "Something when wrong!Please contact support@cashmypic.com",context);
                          }
                        },
                        child: Container(
                          width: 314,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color(0xffbdbdbd),
                              width: 1,
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(40, 0, 63, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset('assets/google.svg'),
                                Text(
                                  "Continue with Google",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "BalooBhai2",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  width: 300,
                  child: Text(
                    "By signing up, you are agree to our Terms & Conditions and Privacy Policy.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 10,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<User> loginWithGmail() async {
    final api = await SignInAPI.signInWithGoogle();
    fuGoogle = api.firebaseUser!;
    return fuGoogle;
  }
}
