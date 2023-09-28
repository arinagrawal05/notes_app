import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notes_app/provider/note_provider.dart';
import 'package:notes_app/style.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

void chooseTheme(
  BuildContext context,
) {
  final provider = Provider.of<NotesDataProvider>(context, listen: false);
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  List<Color> colorCardTheme =
      themeProvider.isDarkMode ? darkCardsColor : lightCardsColor;
  List<String> bGCardTheme =
      themeProvider.isDarkMode ? darkCardsBg : lightCardsBg;
  int current =
      provider.color_id <= 10 ? provider.color_id : (provider.color_id - 10);
  // final themeProvider = Provider.of<ThemeProvider>(context);
  // List<Color> cardTheme =
  //     themeProvider.isDarkMode ? darkCardsColor : lightCardsColor;
  // EdgeInsets paddingInKeys = const EdgeInsets.symmetric(vertical: 0);
  // var random = Random();
  // var msgid = random.nextInt(10000000);
  showModalBottomSheet(
      elevation: 2,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(8),
          height: 250,
          // constraints: BoxConstraints(),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "  Color",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              colorChooseRender(colorCardTheme, provider, current, context),
              SizedBox(
                height: 20,
              ),
              Text(
                "Background",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              bGChooseRender(bGCardTheme, provider, current, context),
              SizedBox(
                height: 20,
              ),
            ],
          )));
}

bGChooseRender(List<String> cardTheme, NotesDataProvider provider, int current,
    BuildContext context) {
  return Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          itemCount: cardTheme.length,
          itemBuilder: (context, index) {
            return bGPallete(
                cardTheme[index], index, cardTheme[current], context, provider);
          }));
  ;
}

Widget colorChooseRender(List<Color> cardTheme, NotesDataProvider provider,
    int current, BuildContext context) {
  return Container(
      width: MediaQuery.of(context).size.width,
      height: 55,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          itemCount: cardTheme.length,
          itemBuilder: (context, index) {
            return colorPallete(
                cardTheme[index], index, cardTheme[current], context, provider);
          }));
}

Widget colorPallete(Color cardTheme, int index, Color currentColor,
    BuildContext context, NotesDataProvider provider) {
  return AspectRatio(
    aspectRatio: 1,
    child: GestureDetector(
      onTap: () {
        provider.setColorID(index);
      },
      child: Container(
        margin: EdgeInsets.all(5),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            border: cardTheme == currentColor
                ? Border.all(width: 3, color: Colors.grey)
                : const Border(),
            borderRadius: BorderRadius.circular(50),
            color: cardTheme),
        child:
            cardTheme == currentColor ? const Icon(Icons.check) : Container(),
      ),
    ),
  );
}

Widget bGPallete(String cardTheme, int index, String currentColor,
    BuildContext context, NotesDataProvider provider) {
  return AspectRatio(
    aspectRatio: 1,
    child: GestureDetector(
      onTap: () {
        print("object");
        provider.setColorID(index + 10);
      },
      child: Container(
        margin: EdgeInsets.all(5),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            border: cardTheme == currentColor
                ? Border.all(width: 3, color: Colors.grey)
                : const Border(),
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
                image: NetworkImage(cardTheme), fit: BoxFit.cover)),
        child:
            cardTheme == currentColor ? const Icon(Icons.check) : Container(),
      ),
    ),
  );
}
