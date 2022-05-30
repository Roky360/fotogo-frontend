import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Provides interaction with Google sign in API.
class GoogleSignInProvider {
  late final GoogleSignIn _googleSignIn;
  late final FirebaseAuth _auth;
  GoogleSignInAccount? _user;

  GoogleSignInProvider() {
    _googleSignIn = GoogleSignIn(scopes: const [
      // 'https://www.googleapis.com/auth/photoslibrary.appendonly'
    ]);
    _auth = FirebaseAuth.instance;
  }

  /// The current signed-in Google account.
  GoogleSignInAccount? get user => _user;

  /// The id token of the current user.
  Future<String?> get idToken async => await _auth.currentUser?.getIdToken();

  Future _login({bool silent = false}) async {
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
    } catch (e) {
      return false;
    }

    return true;
  }

  /// Performs interactive login with the Google's UI screen.
  Future login() async => await _login(silent: false);

  /// Attempts to login without user's interaction to a previously authenticated
  /// account.
  Future loginSilently() async => await _login(silent: true);

  /// Performs the logout process.
  ///
  /// Logs out from Google, and makes [user] null.
  Future logout() async {
    if (await _googleSignIn.isSignedIn()) {
      await _googleSignIn.disconnect();
      _auth.signOut();
    }
    _user = null;
  }
}
