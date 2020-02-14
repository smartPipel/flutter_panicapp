import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panicapp/model/auth/auth.dart';
import 'package:panicapp/collection/collections.dart';
import 'package:toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  FirebaseUser user;
  String _email;
  String _password;
  String _username;
  String _telephone;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: buildRegisterTextTitle(),
          ),
          inputText(),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[buildTextRegisterTap(context)],
            ),
          ),
          buildButtonLogin(context),
        ],
      ),
    );
  }

  Padding buildButtonLogin(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: ButtonTheme(
          minWidth: 400,
          height: 50,
          child: RaisedButton(
            color: Colors.orangeAccent,
            child: Text(
              "Register",
              style: fontBold(16, Colors.white),
            ),
            onPressed: () async{
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                await AuthServices().emailSignUp(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                    _username.trim(),
                    _telephone.trim(),
                    context);
              }
            },
          ),
        ),
      ),
    );
  }

  Align buildRegisterTextTitle() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        "Register",
        style: fontBold(30, Colors.orangeAccent),
      ),
    );
  }

  FlatButton buildTextRegisterTap(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text("Login", style: fontSemi(15, Colors.blue)),
    );
  }

  Padding inputText() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              onSaved: (val) {
                _username = val;
              },
              validator: (String value) {
                if (value.isEmpty) {
                  return "* Username tidak boleh kosong";
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              style: fontBold(16, Colors.black),
              controller: _usernameController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  FontAwesomeIcons.user,
                  color: Colors.orangeAccent,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent),
                ),
                hintText: "Username",
                hintStyle: fontSemi(16, Colors.grey),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              style: fontBold(16, Colors.black),
              onSaved: (val) {
                _telephone = val;
              },
              validator: (String value) {
                if (value.isEmpty) {
                  return "* Telephone tidak boleh kosong";
                }
                
              },
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              controller: _telephoneController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.phone_iphone,
                  color: Colors.orangeAccent,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent),
                ),
                hintText: "Telephone",
                hintStyle: fontSemi(16, Colors.grey),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: TextFormField(
              style: fontBold(16, Colors.black),
              onSaved: (val) {
                _email = val;
              },
              validator: (String value) {
                if (value.isEmpty) {
                  return "* Email tidak boleh kosong";
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintStyle: fontSemi(16, Colors.grey),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.orangeAccent,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent),
                ),
                hintText: "Email",
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
            ),
          ),
          TextFormField(
            onSaved: (val) {
              _email = val;
            },
            style: fontBold(16, Colors.black),
            validator: (String value) {
              if (value.isEmpty) {
                return "* Password tidak boleh kosong";
              } else if (value.length < 6) {
                return "* Password harus 8 karakter atau lebih";
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            controller: _passwordController,
            decoration: InputDecoration(
              hintStyle: fontSemi(16, Colors.grey),
              prefixIcon: Icon(
                FontAwesomeIcons.key,
                color: Colors.orangeAccent,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orangeAccent),
              ),
              hintText: "Password",
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
