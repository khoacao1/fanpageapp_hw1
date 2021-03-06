import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpageapp_kc/models/user.dart';
import 'package:fanpageapp_kc/screens/home/admin.dart';
import 'package:fanpageapp_kc/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late User _user;

  //create user obj based on FirebaseUser
  ObjectUser? _userFromFirebaseUser(User user) {
    return user != null ? ObjectUser(uid: user.uid) : null;
  }

  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: [
  //     'email',
  //     'https://www.googleapis.com/auth/contacts.readonly',
  //   ],
  // );

  //auth change user stream
  Stream<ObjectUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  // sign in Anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in email & pass
  Future signinWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register email & pass
  Future registerWithEmailAndPassword(
      String fname, String lname, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid)
          .updateUserData(fname, lname, '${user.metadata.creationTime}');
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      await _googleSignIn.signOut();
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future post(String post, String dateTime) async {
    try {
      await DataPost().uploadData(post, dateTime);

      return Admin();
      // return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Signin with google
  Future signInWithGoogle() async {
    // model.state = Provider.of();
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    UserCredential authResult = await _auth.signInWithCredential(credential);
    _user = authResult.user!;
    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);
    User currentUser = await _auth.currentUser!;
    assert(_user.uid == currentUser.uid);

    // model.state = ViewState.Idle;
    print("User Name: ${_user.displayName}");
    print("User Email ${_user.email}");
  }
}
