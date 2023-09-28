import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  String title;
  String content;
  String docId;

  bool isPinned;
  int bgId;
  List label;
  bool isArchived;
  Timestamp timestamp;

  NotesModel({
    required this.title,
    required this.content,
    required this.isPinned,
    required this.bgId,
    required this.label,
    required this.docId,
    required this.isArchived,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'isPinned': isPinned,
      'background_id': bgId,
      'label': label,
      'note_docId': docId,
      'timestamp': timestamp,
      'isArchived': isArchived,
    };
  }

  factory NotesModel.fromFirestore(DocumentSnapshot doc) {
    dynamic map = doc.data();

    return NotesModel(
      // id: map['id'];
      title: map['title'],
      content: map['content'],
      docId: map['note_docId'],
      isPinned: map['isPinned'],
      label: map['label_list'],
      bgId: map['background_id'],
      timestamp: map['timestamp'],
      isArchived: map['isArchived'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotesModel.fromJson(String source) =>
      NotesModel.fromFirestore(json.decode(source));
}
