import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth get auth => FirebaseAuth.instance;

  User? get user => auth.currentUser;

  bool get isLogged => user != null;

  Stream<User?> get authChanges => auth.authStateChanges();

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> createAccount({
    required String email,
    required String password,
  }) async {
    return await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> resetPasswordByEmail({required String email}) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateName({required String name}) async {
    await user?.updateDisplayName(name);
  }

  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );

    await user?.reauthenticateWithCredential(credential);
    await user?.delete();
    await auth.signOut();
  }

  Future<void> resetPasswordByOldPassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: oldPassword,
    );

    await user?.reauthenticateWithCredential(credential);
    await user?.delete();
    await user?.updatePassword(newPassword);
  }
}
