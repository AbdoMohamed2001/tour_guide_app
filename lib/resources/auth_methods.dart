import 'dart:typed_data';
import 'package:TourGuideApp/resources/storage_methods.dart';
import 'package:image_picker/image_picker.dart';
import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/screens/homePage/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //----------------------------------------------
  //sign up user
  Future<String> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String userName,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(credential.user!.uid);
      String photoUrl = await StorageMethods()
          .uploadImageToStorage('profilePics', file, false);
      //Store user to database
      _firestore.collection('users').doc(credential.user!.uid).set({
        'username': userName,
        'email': email,
        'uid': credential.user!.uid,
        'photoUrl': photoUrl,
      });
      res = 'Success';
      showSnackBar(context, 'Registered Successfully');
      Navigator.pushNamed(context, HomePage.id);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, 'Password is weak');
      }
      else if (e.code == 'email-already-in-use') {
        showSnackBar(
          context,
          'The account already exists for that email',
        );
      }
    } catch (err) {
      res = err.toString();
      print(err);
      showSnackBar(
        context,
        err.toString(),
      );
    }
    return res;
  }

//----------------------------------------------
  Future<void> loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      showSnackBar(context, 'Logged in Successfully');
      Navigator.pushReplacementNamed(context, HomePage.id);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'No user found for that email.');
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, 'Wrong password provided for that user.');
        // print('Wrong password provided for that user.');
      }
    }
  }
}
