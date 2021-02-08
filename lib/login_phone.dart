import 'package:fireauth/fs_phone.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class LoginPhone extends StatefulWidget {
  @override
  _LoginPhoneState createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  final _codeController = TextEditingController();

  final _phoneController = TextEditingController();

  bool _isAuthenticated = false;

  //login with phone logic

  void loginUserwithPhone(String phone, BuildContext context) async {
    print(phone);

    auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Auto-verifying OTP'),
                SizedBox(height: 2),
                CircularProgressIndicator(),
              ],
            ),
          );
        });
    _auth.verifyPhoneNumber(
      phoneNumber: phone,

      //This would be called only if the SMS is automatically
      //retrieved and NOT manually entered
      verificationCompleted: (auth.PhoneAuthCredential credential) async {
        Navigator.of(context).pop();
        await _auth.signInWithCredential(credential).then((value) {
          auth.User user = value.user;

          if (user != null) {
            _isAuthenticated = true;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return PhoneFirstScreen(user: user);
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
      codeSent: (String verificationId, int forceResendingToken) async {
        await Future.delayed(Duration(seconds: 6));
        if (!_isAuthenticated) {
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
                              return PhoneFirstScreen(user: user);
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
        }
      },
      codeAutoRetrievalTimeout: (String numb) {},
    );
  }

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Don\'t include +91',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  controller: _phoneController,
                ),
              ),
              SizedBox(height: 16),
              FlatButton(
                onPressed: () {
                  print('+91${_phoneController.text}');
                  loginUserwithPhone('+91${_phoneController.text}', context);
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
