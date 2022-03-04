import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FUser extends ChangeNotifier {
  GoogleSignInAccount? _googleAccount;

  GoogleSignInAccount? get googleAccount => _googleAccount;

  set googleAccount(GoogleSignInAccount? newAccount) {
    _googleAccount = newAccount;
    notifyListeners();
  }

  FUser();
}