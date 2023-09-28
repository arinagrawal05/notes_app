import 'dart:math';

import 'package:flutter/cupertino.dart';

class NotesDataProvider with ChangeNotifier {
  String userid = "doc1";
  String note_title = "";
  String note_content = "";
  String note_docId = "";
  List note_label = [];
  bool note_isPinned = false;
  bool note_isArchived = false;
  int color_id = 2;

  void setColorID(int value) {
    color_id = value;
    notifyListeners();
  }

  void setuserid(String value) {
    userid = value;
    notifyListeners();
  }

  void setisPinned(bool isPinned) {
    note_isPinned = isPinned;
    notifyListeners();
  }

  void setNewNote() {
    String v1 = Random().nextInt(1000000000).toString();

    note_docId = v1;
    note_title = "";
    note_content = "";
    note_label = [];
    note_isPinned = false;
    note_isArchived = false;
    color_id = 2;
    notifyListeners();
  }

  void setNotesData(String title, String content, List label, bool isPinned,
      bool isArchived, int colorId, String docId) {
    note_title = title;
    note_content = content;
    note_label = label;
    note_isPinned = isPinned;
    note_isArchived = isArchived;
    color_id = colorId;
    note_docId = docId;

    notifyListeners();
  }
}
