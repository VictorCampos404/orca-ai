import 'package:flutter/material.dart';
import 'package:orca_ai/core/constants/app_text_styles.dart';
import 'package:orca_ai/core/utils/app_router.dart';
import 'package:orca_ai/presentation/controller/system_controller.dart';
import 'package:orca_ai/presentation/controller/user_session_controller.dart';
import 'package:orca_ai/presentation/widgets/device_builder.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<SystemController, UserSessionController>(
      builder: (context, systemController, userSessionController, _) {
        return DeviceBuilder(
          builder: (context, device) {
            return Scaffold(
              body: Center(
                child: Column(
                  children: [
                    Text("Landing Page", style: AppTextStyles.megaTitle),
                    TextButton(
                      onPressed: () {
                        AppRouter.goToLoginPage();
                      },
                      child: Text("Login"),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
