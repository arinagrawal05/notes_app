import 'package:flutter/cupertino.dart';

class UserDataProvider with ChangeNotifier {
  String userid = "doc1";
  String name = "Arin Agrawal";
  String phone = "0987656789";
  String email = "example@gmail.com";
  String photo = "";
  bool prefferedIsGrid = true;

  void togglepref() {
    prefferedIsGrid = !prefferedIsGrid;
    notifyListeners();
  }

  void setUserData(String Guserid, String Gname, String Gemail, String Gphone,
      String Gphoto) {
    userid = Guserid;
    name = Gname;
    email = Gemail;
    phone = Gphone;
    photo = Gphoto;
    notifyListeners();
  }
}
