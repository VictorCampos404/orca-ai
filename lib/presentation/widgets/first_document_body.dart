import 'package:flutter/material.dart';
import 'package:orca_ai/core/constants/app_colors.dart';
import 'package:orca_ai/core/constants/app_text_styles.dart';
import 'package:orca_ai/core/constants/custom_icons.dart';
import 'package:orca_ai/core/constants/spaces.dart';
import 'package:orca_ai/core/formaters/masks.dart';
import 'package:orca_ai/core/utils/app_router.dart';
import 'package:orca_ai/presentation/controller/user_controller.dart';
import 'package:orca_ai/presentation/widgets/custom_icon_button.dart';
import 'package:orca_ai/presentation/widgets/custom_input.dart';
import 'package:orca_ai/presentation/widgets/primary_button.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

class FirstDocumentBody extends StatefulWidget {
  const FirstDocumentBody({super.key});

  @override
  State<FirstDocumentBody> createState() => _FirstDocumentBodyState();
}

class _FirstDocumentBodyState extends State<FirstDocumentBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, userController, _) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: AppColors.transparent,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Spaces.x2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Estamos quase lá", style: AppTextStyles.title),
                    const SizedBox(height: Spaces.x1),
                    const Text(
                      "Como é seu primeiro orçamento precisamos de alguns dados para a assinatura.",
                      style: AppTextStyles.subTitle,
                    ),
                    const SizedBox(height: Spaces.x4),
                    CustomInput(
                      title: "Seu nome completo:",
                      hint: "Digite seu nome",
                      controller: userController.nameCtrl,
                      onChanged: (value) {
                        userController.updateStatus();
                      },
                    ),
                    const SizedBox(height: Spaces.x2),
                    CustomInput(
                      title: "Seu celular:",
                      hint: "(00) 00000-0000",
                      controller: userController.phoneCtrl,
                      inputFormatters: [Masks.phoneMask],
                      onChanged: (value) {
                        userController.updateStatus();
                      },
                    ),
                    const SizedBox(height: Spaces.x2),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Desenhe sua assinatura:",
                            style: AppTextStyles.inputTitle,
                          ),
                        ),
                        CustomIconButton(
                          icon: CustomIcons.delete_bin_7_fill,
                          onTap: () {
                            userController.signatureController.clear();
                            userController.updateStatus();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: Spaces.x1),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: AppColors.disable,
                          width: 1.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Signature(
                          controller: userController.signatureController,
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    // CustomButton(
                    //   text: "Salvar",
                    //   onPressed: () async {
                    //     Directory appDocumentsDir =
                    //         await getApplicationDocumentsDirectory();

                    //     final file = File(
                    //       "${appDocumentsDir.path}/signature.png",
                    //     );

                    //     final bytes = await _controller.toPngBytes();

                    //     if (bytes != null) {
                    //       await file.writeAsBytes(bytes);
                    //     }
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16),
              child: PrimaryButton(
                enable: userController.canSaveUser,
                text: "Assinar e criar",
                onTap: () async {
                  await userController.saveData();

                  AppRouter.pop();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
