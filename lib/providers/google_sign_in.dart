import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      /*scopes: const ['https://www.googleapis.com/auth/photoslibrary.appendonly']*/);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  Future login({bool silent = false}) async {
    try {
      final GoogleSignInAccount? googleUser = silent
          ? await _googleSignIn.signInSilently()
          : await _googleSignIn.signIn();

      if (googleUser == null) return false;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
      return false;
    }

    notifyListeners();
    return true;
  }

  Future loginSilently() async => login(silent: true);

  Future logout() async {
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.disconnect();
      _auth.signOut();
    }
    _user = null;
  }
}
