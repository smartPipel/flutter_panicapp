import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snack/snack.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File _image;

  getPhotoFrom(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      maxWidth: 512,
      maxHeight: 512,
    );
    var resultImage = await FlutterImageCompress.compressAndGetFile(
        croppedImage.path, image.path,
        quality: 80);

    setState(() {
      _image = resultImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            _image != null
                ? Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                    ),
                    child: Image.file(
                      _image,
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  )
                : Container(
                    color: Colors.yellow,
                    width: 300,
                    height: 300,
                    child: Icon(Icons.image),
                  ),
            IconButton(
                icon: Icon(EvaIcons.edit2),
                onPressed: () {
                 var bar = SnackBar(
                      content: Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(FontAwesomeIcons.cameraRetro),
                          onPressed: () {
                            getPhotoFrom(ImageSource.camera);
                          }),
                      IconButton(
                          icon: Icon(FontAwesomeIcons.images),
                          onPressed: () {
                            getPhotoFrom(ImageSource.gallery);
                          })
                    ],
                  ));
                  bar.show(context, scaffoldState: ScaffoldState());
                }),
          ],
        ),
      ),
    ));
  }
}
