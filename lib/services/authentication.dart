
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthenticationService {
  //these are our dependecies
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _authFirebase = FirebaseAuth.instance;
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  static String userNameS;
  // these are shared state widgets
  Stream<User> user; // User
  Stream<Map<String, dynamic>> profile; // custom user data in firestore
  PublishSubject loading =
      PublishSubject(); // observable that we can push new values to on

  //constructor

  AuthenticationService() {
    user = (_authFirebase.authStateChanges());
    profile = user.switchMap((User user) {
      if (user != null) {
        return _database
            .collection('users')
            .doc(user.uid)
            .snapshots()
            .map((snap) => snap.data());
      } else {
        // if user is not sign in
        return Stream.value({});
      }
    });
  }

// Will be used when a user taps the goolge sign in button and will take them to their
// google account so they can log in and authenticate
  Future<User> googleSignIn() async {
    try {
      loading.add(true);
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential =
          await _authFirebase.signInWithCredential(credential);

      User user = UserCredential.user;
      updateUserData(user);
      userNameS = user.displayName.toString();
      print(userNameS);

      print("user name: ${user.displayName}");
      loading.add(false);
      return user;

      //loading.add(false);
    } catch (e) {
      print("this is the error:");
      print(e.toString());
      print("error logging in");
      return e;
    }
  }

// Will update the user data inside firestore
  void updateUserData(User user) async {
    DocumentReference ref = _database.collection('users').doc(user.uid);

 
    return ref.set({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoURL,
      'displayName': user.displayName,
      'lastSeen': DateTime.now(),
    }, SetOptions( merge: true));
  }

// Sign out the user from firestore
  Future<String> signOutApp() async {
    try {
      await _authFirebase.signOut();
      await _googleSignIn.signOut();
      return 'Signout';
      //Future<User> user = FirebaseAuth.instance.currentUser();
      // print('$user');
      // return new LoginScreen();

      // print(_authFirebase.signOut().toString());
      // await _authFirebase.signOut();
      //await _googleSignIn.disconnect();
    } catch (e) {
      return e.toString();
      //print(e.toString());
      //print("errolor logging out");

    }
  } // end of signout

  // Future registerWithEmailAndPassword(String email, String password) async {
  //    UserCredential result = await _authFirebase.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //   try {
  //     User user = result.user;

  //     await user.sendEmailVerification();
  //     return _userFromUser(user);

  //   } catch (e) {
  //     print(e.toString());
  //     return null; 
  //   }
  // }

  //   User _userFromUser (User user){
  //   return user != null ? User(uid: user.uid) : null ;
  // }
// Future signInWithEmailAndPassword(String email, String password) async {
//     try {
//       UserCredential result = await _authFirebase.signInWithEmailAndPassword(
//           email: email, password: password);
//       User user = result.user;

//       if (user.isEmailVerified){
//        return _userFromUser(user);
//       }else{
//         return null;
//       }
      
//     } catch (e) {
//       print(e.toString());
//       return null; 
//     }
//   }
@override
Future<void> resetPassword(String email) async {
    await _authFirebase.sendPasswordResetEmail(email: email);
}


} // end of class

final AuthenticationService authService = AuthenticationService();
