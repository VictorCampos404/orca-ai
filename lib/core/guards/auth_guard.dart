import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:orca_ai/core/constants/routes.dart';
import 'package:orca_ai/services/firebase_auth_service.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: Routes.loginPage);

  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    return Modular.get<FirebaseAuthService>().isLogged;
  }
}
