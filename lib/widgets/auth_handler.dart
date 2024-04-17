import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the user credential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Map<String, String?> getMapUserInfo() {
  Map<String, String?> userInfo = {};
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    userInfo = {
      'uid': user.uid,
      'email': user.email,
    };
  }
  return userInfo;
}

Future<String?> getFirebaseTokenID() async {
  String? token;
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    token = await user.getIdToken();
  }
  return token;
}