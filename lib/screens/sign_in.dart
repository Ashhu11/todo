import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:google_sign_in/google_sign_in.dart';

class SignInAPI {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();

  User? firebaseUser;
  Exception? error;

  SignInAPI(User user) {
    this.firebaseUser = user;
  }


  //sign in with google
  static Future<SignInAPI> signInWithGoogle() async {
    User? user;
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authuser =
          await _auth.signInWithCredential(authCredential);

      user = authuser.user;

      assert(user?.email != null);
      //assert(user.displayName != null);

      assert(await user?.getIdToken() != null);

      final User? currentUser = _auth.currentUser;

      assert(user?.uid == currentUser?.uid);
    } catch (e) {
      print(e);

    }
    return SignInAPI(user!);
  }


  //signout
  static Future<void> signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    // if user is signed in with google,
    await auth.signOut();
  }
}



//loader
circularProgress(context, msgText, isLoad) {
  if (isLoad) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Center(
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.white,
                elevation: 10,
                child: Container(
                  width: 200,
                  height: 200,
//                  width: MediaQuery.of(context).size.width / 2,
//                  height: 100,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SpinKitRing(
                        color: Colors.deepPurpleAccent,
                        size: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
//                      textBoxCustom(
//
//                          msgText,
//                          16.0,
//                          Theme.of(context).primaryColorDark,
//                          FontWeight.normal),
                      Text(msgText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.normal)),
                    ],
                  )),
                ),
              ),
            ));
  } else
    Navigator.pop(context);
}
