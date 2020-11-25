import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_aut';

class AuthForm extends StatefulWidget {
  AuthForm(this.authSubmit, this.signInWithGoogle, this.signInWithPhone,
      this.signInWithPhoneWithOTP, this.isLoading);

  final bool isLoading;
  final Function authSubmit;
  final Function signInWithGoogle;
  final Function signInWithPhone;
  final Function signInWithPhoneWithOTP;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneFormKey = GlobalKey<FormState>();
  var _isSignIn = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  var _phoneNo = '';
  var _smsCode = '';
  String _verificationId = '';
  bool _codeSent = false;
  TextEditingController _phoneVerifiController = TextEditingController();

  void _userSubmit() {
    final isValid = _formKey.currentState
        .validate(); //will triger all validators in textforms
    FocusScope.of(context).unfocus();

    // if (_userImageFile == null && !_isSignIn) {
    //   Scaffold.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Please pick an image'),
    //       backgroundColor: Theme.of(context).errorColor,
    //     ),
    //   );
    //   return;
    // }

    if (isValid) {
      _formKey.currentState.save();
      widget.authSubmit(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        // _userImageFile,
        _isSignIn,
        context,
      );
    }
  }

  void _submitPhone() {
    final isValid = _phoneFormKey.currentState
        .validate(); //will triger all validators in textforms
    FocusScope.of(context).unfocus();
    if (isValid) {
      _phoneFormKey.currentState.save();

      if (kIsWeb) {
        if (_codeSent) {
          widget.signInWithPhoneWithOTP(context, _verificationId, _smsCode);
        } else {
          print('web phone login');
          _signInWithPhoneWeb();
          _showMyDialog();
        }
        // running on the web!

      } else {
        // NOT running on the web! You can check for additional platforms here.

        if (_codeSent) {
          widget.signInWithPhoneWithOTP(context, _smsCode, _verificationId);
        } else {
          _verifyPhone(_phoneNo);
          _showMyDialog();
        }
      }
    }
  }

  void _signInWithPhoneWeb() async {
    try {
      // print('auth signInwithphonenumber.....');
      // print('phone# $phone');
      ConfirmationResult confirmationResult =
          await FirebaseAuth.instance.signInWithPhoneNumber(_phoneNo);

      _verificationId = confirmationResult.verificationId;
      setState(() {
        _codeSent = true;
      });

      // UserCredential userCredential =
      //     await confirmationResult.confirm('654321');
      // print('userCredential: $userCredential');
    } catch (e) {
      print(e);
    }
    // await _auth.signInWithCredential();
  }

  Future<void> _verifyPhone(_phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      widget.signInWithPhone(context, authResult);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forseResend]) {
      _verificationId = verId;
      setState(() {
        _codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeOut = (String verId) {
      _verificationId = verId;
    };
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: _phoneNo,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verified,
          verificationFailed: verificationFailed,
          codeSent: smsSent,
          codeAutoRetrievalTimeout: autoTimeOut);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Please Enter Verification Code',
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                key: ValueKey('phone_verify'),
                controller: _phoneVerifiController,
                // initialValue: 'ex)6478581234',
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Enter teh Code',
                  suffixIcon: IconButton(
                    onPressed: () => _phoneVerifiController.clear(),
                    icon: Icon(Icons.clear),
                  ),
                ),
                onChanged: (value) {
                  _smsCode = value;
                },
              ),
              RaisedButton(
                child: Text('Verify'),
                onPressed: () {
                  _submitPhone();

                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Re-Send the Code'),
                onPressed: () {
                  if (kIsWeb) {
                    _signInWithPhoneWeb();
                  } else {
                    _verifyPhone(_phoneNo);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              // width: ,
              child: RaisedButton(
                padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0),
                color: const Color(0xFF4285F4),
                onPressed: () => widget.signInWithGoogle(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/google-logo.png',
                      height: 40.0,
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Text(
                          "Sign in with Google",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(20),
              child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _phoneFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          key: ValueKey('phone'),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              hintText: 'type phone number ex) 6478585678'),
                          validator: (value) {
                            if (value.isEmpty || value.length != 10) {
                              return 'Prease enter a valid phone number.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            // setState(() {
                            _phoneNo = '+1' + value;
                            print(_phoneNo);
                            // });
                          },
                        ),
                        // if (_codeSent)
                        //   TextFormField(
                        //     key: ValueKey('phone_verify'),
                        //     keyboardType: TextInputType.phone,
                        //     decoration: InputDecoration(hintText: 'Enter OTP'),
                        //     onChanged: (value) {
                        //       setState(() {
                        //         _smsCode = value;
                        //       });
                        //     },
                        //   ),
                        if (widget.isLoading) CircularProgressIndicator(),
                        if (!widget.isLoading)
                          RaisedButton(
                            child: Text('Login'),
                            onPressed: () {
                              _submitPhone();
                            },
                          ),
                      ],
                    ),
                  )),
            ),
            // SizedBox(height: 100),
            Card(
              margin: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // if (!_isSignIn) UserImagePicker(_pickedImage),

                        TextFormField(
                          key: ValueKey('email'),
                          // autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          enableSuggestions: false,
                          validator: (value) {
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value);
                            if (value.isEmpty || !emailValid) {
                              return 'Prease enter a valid email address.';
                            }

                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                          ),
                          onSaved: (value) {
                            _userEmail = value;
                          },
                        ),
                        if (!_isSignIn)
                          TextFormField(
                            key: ValueKey('username'),
                            autocorrect: true,
                            textCapitalization: TextCapitalization.words,
                            enableSuggestions: false,
                            validator: (value) {
                              if (value.isEmpty || value.length < 2) {
                                return 'Please enter at least 2 characters';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'Username'),
                            onSaved: (value) {
                              _userName = value;
                            },
                          ),
                        TextFormField(
                          key: ValueKey('password'),
                          validator: (value) {
                            if (value.isEmpty || value.length < 6) {
                              return 'Password must be at least 6 characters long.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          onSaved: (value) {
                            _userPassword = value;
                          },
                        ),
                        SizedBox(height: 12),
                        if (widget.isLoading) CircularProgressIndicator(),
                        if (!widget.isLoading)
                          RaisedButton(
                            child: Text(_isSignIn ? 'SignIn' : 'SignUp'),
                            onPressed: _userSubmit,
                          ),
                        if (!widget.isLoading)
                          FlatButton(
                            textColor: Theme.of(context).primaryColor,
                            onPressed: () {
                              setState(() {
                                _isSignIn = !_isSignIn;
                              });
                            },
                            child: Text(_isSignIn
                                ? 'Creat new account'
                                : 'I already have an account'),
                          ),
                        // SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
