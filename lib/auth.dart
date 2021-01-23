import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'SignIn'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        //Checking for user login Status

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(_user == null ? "" : _user.email),
            ),
            ClipRRect(
              child: Container(
                  child: RaisedButton(
                color: Colors.green,
                padding: EdgeInsets.only(
                    top: 6.0, bottom: 6.0, left: 10.0, right: 10.0),
                onPressed: () {
                  _user == null ? login() : logout();
                },
                child: Text(
                  _user == null ? "Login" : "Logout",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout() async {
    await _signIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  Future<void> login() async {
    try {
      GoogleSignInAccount account = await _signIn.signIn();
      GoogleSignInAuthentication auth = await account.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: auth.accessToken, idToken: auth.idToken);

      //Login..
      FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      print(error);
    }
  }
}
