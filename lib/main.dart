import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:notes_app/notes_home.dart';
import 'package:notes_app/provider/note_provider.dart';
import 'package:notes_app/provider/user_provider.dart';
import 'package:notes_app/something_wrong.dart';
import 'package:notes_app/provider/theme_provider.dart';
import 'package:notes_app/splash.dart';
import 'package:notes_app/widgets.dart/boarding.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  RenderErrorBox.backgroundColor = Colors.white;
  // RenderErrorBox.textStyle = GoogleFonts.ubuntu(fontWeight: FontWeight.bold);
  ErrorWidget.builder = (FlutterErrorDetails details) => SomethingWrong(
        error: details,
      );
  FlutterError.onError = (FlutterErrorDetails details) {
    if (kDebugMode) {
      print("error mil gaya $details");
    } else {
      print("noli");
    }
  };
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => ThemeProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => NotesDataProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => UserDataProvider(),
            ),
          ],
          builder: (context, _) {
            final themeProvider = Provider.of<ThemeProvider>(context);
            return MaterialApp(
              title: 'Notes App',
              themeMode: themeProvider.themeMode,
              theme: MyThemes.lightTheme,
              darkTheme: MyThemes.darkTheme,
              home: Splashscreen(),
              debugShowCheckedModeBanner: false,
            );
          });
}
