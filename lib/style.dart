import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<Color> darkCardsColor = const [
  Color.fromRGBO(91, 43, 41, 1),
  Color.fromRGBO(97, 74, 25, 1),
  Color.fromRGBO(99, 93, 25, 1),
  Color.fromRGBO(52, 89, 32, 1),
  Color.fromRGBO(22, 80, 75, 1),
  Color.fromRGBO(45, 85, 94, 1),
  Color.fromRGBO(30, 58, 95, 1),
  Color.fromRGBO(66, 39, 94, 1),
  Color.fromRGBO(91, 34, 69, 1),
  Color.fromRGBO(68, 47, 25, 1),
  Color.fromRGBO(60, 63, 67, 1),

  // 60,63,67
];

List<Color> lightCardsColor = const [
  Color.fromRGBO(242, 139, 130, 1),
  Color.fromRGBO(251, 188, 4, 1),
  Color.fromRGBO(255, 244, 117, 1),
  Color.fromRGBO(204, 255, 144, 1),
  Color.fromRGBO(167, 255, 235, 1),
  Color.fromRGBO(203, 240, 248, 1),
  Color.fromRGBO(174, 203, 250, 1),
  Color.fromRGBO(215, 174, 251, 1),
  Color.fromRGBO(253, 207, 232, 1),
  Color.fromRGBO(242, 139, 130, 1),
  Color.fromRGBO(232, 234, 237, 1),
];
List<String> darkCardsBg = [
  "https://i.pinimg.com/564x/b7/ec/44/b7ec44e442e8d41a91e9830e526bedd7.jpg",
  "https://i.pinimg.com/564x/66/6d/2b/666d2b70edde3173c888c5646378d344.jpg",
  "https://i.pinimg.com/564x/cc/38/1a/cc381af816daee2cd7d3a0e39ada1293.jpg",
  "https://i.pinimg.com/564x/fc/39/f1/fc39f17763a892047a5b8eab221bbd71.jpg",
  "https://i.pinimg.com/236x/c0/2d/be/c02dbec373b9d2bedebbf17b647626a5.jpg",
  "https://i.pinimg.com/564x/0e/2d/b6/0e2db63cd1f795ff7b4c19b79432b502.jpg",
  "https://i.pinimg.com/236x/83/e9/46/83e9469308fa911fcc8d39a2fb6624e4.jpg",
  "https://i.pinimg.com/236x/12/cf/d3/12cfd35fb95ed7cd85627fa3a4293a4b.jpg",
  "https://i.pinimg.com/236x/f9/d4/6a/f9d46afbcef0d64d5288dcf0423f9fd2.jpg",
  "https://i.pinimg.com/236x/a7/df/ac/a7dfacfb122e95be311707a298f0912f.jpg"
];

List<String> lightCardsBg = [
  "https://i.pinimg.com/564x/b7/ec/44/b7ec44e442e8d41a91e9830e526bedd7.jpg",
  "https://i.pinimg.com/564x/66/6d/2b/666d2b70edde3173c888c5646378d344.jpg",
  "https://i.pinimg.com/564x/cc/38/1a/cc381af816daee2cd7d3a0e39ada1293.jpg",
  "https://i.pinimg.com/564x/fc/39/f1/fc39f17763a892047a5b8eab221bbd71.jpg",
  "https://i.pinimg.com/236x/c0/2d/be/c02dbec373b9d2bedebbf17b647626a5.jpg",
  "https://i.pinimg.com/564x/0e/2d/b6/0e2db63cd1f795ff7b4c19b79432b502.jpg",
  "https://i.pinimg.com/236x/83/e9/46/83e9469308fa911fcc8d39a2fb6624e4.jpg",
  "https://i.pinimg.com/236x/12/cf/d3/12cfd35fb95ed7cd85627fa3a4293a4b.jpg",
  "https://i.pinimg.com/236x/f9/d4/6a/f9d46afbcef0d64d5288dcf0423f9fd2.jpg",
  "https://i.pinimg.com/236x/a7/df/ac/a7dfacfb122e95be311707a298f0912f.jpg"
];
Color getBgColor(int number, List<Color> cardTheme) {
  Color cardC;
  if (number > 10) {
    cardC = Colors.pink;
  } else {
    cardC = cardTheme[number];
  }
  return cardC;
}

class AppStyle {
  static Color bgColor = const Color(0xFFe2e2fe);
  static Color mainColor = Color.fromRGBO(44, 43, 49, 1);
  static Color accentColor = const Color(0xFF0065FF);

  static TextStyle mainTitle = GoogleFonts.lato(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );
  static TextStyle mainContent = GoogleFonts.lato(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
  );

  static TextStyle dateTitle =
      GoogleFonts.lato(fontSize: 13.0, fontWeight: FontWeight.w500);
}
