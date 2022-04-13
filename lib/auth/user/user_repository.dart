import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  late GoogleSignInAccount? googleSignInAccount;
  FirebaseAuth get auth => FirebaseAuth.instance;

  UserRepository(this.googleSignInAccount);
}
