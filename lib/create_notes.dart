import 'dart:math';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notes_app/provider/user_provider.dart';
import 'package:notes_app/services/google_sign.dart';

import 'package:notes_app/provider/note_provider.dart';
import 'package:notes_app/services/google_sign.dart';
import 'package:notes_app/widgets.dart/actions_sheet.dart';
import 'package:notes_app/widgets.dart/components.dart';
import 'package:notes_app/speaker.dart';
import 'package:notes_app/provider/theme_provider.dart';
import 'package:notes_app/widgets.dart/theme_sheet.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:notes_app/notes_model.dart';
import 'package:notes_app/style.dart';

class CreateNotesPage extends StatefulWidget {
  late NotesModel? model;
  CreateNotesPage({super.key, required this.model});

  @override
  State<CreateNotesPage> createState() => _CreateNotesPageState();
}

class _CreateNotesPageState extends State<CreateNotesPage> {
  FlutterTts flutterTts = FlutterTts();

  // ignore: non_constant_identifier_names
  int color_id = Random().nextInt(darkCardsColor.length) + 10;
  late bool isPinned = false;

  String date = DateTime.now().toString();
  List labelList = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void initSpeaker() async {
    languages = List<String>.from(await flutterTts.getLanguages);
    if (mounted) {
      setState(() {});
    }
  }

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text =
      'Press the button and start speaking You know on the personal level I dont....ow that you are in the gate job do it';
  Timestamp timeModified = Timestamp.now();
  autofil() {
    if (widget.model != null) {
      _titleController.text = widget.model!.title;
      _contentController.text = widget.model!.content;
      color_id = widget.model!.bgId;
      isPinned = widget.model!.isPinned;
      timeModified = widget.model!.timestamp;
      labelList = widget.model!.label;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    autofil();
    initSpeaker();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserDataProvider>(context);

    final notesProvider = Provider.of<NotesDataProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    List<Color> cardTheme =
        themeProvider.isDarkMode ? darkCardsColor : lightCardsColor;
    String neatDate = DateFormat.yMd().add_jm().format(widget.model == null
        ? Timestamp.now().toDate()
        : widget.model!.timestamp.toDate());

    return WillPopScope(
      onWillPop: () {
        print(notesProvider.color_id);
        autosave(notesProvider.color_id, notesProvider.note_docId,
            userProvider.userid);
        throw Exception('No return value');
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        // backgroundColor: cardsColor[color_id],
        appBar: AppBar(
          title: Text("Note"),
          backgroundColor: Colors.transparent,
          actions: [
            appBarIcon(
                isPinned ? Icons.push_pin_rounded : Icons.push_pin_outlined,
                () {
              isPinned = !isPinned;
              notesProvider.setisPinned(isPinned);
            }),
          ],
        ),

        body: Container(
          decoration: notesProvider.color_id <= 10
              ? BoxDecoration(
                  color: cardTheme[notesProvider.color_id],
                )
              : BoxDecoration(
                  image: DecorationImage(
                    image:
                        NetworkImage(darkCardsBg[notesProvider.color_id - 10]),
                    fit: BoxFit.cover,
                  ),
                ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                      // hintStyle: TextStyle(
                      //   color: Colors.white,
                      // ),
                      // counterStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      hintText: 'Note Title'),
                  style: AppStyle.mainTitle,
                ),
                const SizedBox(
                  height: 35.0,
                ),
                TextField(
                  controller: _contentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 8,
                  // minLines: 4,
                  decoration: const InputDecoration(
                      helperStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      hintText: 'Note Content'),
                  style: AppStyle.mainContent,
                ),
              ],
            ),
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: floatingButton(_isListening, context),
        bottomNavigationBar: bottomBar(context, neatDate),
      ),
    );
  }

  void _listen() async {
    var error;
    print("Listeing Start");
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) {
          error = val.errorMsg;
          print('onError: $val');
        },
      );
      print(error.toString() + " ddd");
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _titleController.text = val.recognizedWords;

            print(_text);
          }),
        );
      }
    } else {
      if (mounted) {
        setState(() => _isListening = false);
        _speech.stop();
      }
    }
  }

  Future<bool>? autosave(int colorId, noteId, String userid) {
    _speech.cancel();
    _contentController.dispose();
    _titleController.dispose();

    if (_titleController.text.isNotEmpty ||
        _contentController.text.isNotEmpty) {
      if (widget.model != null) {
        Timestamp editedTime = widget.model!.timestamp;
        if (_titleController.text != widget.model!.title ||
            _contentController.text != widget.model!.content) {
          editedTime = Timestamp.now();
        }
        print("existing happening");

        FirebaseFirestore.instance
            .collection("Users")
            .doc(userid)
            .collection("Notes")
            .doc(widget.model!.docId)
            .update({
          'title': _titleController.text,
          'content': _contentController.text,
          "isPinned": isPinned,
          'background_id': colorId,
          'label_list': [],
          'timestamp': editedTime,
        }).then((value) {
          print("Your note is updated and your id is same");
          Navigator.pop(context);

          return Future.value(true);
        }).catchError((error) {
          print("Failed to add new note due to $error");

          return Future.value(false);
        });
      } else {
        print("new happening");

        FirebaseFirestore.instance
            .collection("Users")
            .doc(userid)
            .collection("Notes")
            .doc(noteId)
            .set({
          'title': _titleController.text,
          'content': _contentController.text,
          "isPinned": isPinned,
          "isArchived": false,
          'background_id': color_id,
          'label_list': [],
          "note_docId": noteId,
          'timestamp': Timestamp.now(),
        }).then((value) {
          print("Your note is saved and your id is $noteId");
          Navigator.pop(context);

          return Future.value(true);
        }).catchError((error) {
          print("Failed to add new note due to $error");

          return Future.value(false);
        });
      }
    } else {
      print("Card Discarded");
      Navigator.pop(context);

      return Future.value(true);
    }
    return Future.value(true);
  }
}

Widget floatingButton(bool _isListening, BuildContext context) {
  return AvatarGlow(
    animate: _isListening,
    glowColor: Theme.of(context).primaryColor,
    endRadius: 75.0,
    duration: const Duration(milliseconds: 2000),
    repeatPauseDuration: const Duration(milliseconds: 100),
    repeat: true,
    child: FloatingActionButton(
      onPressed: () {
        // showSnackBar("message");
        // actionSheet(context);
        // speak(_contentController.text, flutterTts);
      },
      child: Icon(Icons.speaker),

      // child: Icon(_isListening ? Icons.mic : Icons.mic_none),
    ),
  );
}

Widget bottomBar(BuildContext context, String neatDate) {
  return Container(
    color: Theme.of(context).canvasColor.withOpacity(0.1),
    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        appBarIcon(Ionicons.color_palette, () {
          chooseTheme(context);
        }),
        Text(
          "Edited " + neatDate,
          style: AppStyle.dateTitle,
        ),
        appBarIcon(Ionicons.menu_outline, () {
          actionSheet(context);
        })
      ],
    ),
  );
}
