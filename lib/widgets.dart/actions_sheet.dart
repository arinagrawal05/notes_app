import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notes_app/actions.dart';
import 'package:notes_app/provider/note_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

void actionSheet(
  BuildContext context,
) {
  final provider = Provider.of<NotesDataProvider>(context, listen: false);
  // final themeProvider = Provider.of<ThemeProvider>(context);
  // List<Color> cardTheme =
  //     themeProvider.isDarkMode ? darkCardsColor : lightCardsColor;
  // EdgeInsets paddingInKeys = const EdgeInsets.symmetric(vertical: 0);
  // var random = Random();
  // var msgid = random.nextInt(10000000);
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(8),
          height: 500,
          // constraints: BoxConstraints(),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // actionTile(Icons.archive, () {}, "Archive", context),
              // actionTile(Icons.label, () {}, "Label", context),
              actionTile(Icons.delete_outline_rounded, () {
                deleteNote(context);
              }, "Delete Note", context),
              actionTile(Icons.copy, () {
                // makeDuplicate(provider, context);
                FlutterClipboard.copy(provider.note_content).then((value) {
                  // print("object");
                  // showSnackMessage(message, scaffoldKey)
                });
              }, "Copy", context),
              actionTile(Icons.copy, () {
                makeDuplicate(provider, context);
              }, "Duplicate", context),
              actionTile(Icons.share, () {
                Share.share(provider.note_content,
                    subject: provider.note_title);
              }, "Share", context),
              SizedBox(
                height: 20,
              ),
            ],
          )));
}

actionTile(
    IconData icon, Function()? ontap, String title, BuildContext context) {
  return GestureDetector(
    onTap: ontap,
    child: ListTile(
      title: Text(
        title,
      ),
      leading: Icon(icon),
      // width: MediaQuery.of(context).size.width,
      // height: 55,
      // child: Text("data")
    ),
  );
}
