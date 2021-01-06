// import 'dart:io';
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../widgets/chat/auth_form.dart';
import 'package:flutter/foundation.dart';
// import 'package:firebase/firebase.dart' as fb;


class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isLoading = false;
  // File _imageFile;

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
        // _imageFile = File('assets/images/user_image_default.png');
      });
      if (isSignIn) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // print('authResut: $authResult');
        await _registerUser(userId:authResult.user.uid, userName:username, userEmail:email);
        // final ref = FirebaseStorage.instance
        //     .ref() //access root clould strage
        //     .child('user_image') //sub folder
        //     .child('user_image_default.png'); //filename
// print(ref.path);
//         await ref
//             .putFile(_imageFile)
//             .onComplete;
// print('before get url');
        // final url = await ref.getDownloadURL();

        // await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(authResult.user.uid)
        //     .set({
        //   'username': username,
        //   'email': email,
        //   'image_url': url,
        // });
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

  Future<void> _registerUser({String userId,
      String userName='guest' , String userEmail='noEmail', String phone=''}) async {
    try {
      // print('registerUser $userId');
      String imageUrl;
      var ref;
      if (kIsWeb) {
        //firebase 7.3 can not be working with mobile app.
        // ref = fb
        //     .storage()
        //     .refFromURL('gs://chat-waiting-trinity.appspot.com')
        //     .child('user_image') //sub folder
        //     .child('user_image_default.png'); //f
        // imageUrl = await ref.getDownloadURL();
        // imageUrl = imageUrl.toString();
        imageUrl = 'https://firebasestorage.googleapis.com/v0/b/chat-waiting-trinity.appspot.com/o/user_image%2Fuser_image_default.png?alt=media&token=a89351f1-39dc-419a-a0d4-8ff9fd226823';
      } else {
        ref = FirebaseStorage.instance
            .ref() //access root clould strage
            .child('user_image') //sub folder
            .child('user_image_default.png'); //filename
        imageUrl = await ref.getDownloadURL();
      }

      // print('imageUrl: $imageUrl');
      // print('username $userName, useremail $userEmail');
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        // 'username': userName == null ? 'guest': userName,
        // 'email': userEmail == null ? 'noEmail':userEmail,
        // 'image_url': imageUrl,
        'username':userName,
        'email': userEmail,
        'image_url': imageUrl,
        'phoneNo':phone
      });
    } catch (e) {
      print(e);
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

      await _registerUser(
          userId:authResult.user.uid, userName:currentUser.displayName, userEmail:currentUser.email);
      // final ref = FirebaseStorage.instance
      //     .ref() //access root clould strage
      //     .child('user_image') //sub folder
      //     .child('user_image_default.png'); //filename
      // final url = await ref.getDownloadURL();

      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(currentUser.uid)
      //     .set({
      //   'username': currentUser.displayName,
      //   'email': currentUser.email,
      //   'image_url': url,
      // });
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
    try {
      setState(() {
        _isLoading = true;
      });
      final authResult = await _auth.signInWithCredential(authCred);
      final User _user = authResult.user;
      final User currentUser = _auth.currentUser;
      assert(_user.uid == currentUser.uid);
      await _registerUser(userId:authResult.user.uid,phone:_user.phoneNumber);
    } catch (err) {
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

  void _signInWithPhoneWithOTP(
      BuildContext ctx, String verId, String smsCode) async {
    try {
      setState(() {
        _isLoading = true;
      });
      AuthCredential authCreds =
          PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
      final authResult = await _auth.signInWithCredential(authCreds);
      final User _user = authResult.user;
      final User currentUser = _auth.currentUser;
      assert(_user.uid == currentUser.uid);
      await _registerUser(userId:authResult.user.uid,phone: _user.phoneNumber);
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Theme.of(context).primaryColor,
  //     body: AuthForm(_submitAuthForm, _signInWithGoogle, _signInWithPhone,
  //         _signInWithPhoneWithOTP, _isLoading),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return AuthForm(_submitAuthForm, _signInWithGoogle, _signInWithPhone,
          _signInWithPhoneWithOTP, _isLoading);
  }
}
