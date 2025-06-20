import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:orca_ai/app_settings.dart';
import 'package:orca_ai/core/constants/app_colors.dart';
import 'package:orca_ai/presentation/controller/system_controller.dart';
import 'package:provider/provider.dart';

void main() async {
  try {
    await AppSettings.init();
  } catch (error) {
    debugPrint(error.toString());
  }

  runApp(const OrcaAiApp());
}

class OrcaAiApp extends StatelessWidget {
  const OrcaAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Modular.get<SystemController>()),
      ],
      child: MaterialApp.router(
        title: 'Orça.ai',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: AppColors.colorScheme,
          useMaterial3: true,
        ),
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ),
    );
  }
}
