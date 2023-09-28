import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/provider/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({super.key});

  setprefab(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("ThemeSettings", theme);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return CupertinoSwitch(
      activeColor: Theme.of(context).colorScheme.secondary,
      // return Switch.adaptive(
      // activeColor: Colors.black,
      // inactiveThumbColor: Colors.amber,
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
        if (value == true) {
          setprefab("dark");
        } else {
          setprefab("light");
        }
      },
    );
  }
}
