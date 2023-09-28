import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Future> navigateslide(
  Widget pagename,
  BuildContext context,
) async {
  return Navigator.push(
    context,
    PageTransition(
      type: PageTransitionType.rightToLeft,
      child: pagename,
    ),
  );
}

Future<Future> navigatedirect(Widget pagename, BuildContext context,
    {isFade = false}) async {
  return Navigator.pushReplacement(
    context,
    PageTransition(
      type: isFade ? PageTransitionType.fade : PageTransitionType.size,
      child: pagename,
    ),
  );
}

// showSnackBar(String message) {
//   return Get.showSnackbar(GetSnackBar(
//     message: message,
//     duration: const Duration(seconds: 5),
//   ));
// }
userAddToFirebase(User userDetails) {
  FirebaseFirestore.instance
      .collection("Users")
      .where("userid", isEqualTo: userDetails.uid)
      .get()
      .then((value) {
    if (value.docs.isEmpty) {
      FirebaseFirestore.instance.collection("Users").doc(userDetails.uid).set({
        "name": userDetails.displayName ?? "",
        "email": userDetails.email ?? "",
        "phone": userDetails.phoneNumber ?? "",
        "userimg": userDetails.photoURL ?? "",
        "userid": userDetails.uid,
        // "creationTime": userDetails.metadata.creationTime ?? "",
        // "lastSignInTime": userDetails.metadata ?? "",
        "userHashCode": userDetails.hashCode ?? "",
        "timestamp": DateTime.now(),
      });
      String v1 = Random().nextInt(1000000000).toString();

      FirebaseFirestore.instance
          .collection("Users")
          .doc(userDetails.uid)
          .collection("Notes")
          .doc(v1)
          .set({
        'title': "This is Sample Title",
        'content': "You can write your sample content here",
        "isPinned": true,
        'background_id': 2,
        'label_list': [],
        'isArchived': false,
        "note_docId": v1,
        'timestamp': Timestamp.now(),
      });
    } else {
      print("this is existing user");
    }
  });
}
// launchURL(String url) async {
//   // const url = 'https://flutter.dev';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// callNumber(String number) async {
//   print("Called");
//   bool? res = await FlutterPhoneDirectCaller.callNumber(number);
// }

setprefab(
  bool isLogged,
  String userid,
  String name,
  String email,
  String photo,
  String phone,
) async {
  print(userid);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("userid", userid.toString());
  prefs.setString("name", name);
  prefs.setString("phone", phone);
  prefs.setString("photo", photo);
  prefs.setString("email", email.toString());
  prefs.setBool("isLogged", isLogged);
}
