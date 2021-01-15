import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Auth with ChangeNotifier {
  static Auth get instance => Auth();
  final User user = FirebaseAuth.instance.currentUser;
  final Stream<User> firebaseAuthState =
      FirebaseAuth.instance.authStateChanges();


  dynamic get userId {
    // print(user);
    // print(firebaseAuthState.forEach((element) {print(element);}));
    return user.uid;
  }

  Stream<User> get authState {
    // final stateChange = FirebaseAuth.instance.authStateChanges();
    return firebaseAuthState;
  }

  Stream<User> get authUser {
     FirebaseAuth.instance.authStateChanges();
    // final stateChange = FirebaseAuth.instance.authStateChanges();
    return firebaseAuthState;
  }
}
