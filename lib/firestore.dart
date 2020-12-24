import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireauth/auth.dart';

String dat = "Hello";
Future<String> getStr() async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  print(newUser.uid);
  users
      .doc(newUser.uid)
      .set({"def": "You are " + newUser.displayName + " "})
      .then((value) => print("Added new user"))
      .catchError((onError) => print("Err"));

  users.doc(newUser.uid).get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      dat = documentSnapshot.data()['def'].toString();
      return dat;

    } 
    else {
      dat = "Nope";
      print(dat);
    }

  }).catchError((onError) => print("Err"));
  print(dat);

  return dat;
  // }
  // DocumentSnapshot ds = await users.doc(newUser.uid).get();

  // Map<String, dynamic> map = ds.data();
  // return await map['data'];
}
