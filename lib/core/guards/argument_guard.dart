import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';

class ArgumentGuard extends RouteGuard {
  final String key;
  final String redirectTo;

  ArgumentGuard({required this.key, required this.redirectTo})
    : super(redirectTo: redirectTo);

  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    final args = Modular.args.data;

    return !(args == null || args is! Map || !args.containsKey(key));
  }
}
