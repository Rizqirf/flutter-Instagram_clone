import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/user.dart' as model;

class Auth {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign up user
  Future<String> signUpUser({
    required String email,
    required String username,
    required String password,
  }) async {
    String res = "Some Error Occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl: '',
          email: email,
          bio: '',
          followers: [],
          following: [],
        );

        // add user to db
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "Success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> signInUser(
      {required String email, required String pass}) async {
    String res = 'Some Error Occured';

    try {
      if (email.isNotEmpty || pass.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: pass);
        res = 'Success';
      } else {
        res = 'Please complete all fields';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
