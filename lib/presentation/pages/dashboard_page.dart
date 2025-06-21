import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orca_ai/core/constants/app_text_styles.dart';
import 'package:orca_ai/presentation/controller/system_controller.dart';
import 'package:orca_ai/presentation/controller/user_session_controller.dart';
import 'package:orca_ai/presentation/pages/login_page.dart';
import 'package:orca_ai/presentation/widgets/device_builder.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<SystemController, UserSessionController>(
      builder: (context, systemController, userSessionController, _) {
        return DeviceBuilder(
          builder: (context, device) {
            return StreamBuilder<User?>(
              stream: userSessionController.authChanges,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Scaffold(
                    body: Center(
                      child: Column(
                        children: [
                          Text(
                            "Dashboard: ${device.name} bla bla bla",
                            style: AppTextStyles.megaTitle,
                          ),
                          TextButton(
                            onPressed: () {
                              userSessionController.signOut();
                            },
                            child: Text("Sair"),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const LoginPage();
              },
            );
          },
        );
      },
    );
  }
}
