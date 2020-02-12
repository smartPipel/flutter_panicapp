import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthServices with ChangeNotifier {
  final FirebaseAuth fAuth = FirebaseAuth.instance;
  final GoogleSignIn gSignin = GoogleSignIn();
  FirebaseUser user;
  



  Future logout(BuildContext context) async {
    Navigator.of(context).pushReplacementNamed('/main');
    return await fAuth.signOut();
  }

  Future<FirebaseUser> getUser() async {
    return await fAuth.currentUser();
  }

  void emailSignIn(String email, String password, BuildContext context) async {
    try {
      user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
    } catch (e) {
      Toast.show("Ada Kesalahan ${e.toString()}", context, duration: Toast.LENGTH_LONG);
    } finally {
      if(user != null){
        Navigator.pushNamedAndRemoveUntil(context, "/home", ModalRoute.withName("/"));
        Toast.show("Selamat Datang ${user.displayName}", context, duration: Toast.LENGTH_SHORT);
      }else{
        Toast.show("Gagal Login", context, duration: Toast.LENGTH_SHORT);
      }
    }
  }

  void emailSignUp(String email, String password, String username,
      String telephone, BuildContext context) async {
    FirebaseUser user;
    try {
      user = (await fAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      Firestore.instance
          .collection("user_phone")
          .document("${user.uid}")
          .setData({"phone_Number": telephone});

      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = username;
      await user.updateProfile(userUpdateInfo);
      await user.reload();
    } catch (e) {
      print("Maaf Ada Kesalahan ${e.toString()}");
    } finally {
      user != null
          ? Navigator.pushNamedAndRemoveUntil(
              context, "/home", ModalRoute.withName("/"))
          : Toast.show("Gagal Register", context, duration: Toast.LENGTH_SHORT);
    }
  }

  Future googleSignIn(context) async {
    GoogleSignInAccount googleSignInAccount = await gSignin.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    final AuthResult authResult =
        await fAuth.signInWithCredential(authCredential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await fAuth.currentUser();
    assert(user.uid == currentUser.uid);

    Navigator.pushNamedAndRemoveUntil(
        context, "/home", ModalRoute.withName("/"));

    Toast.show("Hai, ${currentUser.displayName}", context,
        duration: Toast.LENGTH_SHORT);
  }
}
