import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneFirstScreen extends StatefulWidget {
  final User user;

  PhoneFirstScreen({this.user});
  @override
  _PhoneFirstScreenState createState() => _PhoneFirstScreenState();
}

class _PhoneFirstScreenState extends State<PhoneFirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
      ),
      body: Center(
        child:
            Text('Success! Logged in number is : ${widget.user.phoneNumber}'),
      ),
    );
  }
}
