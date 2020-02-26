import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panicapp/model/auth/auth.dart';
import 'package:panicapp/collection/collections.dart';
import 'package:toast/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginUser extends StatefulWidget {
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  FirebaseUser user;
  String _email;
  String _password;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: buildLoginTextTitle(),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: buildGogleLoginBtn(context),
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 20),
              //   child: buildFacebookLoginBtn(context),
              // ),
            ],
          ),
          inputText(),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildTextRegister(),
                buildTextRegisterTap(context)
              ],
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
        borderRadius: BorderRadius.circular(40),
        child: ButtonTheme(
          minWidth: 400,
          height: 50,
          child: RaisedButton(
            color: Colors.orangeAccent,
            child: Text("Login"),
            onPressed: () async{
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                await AuthServices().emailSignIn(_usernameController.text.trim(), _passwordController.text.trim(), context);
              }
            },
          ),
        ),
      ),
    );
  }

  Align buildLoginTextTitle() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        "Login",
        style: fontBold(30, Colors.orangeAccent),
      ),
    );
  }

  Widget buildGogleLoginBtn(BuildContext context) {
    return IconButton(
      icon: Icon(FontAwesomeIcons.google),
      color: Colors.red,
      iconSize: 35,
      onPressed: () {
        AuthServices().googleSignIn(context);
      },
    );
  }

  Widget buildFacebookLoginBtn(BuildContext context) {
    return IconButton(
      icon: Icon(FontAwesomeIcons.facebook),
      color: Colors.blue,
      iconSize: 35,
      onPressed: () {
        AuthServices().googleSignIn(context);
      },
    );
  }

  Widget buildTextRegister() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        "Belum punya akun?",
        style: fontSemi(15, DefaultColors.light)
      ),
    );
  }

  FlatButton buildTextRegisterTap(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.pushNamed(context, "/userRegister");
      },
      child: Text(
        " Daftar disini!",
        style: fontSemi(15, DefaultColors.blue)
      ),
    );
  }

  Padding inputText() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom:40),
            child: TextFormField(
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
              controller: _usernameController,
              style: fontBold(16, DefaultColors.lighten),
              decoration: InputDecoration(
                hintStyle: fontSemi(16, Colors.grey),
                
                prefixIcon: Icon(
                  Icons.email,
                  color: DefaultColors.lighten,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: DefaultColors.light),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: DefaultColors.light),
                ),
                hintText: "Email",
                
              ),
            ),
          ),
          TextFormField(
            onSaved: (val) {
              _email = val;
            },
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
            style: fontBold(16, DefaultColors.lighten),
            controller: _passwordController,
            decoration: InputDecoration(
              hintStyle: fontSemi(16, Colors.grey),
              prefixIcon: Icon(
                FontAwesomeIcons.key,
                color: DefaultColors.lighten,
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: DefaultColors.light),
                ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color:DefaultColors.light),
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
