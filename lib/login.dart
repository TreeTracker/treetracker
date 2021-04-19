import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

import 'auth.dart';

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Image.asset(
                          'assets/images/tree2.png',
                          height: 160,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text("Tree Tracker",
                          style: TextStyle(
                            color: Colors.green.shade500,
                            fontSize: 40,
                            fontFamily: 'Ubuntu',
                          )),
                      Padding(padding: EdgeInsets.all(40)),
                      ClipRRect(
                        child: Container(child: GoogleSignInButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Auth()),
                            );
                          },
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    exit(0);
  }
}
