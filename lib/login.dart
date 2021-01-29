import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'auth.dart';
import 'firstscreen.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  auth.User user;
  final _codeController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void loginUserwithPhone(String phone, BuildContext context) async {
    auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: phone,

        //This would be called only if the SMS is automatically
        //retrieved and NOT manually entered
        verificationCompleted: (auth.PhoneAuthCredential credential) async {
          // Navigator.of(context).pop();
          var result = await _auth.signInWithCredential(credential).then((value) {
            auth.User user = value.user;

          if (user != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return FirstScreen(user: user);
                },
              ),
            );
          } else {
            print("Errrrrrrr");
          }

          });
          
        },
        verificationFailed: (auth.FirebaseAuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, int forceResendingToken) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text('Enter the OTP'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _codeController,
                    ),
                  ],
                ),
                actions: [
                  FlatButton(
                    onPressed: () async {
                      final code = _codeController.text.trim();
                      auth.AuthCredential credential =
                          auth.PhoneAuthProvider.credential(
                              verificationId: verificationId, smsCode: code);
                      var result = await _auth.signInWithCredential(credential);
                      auth.User user = result.user;

                      if (user != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return FirstScreen(user: user);
                            },
                          ),
                        );
                      } else {
                        print("Errrrrrrr");
                      }
                    },
                    child: Text('Confirm'),
                    textColor: Colors.white,
                    color: Colors.blue,
                  )
                ],
              );
            },
          );
        },
        codeAutoRetrievalTimeout: (String numb) {print('##########errr#######');},);
  }

  Widget googleLoginButton() {
    return OutlineButton(
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
      borderSide: BorderSide(color: Colors.grey),
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       color: Colors.white,
//       child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             FlutterLogo(size: 150),
//             SizedBox(height: 50),
//             googleLoginButton(),
//           ],
//         ),
//       ),
//     ));
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              TextField(
                controller: _phoneController,
              ),
              SizedBox(height: 16),
              FlatButton(
                onPressed: () {
                  loginUserwithPhone(_phoneController.text, context);
                },
                child: Text('Login'),
                textColor: Colors.white,
                color: Colors.blue,
                padding: EdgeInsets.all(8.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
