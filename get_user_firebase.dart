import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetCurrentUser extends StatelessWidget {
  GetCurrentUser({super.key});

  final _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    //get current user method
    void createUserInFirestore() {
      users
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
          .limit(1)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isEmpty) {
          users.add({
            'name': _text,
            'uid': FirebaseAuth.instance.currentUser.uid,
            'phone': FirebaseAuth.instance.currentUser.phoneNumber,
          });
        }
      }).catchError((error) {});
    }

    return Container();
  }
}
