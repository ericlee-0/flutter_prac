import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../widgets/chat/auth_form.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isLoading = false;
  File _imageFile;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    // File defaultImage,
    var isSignIn,
    BuildContext ctx,
  ) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
        _imageFile = File('assets/images/user_image_default.png');
      });
      if (isSignIn) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print('authResut: $authResult');
        final ref = FirebaseStorage.instance
            .ref() //access root clould strage
            .child('user_image') //sub folder
            .child('user_image_default.png'); //filename
// print(ref.path);
//         await ref
//             .putFile(_imageFile)
//             .onComplete;
// print('before get url');
        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({
          'username': username,
          'email': email,
          'image_url': url,
        });
      }
    } catch (err) {
      print(err.message);
      if (err != null) {
        Scaffold.of(ctx).showSnackBar(
          SnackBar(
            content: Text(err.message),
            backgroundColor: Theme.of(ctx).errorColor,
          ),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signInWithGoogle(BuildContext ctx) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      // model.state =ViewState.Busy;
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      authResult = await _auth.signInWithCredential(credential);
      User _user = authResult.user;
      assert(!_user.isAnonymous);
      assert(await _user.getIdToken() != null);
      // User currentUser = await _auth.currentUser();
      User currentUser = _auth.currentUser;
      assert(_user.uid == currentUser.uid);

      final ref = FirebaseStorage.instance
          .ref() //access root clould strage
          .child('user_image') //sub folder
          .child('user_image_default.png'); //filename
      final url = await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .set({
        'username': currentUser.displayName,
        'email': currentUser.email,
        'image_url': url,
      });
      // model.state = ViewState.Idle;
      // print("User Name: ${_user.displayName}");
      // print("User Email ${_user.email}");
    } catch (err) {
      print(err.message);
      if (err != null) {
        Scaffold.of(ctx).showSnackBar(
          SnackBar(
            content: Text(err.message),
            backgroundColor: Theme.of(ctx).errorColor,
          ),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _signInWithPhone(BuildContext ctx, AuthCredential authCred) async {
    await _auth.signInWithCredential(authCred);
  }

  void _signInWithPhoneWithOTP(
      BuildContext ctx, String verId, String smsCode) async {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    await _auth.signInWithCredential(authCreds);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _signInWithGoogle, _signInWithPhone,
          _signInWithPhoneWithOTP, _isLoading),
    );
  }
}
