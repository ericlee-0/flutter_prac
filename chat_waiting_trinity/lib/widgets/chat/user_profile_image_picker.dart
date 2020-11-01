import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileImagePicker extends StatefulWidget {
  static const routeName = '/user-profile-image-picker';
  final Function(File pickedImage) imagePickerFn;
  final String userImageUrl;

  UserProfileImagePicker(this.imagePickerFn,this.userImageUrl);
  @override
  _UserProfileImagePickerState createState() => _UserProfileImagePickerState();
}

enum SelectImageSource { fromCamera, fromGallery }

class _UserProfileImagePickerState extends State<UserProfileImagePicker> {
  File _pickedImage;
  final picker = ImagePicker();
  var _selectedImageSource;

  Future<void> _getImage() async {
    ImageSource imageS;
    if (_selectedImageSource == SelectImageSource.fromCamera) {
      imageS = ImageSource.camera;
    }
    if (_selectedImageSource == SelectImageSource.fromGallery) {
      imageS = ImageSource.gallery;
    }
    try {
      final pickedImageFile = await picker.getImage(
        source: imageS,
        // imageQuality: 70,
        maxWidth: 250,
      );
      print('picked image');
      setState(() {
        if (pickedImageFile != null) {
          _pickedImage = File(pickedImageFile.path);
        } else {
          print('No image selected.');
        }
      });
      widget.imagePickerFn(_pickedImage);
    } catch (err) {
      print(err);
      if (err != null) {
        retrieveLostData();
      }
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _pickedImage = File(response.file.path);
        // if (response.type == RetrieveType.video) {
        //   _handleVideo(response.file);
        // } else {
        //   _handleImage(response.file);
        // }
      });
      widget.imagePickerFn(_pickedImage);
    } else {
      // _handleError(response.exception);
      print('retrievelostdata error');
      print(response.exception);
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Profile Image Change', textAlign: TextAlign.center,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FlatButton(
                child: Text('Camera Image'),
                onPressed: () {
                  // Navigator.of(context).pop();
                  setState(() {
                    _selectedImageSource = SelectImageSource.fromCamera;
                  });
                  print(_selectedImageSource);
                  _getImage();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Gallery Image'),
                onPressed: () {
                  // Navigator.of(context).pop();
                  setState(() {
                    _selectedImageSource = SelectImageSource.fromGallery;
                  });
                  print(_selectedImageSource);
                  _getImage();
                  Navigator.of(context).pop();
                },
              ),
              // FlatButton(
              //   child: Text('Cancel'),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
            ],
          ),
          // actions: [

          // ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
            alignment: Alignment.center,
            // overflow: Overflow.visible,
            clipBehavior: Clip.none,
            children: [
              // Card(
                // child: 
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  // backgroundImage: NetworkImage(_userImageUrl),
                  backgroundImage: _pickedImage != null
                      ? FileImage(_pickedImage)
                      : NetworkImage(widget.userImageUrl),
                ),
              // ),
              Positioned(
                  top: 80,
                  right: -150,
                  bottom: 0,
                  left: 0,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt),
                    color: Colors.grey,
                    iconSize: 50,
                    onPressed: _showMyDialog,
                  )),
            ],
          
     
    );
  }
}
