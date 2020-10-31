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
  var _userName;
  var _userImageUrl;

  // final String userId;

  Future<List> _initUserData() async {
    print('userId: ${widget.userId}');
    final resultUserData = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .get();
    _userName = resultUserData.data()['username'];
    print('username: $_userName');
    // setState(() {
    //   _userName = _userName['username'];
    // });
    return [_userName, _userImageUrl];
  }

  @override
  Widget build(BuildContext context) {
    // final String userId = ModalRoute.of(context).settings.arguments as String;
    // _initUserData(userId);
    return Scaffold(
        appBar: AppBar(
          title: Text('User'),
        ),
        body: Center(
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
                      FutureBuilder(
                        future: _initUserData(),
                        builder: (ctx, snapshot) {
                          print(snapshot);
                          return Column(
                            children: [
                              Card(
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(
                                      'assets/images/user_image_default.png'),
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
                                  if (value.isEmpty || value.length < 4) {
                                    return 'Please enter at least 4 characters';
                                  }
                                  return null;
                                },
                                decoration:
                                    InputDecoration(labelText: 'Username'),
                                onSaved: (value) {
                                  // setState(() {
                                  //   _userName = value;
                                  // });
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      // UserImagePicker(_pickedImage),

                      Padding(
                        padding: EdgeInsets.only(top: 50),
                      ),
                      RaisedButton(
                          child: Text('Update Profile'), onPressed: () {}),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
