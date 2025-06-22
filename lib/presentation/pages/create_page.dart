import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:orca_ai/core/constants/app_colors.dart';
import 'package:orca_ai/core/constants/app_text_styles.dart';
import 'package:orca_ai/core/constants/custom_icons.dart';
import 'package:orca_ai/core/constants/spaces.dart';
import 'package:orca_ai/core/utils/app_router.dart';
import 'package:orca_ai/data/data.dart';
import 'package:orca_ai/presentation/controller/doc_controller.dart';
import 'package:orca_ai/presentation/controller/user_controller.dart';
import 'package:orca_ai/presentation/widgets/custom_app_bar.dart';
import 'package:orca_ai/presentation/widgets/custom_icon_button.dart';
import 'package:orca_ai/presentation/widgets/custom_input.dart';
import 'package:orca_ai/presentation/widgets/first_document_body.dart';
import 'package:orca_ai/presentation/widgets/primary_button.dart';
import 'package:orca_ai/presentation/widgets/widget_bottom_sheet.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatefulWidget {
  final String? prompt;
  final bool editMode;
  final DocDto? doc;

  const CreatePage({super.key, required this.editMode, this.doc, this.prompt});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  void initState() {
    Future.microtask(() {
      if ((widget.prompt ?? '').isNotEmpty) {
        final docController = Modular.get<DocController>();
        docController.sendToGemini(widget.prompt ?? '');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<DocController, UserController>(
      builder: (context, docController, userController, _) {
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                backgroundColor: AppColors.background,
                appBar: CustomAppBar(
                  leading: CustomIconButton(
                    icon: CustomIcons.close_fill,
                    onTap: () {
                      if (docController.isGeminiLoading ||
                          docController.isLoading) {
                        return;
                      }

                      AppRouter.pop();
                    },
                  ),
                  title:
                      widget.editMode ? "Editar orçamento" : "Novo orçamento",
                ),
                body:
                    docController.isGeminiLoading
                        ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          alignment: Alignment.center,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: Spaces.x2),
                              Text(
                                "Aguarde um momento...",
                                style: AppTextStyles.subTitle,
                              ),
                            ],
                          ),
                        )
                        : SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(Spaces.x2),
                            child: Column(
                              children: [
                                CustomInput(
                                  title: "Título:",
                                  hint: "Digite o título",
                                  controller: docController.titleCtrl,
                                ),
                                const SizedBox(height: 16),
                                CustomInput(
                                  title: "Para:",
                                  hint: "Digite o destinatário",
                                  controller: docController.acCtrl,
                                ),
                                const SizedBox(height: 16),
                                CustomInput(
                                  title: "Descrição:",
                                  hint: "Digite a descrição",
                                  multLine: true,
                                  maxLines: 10,
                                  controller: docController.descriptionCtrl,
                                ),
                                const SizedBox(height: 16),
                                CustomInput(
                                  title: "Valor (R\$):",
                                  hint: "R\$ 0,00",
                                  inputFormatters: [],
                                  controller: docController.valueCtrl,
                                ),
                              ],
                            ),
                          ),
                        ),
                bottomNavigationBar:
                    !docController.isGeminiLoading
                        ? Padding(
                          padding: const EdgeInsets.all(16),
                          child: PrimaryButton(
                            enable: true,
                            text:
                                widget.editMode
                                    ? "Salvar"
                                    : userController.hasUser
                                    ? "Assinar e criar"
                                    : "Continuar",
                            isloading: docController.isLoading,
                            onTap: () async {
                              if (docController.isLoading) {
                                return;
                              }

                              if (widget.editMode) {
                                await docController.updateDocument(
                                  widget.doc ?? DocDto(),
                                  userController.userData ?? UserDto(),
                                );
                              } else {
                                if (!userController.hasUser) {
                                  userController.reset();
                                  await WidgetBottomSheet.show(
                                    context: context,
                                    child: const FirstDocumentBody(),
                                  );

                                  if (!userController.hasUser) return;
                                }

                                await docController.createDocument(
                                  userController.userData ?? UserDto(),
                                );
                              }

                              AppRouter.goToPreviewPage(popAndPush: true);
                            },
                          ),
                        )
                        : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
