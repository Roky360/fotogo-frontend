import 'package:fotogo/auth/user/user_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProvider {
  final UserRepository _userRepository = UserRepository(null);

  static final UserProvider _userProvider = UserProvider._();

  UserProvider._();

  factory UserProvider() => _userProvider;

  String get id => _userRepository.googleSignInAccount!.id;

  String get email => _userRepository.googleSignInAccount!.email;

  String? get displayName => _userRepository.googleSignInAccount!.displayName;

  String? get photoUrl => _userRepository.googleSignInAccount!.photoUrl;

  Future<String> get idToken async =>
      await _userRepository.auth.currentUser!.getIdToken();

  bool get isSignedIn => _userRepository.googleSignInAccount != null;

  void signIn(GoogleSignInAccount account) =>
      _userRepository.googleSignInAccount = account;

  void signOut() => _userRepository.googleSignInAccount = null;
}
