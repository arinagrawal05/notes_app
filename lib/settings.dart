import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notes_app/function.dart';
import 'package:notes_app/provider/note_provider.dart';
import 'package:notes_app/provider/user_provider.dart';
import 'package:notes_app/services/google_sign.dart';
import 'package:notes_app/widgets.dart/components.dart';
import 'package:notes_app/widgets.dart/theme_toggle.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<UserDataProvider>(context, listen: true);

    // final provider = Provider.of<ThemeProvider>(context, listen: true);
    // ThemeMode current = provider.getCurrentThemes();

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: CircleAvatar(
                              backgroundImage: NetworkImage(noteProvider.photo),
                              radius: 40),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              noteProvider.name,
                              style: GoogleFonts.montserrat(fontSize: 24),
                            ),
                            Text(
                              noteProvider.email,
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // appNameWidget(),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dark Mode',
                          style: GoogleFonts.nunito(fontSize: 20),
                        ),
                        const ChangeThemeButtonWidget(),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Log Out',
                          style: GoogleFonts.nunito(fontSize: 20),
                        ),
                        appBarIcon(Ionicons.log_out_outline, () {
                          AuthMethods().signOut(context);
                        })
                      ],
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
