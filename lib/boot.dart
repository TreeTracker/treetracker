import 'dart:async';

import 'package:flutter/material.dart';
import 'package:treetracker/auth.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BootScreen(),
    );
  }
}

// class BootScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // return MaterialApp(
//     // home: Scaffold(
//     return Scaffold(
//       // appBar: AppBar(),
//       backgroundColor: Colors.grey[900],
//       body: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Image(image: AssetImage('assets/images/appLogo2.png')),
//             Padding(
//               padding: EdgeInsets.all(30),
//             ),
//             Text(
//               'TreeTracker',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontFamily: 'Ubuntu',
//                 fontSize: 35,
//               ),
//             ),
//             // RaisedButton(
//             //   child: Text('Continue'),
//             //   onPressed: () {
//             //     print("Pressed");
//             //     Navigator.push(
//             //       context,
//             //       MaterialPageRoute(builder: (context) => MyApp()),
//             //     );
//             //   },
//             // ),
//           ],
//         ),
//       ),
//     );
//     // );
//   }
// }

class BootScreen extends StatefulWidget {
  @override
  _BootScreenState createState() => _BootScreenState();
}

class _BootScreenState extends State<BootScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[900],
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage('assets/images/appLogo2.png')),
              Padding(
                padding: EdgeInsets.all(30),
              ),
              Text(
                'TreeTracker',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Ubuntu',
                  fontSize: 35,
                ),
              )
            ]),
      ),
    );
  }
}
