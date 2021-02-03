import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'auth.dart';
import 'firstscreen.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  auth.User user;
  // final _codeController = TextEditingController();
  // final _phoneController = TextEditingController();
  // bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
  }

  // void loginUserwithPhone(String phone, BuildContext context) async {
  //   print(phone);
  //   auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Text('Auto-verifying OTP'),
  //               SizedBox(height: 2),
  //               CircularProgressIndicator(),
  //             ],
  //           ),
  //         );
  //       });
  //   _auth.verifyPhoneNumber(
  //     phoneNumber: phone,

  //     //This would be called only if the SMS is automatically
  //     //retrieved and NOT manually entered
  //     verificationCompleted: (auth.PhoneAuthCredential credential) async {
  //       Navigator.of(context).pop();
  //       await _auth.signInWithCredential(credential).then((value) {
  //         auth.User user = value.user;

  //         if (user != null) {
  //           _isAuthenticated = true;
  //           Navigator.of(context).push(
  //             MaterialPageRoute(
  //               builder: (context) {
  //                 return PhoneFirstScreen(user: user);
  //               },
  //             ),
  //           );
  //         } else {
  //           print("Errrrrrrr");
  //         }
  //       });
  //     },
  //     verificationFailed: (auth.FirebaseAuthException exception) {
  //       print(exception);
  //     },
  //     codeSent: (String verificationId, int forceResendingToken) async {
  //       await Future.delayed(Duration(seconds: 6));
  //       if (!_isAuthenticated) {
  //         showDialog(
  //           context: context,
  //           barrierDismissible: false,
  //           builder: (context) {
  //             return AlertDialog(
  //               title: Text('Enter the OTP'),
  //               content: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   TextField(
  //                     controller: _codeController,
  //                   ),
  //                 ],
  //               ),
  //               actions: [
  //                 FlatButton(
  //                   onPressed: () async {
  //                     final code = _codeController.text.trim();
  //                     auth.AuthCredential credential =
  //                         auth.PhoneAuthProvider.credential(
  //                             verificationId: verificationId, smsCode: code);
  //                     var result = await _auth.signInWithCredential(credential);
  //                     auth.User user = result.user;

  //                     if (user != null) {
  //                       Navigator.of(context).push(
  //                         MaterialPageRoute(
  //                           builder: (context) {
  //                             return PhoneFirstScreen(user: user);
  //                           },
  //                         ),
  //                       );
  //                     } else {
  //                       print("Errrrrrrr");
  //                     }
  //                   },
  //                   child: Text('Confirm'),
  //                   textColor: Colors.white,
  //                   color: Colors.blue,
  //                 )
  //               ],
  //             );
  //           },
  //         );
  //       }
  //     },
  //     codeAutoRetrievalTimeout: (String numb) {
  //       print('##########errr#######');
  //     },
  //   );
  // }

  Widget googleLoginButton() {
    return RaisedButton(
      color: Colors.white,
      elevation: 30,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return FirstScreen();
                },
              ),
            );
          }
        });
      },
      splashColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      // borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SafeArea(
            //   child: SvgPicture.asset(
            //     'assets/Confirmed-bro.svg',
            //     fit: BoxFit.contain,
            //     height: height * 0.4,
            //   ),
            // ),
            ClipPath(
              clipper: TopCustomClipper(),
              child: Container(
                color: Colors.white,
                height: height * 0.1,
                width: width * 0.4,
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    blurRadius: 14,
                    spreadRadius: 5,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
                    child: Container(
                      height: height * 0.5,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                            width: 1.5, color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'Login With',
                              style: TextStyle(
                                  fontSize: width / 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            RaisedButton(
                              color: Colors.white.withOpacity(0.8),
                              elevation: 10,
                              onPressed: () {
                                signInWithGoogle().then((result) {
                                  if (result != null) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return FirstScreen();
                                        },
                                      ),
                                    );
                                  }
                                });
                              },
                              splashColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image(
                                        image: AssetImage(
                                            "assets/google_logo.png"),
                                        height: 35.0),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Sign in with Google',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 50),
            // googleLoginButton(),
          ],
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.white,
//         child: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               FlutterLogo(size: 150),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     labelText: 'Don\'t include +91',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                   ),
//                   controller: _phoneController,
//                 ),
//               ),
//               SizedBox(height: 16),
//               FlatButton(
//                 onPressed: () {
//                   print('+91${_phoneController.text}');
//                   loginUserwithPhone('+91${_phoneController.text}', context);
//                 },
//                 child: Text('Login'),
//                 textColor: Colors.white,
//                 color: Colors.blue,
//                 padding: EdgeInsets.all(8.0),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class TopCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
