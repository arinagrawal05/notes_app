import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notes_app/provider/note_provider.dart';
import 'package:notes_app/provider/user_provider.dart';
import 'package:notes_app/settings.dart';
import 'package:notes_app/widgets.dart/components.dart';
import 'package:notes_app/create_notes.dart';
import 'package:notes_app/function.dart';
import 'package:notes_app/widgets.dart/note_widget.dart';
import 'package:notes_app/notes_model.dart';
import 'package:notes_app/style.dart';
import 'package:notes_app/provider/theme_provider.dart';
import 'package:notes_app/widgets.dart/theme_toggle.dart';
import 'package:provider/provider.dart';

class NotesHomePage extends StatefulWidget {
  const NotesHomePage({Key? key});

  @override
  _NotesHomePageState createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {
  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NotesDataProvider>(context, listen: true);

    final userProvider = Provider.of<UserDataProvider>(context, listen: true);
    // final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: header(userProvider),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 20.0),
              streamNotes(userProvider),
              // provider.prefferedIsGrid ? notesgridRender() : notesListRender(),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // navigateslide(SettingScreen(), context);
          noteProvider.setNewNote();
          navigateslide(CreateNotesPage(model: null), context);
        },
        label: const Text("Add Note"),
        icon: const Icon(Ionicons.reader_outline),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> streamNotes(
      UserDataProvider provider) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Users")
          .doc(provider.userid)
          .collection("Notes")
          // .where("isArchived", isEqualTo: false)
          .orderBy("isPinned", descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          // return Text("data");
          return provider.prefferedIsGrid
              ? gridbuilder(snapshot)
              : listBuilder(snapshot);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  PreferredSizeWidget header(UserDataProvider provider) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Container(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).canvasColor,
          ),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              appBarIcon(Ionicons.settings_outline, () {
                navigateslide(SettingScreen(), context);
              }),
              Text(provider.name),
              Spacer(),
              appBarIcon(
                  provider.prefferedIsGrid
                      ? Ionicons.grid_outline
                      : Ionicons.list, () {
                provider.togglepref();
              }),
              CircleAvatar(
                backgroundImage: NetworkImage(provider.photo),
              )
            ],
          )),
      // actions: [
      //   appBarIcon(
      //       provider.prefferedIsGrid ? Ionicons.grid_outline : Ionicons.list,
      //       () {
      //     provider.togglepref();
      //   }),
      //   CircleAvatar(
      //     backgroundImage: NetworkImage(provider.photo),
      // )
      // ],
    );
  }
}

Widget gridbuilder(AsyncSnapshot snapshot) {
  return
      //  Text("data");
      MasonryGridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),

    gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2),
    itemCount: snapshot.data!.docs.length,
    itemBuilder: (context, index) {
      return
          // Text("data");
          NoteListCardComponent(
        model: NotesModel.fromFirestore(
          snapshot.data!.docs[index],
        ),
      );
    },
    // staggeredTileBuilder: (index) => StaggeredTile.count(1, 1),
    mainAxisSpacing: 0.0,
    crossAxisSpacing: 0.0,
  );
}

Widget listBuilder(AsyncSnapshot snapshot) {
  return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        // return Text("erfdfv");
        return NoteListCardComponent(
          model: NotesModel.fromFirestore(snapshot.data!.docs[index]),
        );
      });
}
