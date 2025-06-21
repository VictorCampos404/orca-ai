import 'package:flutter/material.dart';
import 'package:orca_ai/core/constants/app_colors.dart';
import 'package:orca_ai/core/constants/app_text_styles.dart';
import 'package:orca_ai/core/constants/spaces.dart';
import 'package:orca_ai/core/enums/device.dart';
import 'package:orca_ai/core/enums/status.dart';
import 'package:orca_ai/core/utils/pop_up.dart';
import 'package:orca_ai/presentation/controller/user_session_controller.dart';
import 'package:orca_ai/presentation/widgets/custom_input.dart';
import 'package:orca_ai/presentation/widgets/device_builder.dart';
import 'package:orca_ai/presentation/widgets/primary_button.dart';
import 'package:orca_ai/presentation/widgets/secondary_button.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserSessionController>(
      builder: (context, userSessionController, _) {
        return DeviceBuilder(
          builder: (context, device) {
            return Scaffold(
              backgroundColor: AppColors.background,
              body: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: Device.phone.maxWidth),
                  padding: EdgeInsets.all(Spaces.x3),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Login", style: AppTextStyles.megaTitle),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Spaces.x4,
                          bottom: Spaces.x2,
                        ),
                        child: CustomInput(
                          title: "E-mail:",
                          hint: "Digite seu e-mail.",
                          controller: userSessionController.emailCtrl,
                          onChanged: (value) {
                            userSessionController.setStatus(Status.success);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: Spaces.x8),
                        child: CustomInput(
                          title: "Senha:",
                          hint: "•••••••••••",
                          isPassword: true,
                          controller: userSessionController.passwordCtrl,
                          onChanged: (value) {
                            userSessionController.setStatus(Status.success);
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SecondaryButton(
                              text: "Criar conta",
                              enable: true,
                              onTap: () async {
                                if (userSessionController.isLoading) return;

                                // final result = await userSessionController.login();

                                // if (result.status) {
                                //   return;
                                // }

                                // PopUp.showResult(result: result);
                              },
                            ),
                          ),
                          SizedBox(width: Spaces.x2),
                          Expanded(
                            child: PrimaryButton(
                              text: "Entrar",
                              enable: userSessionController.isButtonLoginEnable,
                              isloading: userSessionController.isLoading,
                              onTap: () async {
                                final result =
                                    await userSessionController.login();

                                if (result.status) {
                                  return;
                                }

                                PopUp.showResult(result: result);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
