import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/create_notes.dart';
import 'package:notes_app/function.dart';
import 'package:notes_app/notes_model.dart';
import 'package:notes_app/provider/note_provider.dart';
import 'package:notes_app/style.dart';
import 'package:notes_app/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class NoteListCardComponent extends StatelessWidget {
  const NoteListCardComponent({
    required this.model,
  });

  final NotesModel model;
  @override
  Widget build(BuildContext context) {
    // int color_id = Random().nextInt(AppStyle.cardsColor.length);
    // model.bgId = color_id;
    final provider = Provider.of<NotesDataProvider>(context, listen: true);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    List<Color> cardTheme =
        themeProvider.isDarkMode ? darkCardsColor : lightCardsColor;
    String neatDate =
        DateFormat.yMd().add_jm().format(model.timestamp.toDate());
    // Color color = colorList.elementAt(model.title.length % colorList.length);
    // return Container();
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        print("object");
        provider.setNotesData(model.title, model.content, model.label,
            model.isPinned, model.isArchived, model.bgId, model.docId);
        navigateslide(CreateNotesPage(model: model), context);

        // onTapAction(noteData);
      },
      // splashColor: getBgColor(model.bgId, cardTheme).withAlpha(20),
      // highlightColor: getBgColor(model.bgId, cardTheme).withAlpha(10),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
        decoration: model.bgId <= 10
            ? BoxDecoration(
                color: cardTheme[model.bgId],
                borderRadius: BorderRadius.circular(16),
                // boxShadow: [buildBoxShadow(getBgColor(model.bgId), context)],
              )
            : BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    darkCardsBg[model.bgId - 10],
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${model.title.trim().length <= 20 ? model.title.trim() : model.title.trim().substring(0, 20) + '...'}',
                style: GoogleFonts.actor(
                  fontSize: 20,
                  fontWeight:
                      model.isPinned ? FontWeight.w800 : FontWeight.normal,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Text(
                  '${model.content.trim().split('\n').first.length <= 80 ? model.content.trim().split('\n').first : model.content.trim().split('\n').first.substring(0, 80) + '...'}',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 14),
                alignment: Alignment.centerRight,
                child: Row(
                  children: [
                    model.isPinned
                        ? Icon(
                            Icons.push_pin,
                            size: 16,
                          )
                        : Container(),
                    Spacer(),
                    Text(
                      '$neatDate',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade300,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  BoxShadow buildBoxShadow(Color color, BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return BoxShadow(
          color: model.isPinned == true
              ? Colors.black.withAlpha(100)
              : Colors.black.withAlpha(10),
          blurRadius: 8,
          offset: Offset(0, 8));
    }
    return BoxShadow(
        color:
            model.isPinned == true ? color.withAlpha(60) : color.withAlpha(25),
        blurRadius: 8,
        offset: Offset(0, 8));
  }
}
