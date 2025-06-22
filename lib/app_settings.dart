import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:orca_ai/app_module.dart';
import 'package:orca_ai/core/configs/api_config.dart';
import 'package:orca_ai/core/constants/routes.dart';
import 'package:orca_ai/services/remote_config_service.dart';
import 'package:orca_ai/firebase_options.dart';

class AppSettings {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    setUrlStrategy(PathUrlStrategy());

    initializeDateFormatting('pt_BR');

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    Modular.init(AppModule());

    await Modular.get<RemoteConfigService>().init();
    await Modular.get<ApiConfig>().init();

    Modular.setInitialRoute(Routes.createAccountPage);
  }
}
