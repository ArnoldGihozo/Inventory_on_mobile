import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_on_mobile/services/authentication.dart';

import 'dashboard.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _btn(context));
  }
}

// Widget _buildLoginUi(BuildContext){

//   return SafeArea(
//     child: SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Hero(
//             tag:'logo',
//             child: Container(
//               margin: EdgeInsets.fromLTRB(0.0, 90.0, 0, 0),
//               child: Center(
//                 child: Logo(radius: controller.value),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );

// }

Widget _btn(BuildContext context) {
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 60.0),
          Center(
            child: Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5.0,
                      color: Colors.black26,
                      offset: Offset(0, 2))
                ],
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: Image.asset(
                  'assets/LogoSI.jpeg',
                  scale: 1.5,
                ),
              ),
              alignment: Alignment.center,
            ),
          ),
          const SizedBox(height: 250.0),
          SignInButton(
            Buttons.Google,
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 100.0),
            text: 'Sign With Google',
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0)),
            onPressed: () async {
              await authService.googleSignIn();
              Fluttertoast.showToast(
                msg: "Succefully Signed In with Google",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardUI(),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}

// Widget _googleSignInBtn(BuildContext context){
//   return SizedBox(
//     height: 200,
//     width: 200,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//         child: Padding(
//           padding: EdgeInsets.all(1),
//           child: SignInButton(
//             Buttons.Google,
//             padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 1.0),
//             text: 'Sign in with Google',
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(40.0)),
//             onPressed: () async {
//               await authService.googleSignIn();
//               Fluttertoast.showToast(
//                 msg: "Succefully Signed In with Google",
//                 toastLength: Toast.LENGTH_LONG,
//                 gravity: ToastGravity.BOTTOM,
//                 timeInSecForIosWeb: 2,
//               );

//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => MyHomePage(title: "YELLO"),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),

//     );

// }

// Container(
//         alignment: Alignment.center,
//         width: double.infinity,
//         height: 150,
//         child: Padding(
//           padding: EdgeInsets.all(1),
//           child: SignInButton(
//             Buttons.Google,
//             padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 1.0),
//             text: 'Sign in with Google',
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(40.0)),
//             onPressed: () async {
//               await authService.googleSignIn();
//               Fluttertoast.showToast(
//                 msg: "Succefully Signed In with Google",
//                 toastLength: Toast.LENGTH_LONG,
//                 gravity: ToastGravity.BOTTOM,
//                 timeInSecForIosWeb: 2,
//               );

//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => MyHomePage(title: "YELLO"),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
