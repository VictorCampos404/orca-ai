import 'package:orca_ai/core/base/status.dart';
import 'package:orca_ai/domain/usecases/usecases.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SystemController extends BaseStatus {
  final PostGeminiUsecase _postGeminiUsecase;

  SystemController(this._postGeminiUsecase) {
    reset();
  }

  reset() {}

  login() async {
    final auth = FirebaseAuth.instance;

    final response = await auth.signInWithEmailAndPassword(
      email: "admin@gmail.com",
      password: "Xx123456",
    );

    final user = auth.currentUser;

    print(user);
  }

  teste() async {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    print(user);
  }
}
