import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'usermodel.dart';

class Authservice {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  Users? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return Users(user.uid, user.email);
  }

  Stream<Users?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<Users?> signInWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return _userFromFirebase(credential.user);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, error);
    }
    return null;
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

String error = 'Your email or password is invalid, please try again';
