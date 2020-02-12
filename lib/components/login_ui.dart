import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panicapp/auth/auth.dart';
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
    AuthServices().getUser().then((user) {
      if(user != null){
        Navigator.pushNamedAndRemoveUntil(context, "/home", ModalRoute.withName("/"));
        Toast.show("Selamat Datang ${user.displayName}", context, duration: Toast.LENGTH_SHORT);
      }
    });
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
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: buildFacebookLoginBtn(context),
              ),
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
        style: TextStyle(
          fontSize: 30,
          color: Colors.orangeAccent,
        ),
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
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
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
        style: TextStyle(
          fontSize: 15,
          color: Colors.blue,
        ),
      ),
    );
  }

  Padding inputText() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          TextFormField(
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
            decoration: InputDecoration(
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
          TextFormField(
            onSaved: (val) {
              _email = val;
            },
            validator: (String value) {
              if (value.isEmpty) {
                return "* Password tidak boleh kosong";
              } else if (value.length < 8) {
                return "* Password harus 8 karakter atau lebih";
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            controller: _passwordController,
            decoration: InputDecoration(
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
