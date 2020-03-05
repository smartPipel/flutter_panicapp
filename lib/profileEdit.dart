import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panicapp/collection/collections.dart';
import 'package:panicapp/model/auth/auth.dart';
import 'package:toast/toast.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _displayName = TextEditingController();
  String _displayText;
  FirebaseUser user;
  File _image;
  bool keyboardIsOpen = false;

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
  void initState() {
    super.initState();
    AuthServices().getUser().then((usr) {
      setState(() {
        user = usr;
      });
      Toast.show("${user?.displayName}", context, duration: Toast.LENGTH_LONG);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 1.3,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: EdgeInsets.only(top: 100),
                  child: Column(
                    children: <Widget>[
                      _image != null
                          ? Container(
                              height: 100,
                              width: 100,
                              child: CircleAvatar(
                                backgroundImage: FileImage(_image),
                              ),
                            )
                          : Container(
                              width: 100,
                              height: 100,
                              child: CircleAvatar(
                                backgroundImage: user?.photoUrl == null
                                    ? AssetImage("assets/images/userPhoto.png")
                                    : NetworkImage("${user?.photoUrl}"),
                              ),
                            ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        margin: EdgeInsets.only(top: 30),
                        child: TextFormField(
                          controller: _displayName,
                          autovalidate: true,
                          onSaved: (val) {
                            _displayText = val;
                          },
                          validator: (String val) {
                            if (val.isEmpty || val.length <= 5) {
                              return "* Username tidak boleh kosong atau kurang dari 5";
                            }
                            return null;
                          },
                          style: fontBold(16, Colors.black),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.verified_user),
                              hintText: "${user?.displayName}",
                              hintStyle: fontSemi(16, Colors.grey)),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        decoration:  BoxDecoration(
                          color: DefaultColors.green,
                          borderRadius: BorderRadius.circular(25)
                        ),
                        margin: EdgeInsets.only(top: 50),
                        child: FlatButton(
                          child: Text("Selesai Edit"),
                          onPressed: () async {
                            if (_displayName.text.length >= 5) {
                              try {
                                CollectionReference _firestore = Firestore.instance.collection("laporan");
                                StorageReference storageRef = FirebaseStorage
                                    .instance
                                    .ref()
                                    .child("user_photo/" + user?.uid);
                                StorageUploadTask task =
                                    storageRef.putFile(_image);
                                var downUrl = await (await task.onComplete)
                                    .ref
                                    .getDownloadURL();
                                var url = downUrl.toString();
                                // QuerySnapshot update = await _firestore.where("uid", isEqualTo: "${user?.uid}").getDocuments();
                                
                                // final DocumentReference doc = _firestore.document(update.documents[0].documentID);

                                UserUpdateInfo updateInfo = UserUpdateInfo();
                                if (_image.length() != 0) {

                                  //  Firestore.instance.runTransaction((transaction) async {
                                  //    await transaction.update(doc, {
                                  //      "user_photo": url,
                                  //      "nama_pelapor": _displayName.text.trim()
                                  //    });
                                  //  });
                                  
                                  updateInfo.photoUrl = url;
                                  updateInfo.displayName =
                                      _displayName.text.trim();
                                  user.updateProfile(updateInfo);
                                  user.reload();

                                } else {
                                  // Firestore.instance.runTransaction((transaction) async {
                                  //    await transaction.update(doc, {
                                  //      "nama_pelapor": _displayName.text.trim()
                                  //    });
                                  //  });

                                  updateInfo.displayName =
                                      _displayName.text.trim();
                                  user.updateProfile(updateInfo);
                                  user.reload();
                                }
                              } catch (e) {
                                print(e);
                              }
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.all(25),
                    child: FloatingActionButton(
                      elevation: 10,
                      child: Icon(Icons.camera_alt),
                      onPressed: () {
                        _showMyBottomSheet();
                      },
                    ),
                  ))
            ],
          ),
        ),
      ),
    ));
  }

  void _showMyBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white),
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.cameraRetro,
                          size: 40,
                          color: Colors.orangeAccent[100],
                        ),
                        onPressed: () {
                          getPhotoFrom(ImageSource.camera);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Camera",
                        style: fontBold(16, Colors.black),
                      ),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.images,
                          size: 40,
                          color: Colors.greenAccent,
                        ),
                        onPressed: () {
                          getPhotoFrom(ImageSource.gallery);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Galeri", style: fontBold(16, Colors.black)),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
