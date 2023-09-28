import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/provider/note_provider.dart';
import 'package:provider/provider.dart';

deleteNote(BuildContext context) {
  final provider = Provider.of<NotesDataProvider>(context, listen: false);

  FirebaseFirestore.instance
      .collection("Users")
      .doc(provider.userid)
      .collection("Notes")
      .doc(provider.note_docId)
      .delete()
      .then((value) {
    print("Your note is deleted");
    // showSnackBar("Deleted SuccessFully");
    Navigator.pop(context);
    Navigator.pop(context);
    // showSnackMessage("Deleted",);
  }).catchError((error) {
    print("Failed to delete new note due to $error");
  });
}

makeDuplicate(NotesDataProvider provider, BuildContext context) {
  // final provider = Provider.of<NotesDataProvider>(context, listen: false);
  print(provider.note_content);
  String v1 = Random().nextInt(1000000000).toString();

  FirebaseFirestore.instance
      .collection("Users")
      .doc(provider.userid)
      .collection("Notes")
      .doc(v1)
      .set({
    'title': provider.note_title,
    'content': provider.note_content,
    "isPinned": provider.note_isPinned,
    'background_id': provider.color_id,
    'label_list': provider.note_label,
    'isArchived': provider.note_isArchived,
    "note_docId": v1,
    'timestamp': Timestamp.now(),
  }).then((value) {
    print("Your note is Duplicated and your id is $v1");
    Navigator.pop(context);
    // showSnackBar("Duplicated Succesfull");
    print("Duplication Success");
    return Future.value(true);
  }).catchError((error) {
    print("Failed to duplicate new note due to $error");
  });
}
