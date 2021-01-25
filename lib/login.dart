import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
void main() {
  runApp(
      MaterialApp(home:LoginApp())

  );
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.grey[900],

        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Image(image: AssetImage('assets/images/tree2.png')

              ),
              Padding(padding: EdgeInsets.all(30)),
          ClipRRect(
            child: Container(
              // child: RaisedButton(
              // // shape: RoundedRectangleBorder(
              // //   borderRadius: BorderRadius.circular(20)
              // //
              // // ),
              //   color: Colors.green,
              // padding: EdgeInsets.only(
              //     top: 6.0, bottom: 6.0, left: 10.0, right: 10.0),
              //     textColor : Colors.brown,
              //   onPressed: () {
              //     },
              //
              // // child: Text(
              // //   "SignIn with Google",
              // //   style: TextStyle(fontSize: 20),
              // // ),
              //
              // ),
               child: GoogleSignInButton(
                  onPressed: () {

                  },
                  darkMode: true, // default: false
                )
            ),
          ),
            ],
          ),
        ),
      );
  }
}

