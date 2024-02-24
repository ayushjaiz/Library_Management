import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: '308811835817-bn2j2sv89o076ng4ce1n0684clge78fo.apps.googleusercontent.com',
  );

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      final credentials = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credentials);
      return userCredential;
    } catch (e) {
      print('Error occurred while signing with Google: ${e.toString()}');
      throw "Google sign-in error";
    }
  }

  Future<UserCredential?> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (e) {
      print('Error occurred while signup: ${e.toString()}');
      throw "Email sign-up error";
    }
  }

  Future<UserCredential?> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (e) {
      print('Error occurred while login: ${e.toString()}');
      throw "Email login error";
    }
  }
}
