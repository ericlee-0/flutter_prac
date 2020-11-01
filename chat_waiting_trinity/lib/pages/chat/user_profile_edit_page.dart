import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileEditPage extends StatefulWidget {
  static const routeName = '/user-profile-edit';
  final String userId;
  UserProfileEditPage(this.userId);

  @override
  _UserProfileEditPageState createState() => _UserProfileEditPageState();
}

class _UserProfileEditPageState extends State<UserProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  var _isLoading = false;
  var _userName;
  var _userImageUrl;

  // final String userId;

  Future<String> _initUserData() async {
    print('userId: ${widget.userId}');
    final resultUserData = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .get();
    _userName = resultUserData.data()['username'];
    _userImageUrl = resultUserData.data()['image_url'];
    print('username: $_userName');
    // setState(() {
    //   _userName = _userName['username'];
    // });
    return 'succeeded';
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        setState(() {
          _isLoading = true;
        });

        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .update({
          'username': _userName,
          // 'email': email,
          // 'image_url':url,
        });
      } catch (error) {
        print(error);
        setState(() {
          _isLoading = false;
        });
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final String userId = ModalRoute.of(context).settings.arguments as String;
    // _initUserData(userId);
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: Card(
            margin: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FutureBuilder<String>(
                        future:
                            _initUserData(), // a previously-obtained Future<String> or null
                        builder: (context, snapshot) {
                          List<Widget> children;
                          if (snapshot.hasData) {
                            children = <Widget>[
                              Card(
                                child: CircleAvatar(
                                  
                                  radius: 80,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                      _userImageUrl),
                                ),
                                
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FlatButton.icon(
                                    label: Flexible(
                                      fit: FlexFit.loose,
                                      child: Container(
                                        color: Colors.white,
                                        child: Text(
                                          'Camera',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    icon: Icon(Icons.camera_alt),
                                    onPressed: () {},
                                  ),
                                  FlatButton.icon(
                                    label: Flexible(
                                      fit: FlexFit.loose,
                                      child: Container(
                                        color: Colors.white,
                                        child: Text(
                                          'Gallery',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    icon: Icon(Icons.image_search),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              TextFormField(
                                key: ValueKey('username'),
                                initialValue: _userName,
                                autocorrect: true,
                                textCapitalization: TextCapitalization.words,
                                enableSuggestions: false,
                                validator: (value) {
                                  if (value.isEmpty || value.length < 2) {
                                    return 'Please enter at least 2 characters';
                                  }
                                  return null;
                                },
                                decoration:
                                    InputDecoration(labelText: 'Username'),
                                onSaved: (value) {
                                  _userName = value;
                                },
                              ),
                            ];
                          } else if (snapshot.hasError) {
                            children = <Widget>[
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 60,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text('Error: ${snapshot.error}'),
                              )
                            ];
                          } else {
                            children = <Widget>[
                              SizedBox(
                                child: CircularProgressIndicator(),
                                width: 60,
                                height: 60,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text('Awaiting result...'),
                              )
                            ];
                          }
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: children,
                            ),
                          );
                        },
                      ),
                      // UserImagePicker(_pickedImage),

                      Padding(
                        padding: EdgeInsets.only(top: 50),
                      ),
                      _isLoading
                          ? CircularProgressIndicator()
                          : RaisedButton(
                              child: Text('Update Profile'),
                              onPressed: () {
                                _updateProfile();
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
