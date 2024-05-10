import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../lib.dart';

class AuthServices {
  //instance of auth & firestore

  // sign in with email and pass
  static final AuthServices _instance = AuthServices();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static AuthServices get instance => _instance;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var verificationId = ''.obs;
  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //*SignInWithEmailAndPassword
  Future<void> singInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // save user if it does not exist
    _firestore.collection('Users').doc(userCredential.user!.uid).set(
      {
        'uid': userCredential.user!.uid,
        'email': email,
      },
    );
  }

  //register with email and pass
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // create user
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // save user information in a separate doc
    _firestore.collection('Users').doc(userCredential.user!.uid).set(
      {
        'uid': userCredential.user!.uid,
        'email': email,
      },
    );
    debugPrint('Email $email');
  }

  // sign in with google
  Future<void> signInWithGoogle() async {}

  // sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // sign up

  //errors
}
