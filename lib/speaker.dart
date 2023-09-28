import 'package:flutter_tts/flutter_tts.dart';

double volume = 1.0;
double pitch = 1.0;
double speechRate = 0.5;
List<String>? languages;
String langCode = "en-US";
void initSetting(FlutterTts flutterTts) async {
  await flutterTts.setVolume(volume);
  await flutterTts.setPitch(pitch);
  await flutterTts.setSpeechRate(speechRate);
  await flutterTts.setLanguage(langCode);
}

void speak(String words, FlutterTts flutterTts) async {
  initSetting(flutterTts);
  await flutterTts.speak(words);
}

void _stop(FlutterTts flutterTts) async {
  await flutterTts.stop();
}
