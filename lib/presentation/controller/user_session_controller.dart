import 'package:flutter/widgets.dart';
import 'package:orca_ai/core/base/status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:orca_ai/core/enums/status.dart';
import 'package:orca_ai/core/models/request_result.dart';
import 'package:orca_ai/services/firebase_auth_service.dart';

class UserSessionController extends BaseStatus {
  final FirebaseAuthService _firebaseAuthService;

  late TextEditingController emailCtrl;
  late TextEditingController passwordCtrl;

  bool get isButtonLoginEnable =>
      emailCtrl.text.isNotEmpty && passwordCtrl.text.isNotEmpty;

  Stream<User?> get authChanges => _firebaseAuthService.authChanges;

  UserSessionController(this._firebaseAuthService) {
    reset();
  }

  reset() {
    emailCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
  }

  Future<RequestResult> login() async {
    setStatus(Status.loading);

    try {
      await _firebaseAuthService.signIn(
        email: emailCtrl.text,
        password: passwordCtrl.text,
      );

      setStatus(Status.success);
      return RequestResult(status: true);
    } catch (error) {
      setStatus(Status.error);
      if (error is FirebaseAuthException) {
        if (error.code == "network-request-failed") {
          return RequestResult(
            status: false,
            title: "Erro de Internet",
            message: "Você não está conectado à rede",
          );
        } else if (error.code == "invalid-credential" ||
            error.code == "user-not-found") {
          return RequestResult(
            status: false,
            title: "Erro ao fazer login!",
            message: "Senha incorreta ou usuário não encontrado.",
          );
        } else if (error.code == "invalid-email") {
          return RequestResult(
            status: false,
            title: "Email inválido!",
            message: "Digite um email valido",
          );
        }
      }

      return RequestResult(
        status: false,
        title: "Erro inesperado!",
        message:
            "Algo inesperado aconteceu, espere alguns minutos e tente novamente",
      );
    }
  }

  Future<RequestResult> signOut() async {
    await _firebaseAuthService.signOut();

    return RequestResult(status: true);
  }
}
