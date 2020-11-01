import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileImagePicker extends StatefulWidget {
  static const routeName = '/user-profile-image-picker';
  // final Function(File pickedImage) imagePickerFn;

  // UserProfileImagePicker(this.imagePickerFn);
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
        imageQuality: 70,
        maxWidth: 150,
      );
      print('picked image');
      setState(() {
        if (pickedImageFile != null) {
          _pickedImage = File(pickedImageFile.path);
        } else {
          print('No image selected.');
        }
      });
      // widget.imagePickFn(File(pickedImageFile.path));
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
    } else {
      // _handleError(response.exception);
      print('retrievelostdata error');
      print(response.exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: PopupMenuButton<SelectImageSource>(
            onSelected: (SelectImageSource result) {
              setState(() {
                _selectedImageSource = result;
              });
              print(_selectedImageSource);
              _getImage();
            },
            child: Stack(
              alignment: Alignment.center,
              // overflow: Overflow.visible,
              clipBehavior: Clip.none,
              children: [
                Card(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white,
                    // backgroundImage: NetworkImage(_userImageUrl),
                    backgroundImage: _pickedImage != null
                        ? FileImage(_pickedImage)
                        : AssetImage('assets/images/user_image_default.png'),
                  ),
                ),
                Positioned(
                    top: 80,
                    right: -150,
                    bottom: 0,
                    left: 0,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey,
                      size: 50,
                    )),
              ],
            ),
            itemBuilder: (ctx) => <PopupMenuEntry<SelectImageSource>>[
              const PopupMenuItem<SelectImageSource>(
                value: SelectImageSource.fromCamera,
                child: Text('Camera Image'),
              ),
              const PopupMenuItem<SelectImageSource>(
                value: SelectImageSource.fromGallery,
                child: Text('Gallery Image'),
              ),
            ],
          ),
        ),
        
      ),
    );
  }
}
