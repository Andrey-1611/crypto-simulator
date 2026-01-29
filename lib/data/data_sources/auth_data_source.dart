import 'package:crypto_simulator/data/models/app_user.dart';
import 'package:crypto_simulator/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthDataSource implements AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _google;

  AuthDataSource({required FirebaseAuth auth, required GoogleSignIn google})
    : _auth = auth,
      _google = google;

  @override
  Future<String> getUserId() async {
    return _auth.currentUser!.uid;
  }

  @override
  Future<bool> isUserAuth() async {
    return _auth.currentUser != null;
  }

  @override
  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
    final googleUser = _google.currentUser;
    if (googleUser != null) await _google.signOut();
  }

  @override
  Future<AppUser> signUp(String name, String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await credential.user?.reload();
    await credential.user!.updateDisplayName(name);
    await credential.user?.reload();
    final user = AppUser.create(credential.user!.uid, name, email);
    return user;
  }

  @override
  Future<AppUser?> signInWithGoogle() async {
    final googleUser = await _google.signIn();
    final googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final userCredential = await _auth.signInWithCredential(credential);
    final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
    final user = userCredential.user!;
    if (isNewUser) {
      await user.updateDisplayName(googleUser.displayName);
      await user.reload();
      return AppUser.create(user.uid, user.displayName!, user.email!);
    }
    return null;
  }

  @override
  Future<void> sendEmailVerification() async {
    final actionCodeSettings = ActionCodeSettings(
      url: '',
      handleCodeInApp: true,
      androidPackageName: 'com.example.crypto_simulator',
    );
    await _auth.currentUser!.sendEmailVerification(actionCodeSettings);
  }
}
