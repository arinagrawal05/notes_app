import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class SomethingWrong extends StatefulWidget {
  FlutterErrorDetails? error;
  SomethingWrong({this.error});
  @override
  _SomethingWrongState createState() => _SomethingWrongState();
}

class _SomethingWrongState extends State<SomethingWrong> {
  @override
  void initState() {
    super.initState();
    // getprefab();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(width: 2, color: Theme.of(context).hintColor)),
              child: Icon(
                Ionicons.trending_up,
                size: 70,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Text(
                "Something Went Wrong",
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "there is an issue on our end and you can navigate back. Please try again later.",
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(
                    fontSize: 14, color: Colors.grey.shade400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "there is ${widget.error!.library}",
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(
                    fontSize: 14, color: Colors.grey.shade400),
              ),
            ),
          ]),
    ));
  }
}
