import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  // File _handleImage;
  // File _handleVideo;
  final picker = ImagePicker();

  Future<void> _getImage() async {
    try {
      
      final pickedImageFile = await picker.getImage(source: ImageSource.camera);

      setState(() {
        if (pickedImageFile != null) {
          _pickedImage = File(pickedImageFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (err) {
      // print(err);
      if(err != null){
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
    } else {
      // _handleError(response.exception);
      print('retrievelostdata error');
      print(response.exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _getImage,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
