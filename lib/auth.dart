import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:treetracker/home.dart';
import 'package:treetracker/login.dart';
import 'package:treetracker/logout.dart';
import 'boot.dart';
import 'homescreen.dart';

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Authentication(),
    );
  }
}

class Authentication extends StatefulWidget {
  Authentication({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  User _user = FirebaseAuth.instance.currentUser;
  GoogleSignIn _signIn = GoogleSignIn(scopes: ['email']);

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        _user = user;
      });
    });
    if (_user == null) {
      login();
    } else {
      logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: SizedBox(
          height: 75,
          width: 75,
          child: CircularProgressIndicator(
            backgroundColor: Colors.green,
            strokeWidth: 7,
          ),
        ),
      ),
    );
  }

  Future<void> logout() async {
    await _signIn.signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Logout()),
    );
  }

  Future<void> login() async {
    try {
      GoogleSignInAccount account = await _signIn.signIn();
      GoogleSignInAuthentication auth = await account.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: auth.accessToken, idToken: auth.idToken);

      //Login..
      FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AppHomePage()),
      );
    } catch (error) {
      print(error);
    }
  }
}
