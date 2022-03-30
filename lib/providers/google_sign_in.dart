import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      /*scopes: const ['https://www.googleapis.com/auth/photoslibrary.appendonly']*/);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  Future<String?> get idToken async => await _auth.currentUser?.getIdToken();

  Future login({bool silent = false}) async {
    try {
      final GoogleSignInAccount? googleUser = silent
          ? await _googleSignIn.signInSilently()
          : await _googleSignIn.signIn();

      if (googleUser == null) return false;
      _user = googleUser;

      if (silent) return true;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);


      final tkn = await _auth.currentUser?.getIdToken();
      log(tkn!);
    } catch (e) {
      throw e.toString();
      return false;
    }

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
