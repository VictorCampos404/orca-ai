import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:orca_ai/core/constants/app_colors.dart';
import 'package:orca_ai/core/constants/app_text_styles.dart';
import 'package:orca_ai/core/constants/custom_icons.dart';
import 'package:orca_ai/core/constants/spaces.dart';
import 'package:orca_ai/core/enums/device.dart';
import 'package:orca_ai/core/enums/status.dart';
import 'package:orca_ai/core/utils/app_router.dart';
import 'package:orca_ai/presentation/controller/user_session_controller.dart';
import 'package:orca_ai/presentation/widgets/custom_icon_button.dart';
import 'package:orca_ai/presentation/widgets/custom_input.dart';
import 'package:orca_ai/presentation/widgets/device_builder.dart';
import 'package:orca_ai/presentation/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserSessionController>(
      builder: (context, userSessionController, _) {
        return DeviceBuilder(
          builder: (context, device) {
            return Scaffold(
              backgroundColor: AppColors.backgroundSmoke,
              appBar: PreferredSize(
                preferredSize: Size(0, 72),
                child: AppBar(
                  backgroundColor: AppColors.background,
                  leadingWidth: 72,
                  toolbarHeight: 72,
                  leading: Padding(
                    padding: EdgeInsets.all(Spaces.x2),
                    child: CustomIconButton(
                      icon: CustomIcons.arrow_left_line,
                      onTap: () {
                        if (Modular.routerDelegate.canPop()) {
                          AppRouter.pop();
                        }
                      },
                    ),
                  ),
                ),
              ),
              body: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  constraints: BoxConstraints(maxWidth: Device.phone.maxWidth),
                  padding: EdgeInsets.all(Spaces.x3),
                  margin: EdgeInsets.all(Spaces.x2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Criar conta", style: AppTextStyles.megaTitle),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Spaces.x4,
                          bottom: Spaces.x2,
                        ),
                        child: CustomInput(
                          title: "Nome:",
                          hint: "Digite seu nome.",
                          onChanged: (value) {
                            userSessionController.setStatus(Status.success);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: Spaces.x2),
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
                        padding: const EdgeInsets.only(bottom: Spaces.x2),
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: Spaces.x8),
                        child: CustomInput(
                          title: "Confirme sua senha:",
                          hint: "•••••••••••",
                          isPassword: true,
                          controller: userSessionController.passwordCtrl,
                          onChanged: (value) {
                            userSessionController.setStatus(Status.success);
                          },
                        ),
                      ),
                      PrimaryButton(
                        text: "Criar conta",
                        enable: userSessionController.isButtonLoginEnable,
                        isloading: userSessionController.isLoading,
                        onTap: () async {
                          // final result = await userSessionController.login();

                          // if (result.status) {
                          //   final continueTo =
                          //       Modular.args.queryParams['continue'];

                          //   if ((continueTo ?? '').isNotEmpty) {
                          //     Modular.to.navigate(
                          //       Uri.decodeComponent(continueTo ?? ''),
                          //     );
                          //     return;
                          //   }

                          //   AppRouter.goToDashboardPage();

                          //   return;
                          // }

                          // PopUp.showResult(result: result);
                        },
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
