import 'dart:async';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:notes_app/function.dart';
import 'package:notes_app/notes_home.dart';
import 'package:notes_app/provider/theme_provider.dart';
import 'package:notes_app/provider/user_provider.dart';
import 'package:notes_app/style.dart';
import 'package:notes_app/widgets.dart/boarding.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  bool islogged = false;

  String theme = "light";
  String userid = "";

  String name = "";
  String email = "";
  String photo = "";
  String phone = "";
  User? user = FirebaseAuth.instance.currentUser;
  @override
  initState() {
    super.initState();
    getprefab();
    // navigatedirect("pagename", context);
    navigate();
  }

  navigate() {
    Timer(const Duration(seconds: 2), () {
      if (islogged) {
        navigateslide(
          NotesHomePage(),
          context,
        );
      } else {
        navigateslide(
          const BoardingScreen(),
          context,
        );
      }
    });
  }

  getprefab() async {
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        userid = prefs.getString("userid") ?? "light";
        name = prefs.getString("name") ?? "name";
        email = prefs.getString("email") ?? "email";
        phone = prefs.getString("phone") ?? "phone";
        photo = prefs.getString("photo") ?? "photo";

        islogged = prefs.getBool("isLogged") ?? false;
        theme = prefs.getString("ThemeSettings") ?? "light";
      });
      userProvider.setUserData(userid, name, email, phone, photo);
    }
    if (theme == "light") {
      themeProvider.toggleTheme(false);
    } else {
      themeProvider.toggleTheme(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // margin: EdgeInsets.symmetric(
        //   vertical: MediaQuery.of(context).size.height * 0.15,
        // ),
        child: Center(
          child: Text(
            "Notes App",
            style: AppStyle.mainTitle.copyWith(fontSize: 32),
          ),
        ),
      ),
    );
  }
}
