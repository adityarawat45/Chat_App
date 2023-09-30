import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class API {
  FirebaseAuth auth = FirebaseAuth.instance;

  void SignOut() async {
    await auth.signOut();
    GoogleSignIn().signOut();
  }
}
