import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:orca_ai/core/constants/app_colors.dart';
import 'package:orca_ai/core/constants/app_text_styles.dart';
import 'package:orca_ai/core/constants/custom_icons.dart';
import 'package:orca_ai/core/constants/spaces.dart';
import 'package:orca_ai/core/enums/list_type.dart';
import 'package:orca_ai/core/utils/app_router.dart';
import 'package:orca_ai/presentation/controller/doc_controller.dart';
import 'package:orca_ai/presentation/controller/system_controller.dart';
import 'package:orca_ai/presentation/widgets/custom_app_bar.dart';
import 'package:orca_ai/presentation/widgets/custom_icon_button.dart';
import 'package:orca_ai/presentation/widgets/custom_toast_button.dart';
import 'package:orca_ai/presentation/widgets/device_builder.dart';
import 'package:orca_ai/presentation/widgets/document_card.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late ScrollController scrollController;
  bool showButtons = true;

  @override
  void initState() {
    Future.microtask(() {
      Modular.get<DocController>().initialize();
      // Modular.get<UserController>().initialize();
      scrollController = ScrollController();
      scrollController.addListener(() {
        if (scrollController.position.pixels == 0 && !showButtons) {
          setState(() {
            showButtons = true;
          });
        }

        if (scrollController.position.pixels != 0 && showButtons) {
          setState(() {
            showButtons = false;
          });
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SystemController, DocController>(
      builder: (context, systemController, docController, _) {
        return DeviceBuilder(
          builder: (context, device) {
            return Scaffold(
              backgroundColor: AppColors.background,
              appBar: CustomAppBar(title: "Home"),
              body:
                  docController.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : docController.documents.isEmpty
                      ? Padding(
                        padding: const EdgeInsets.all(Spaces.x2),
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: Spaces.x1,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/ghost.png',
                                          width: 300,
                                          height: 300,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text(
                                    "Não foram encontrados orçamentos",
                                    style: AppTextStyles.subTitle,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 80),
                          ],
                        ),
                      )
                      : Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Spaces.x2,
                        ),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: Spaces.x2,
                                  right: Spaces.x2,
                                  bottom: Spaces.x6,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomToastButton(
                                      text: "Data",
                                      icon: CustomIcons.arrow_down_line,
                                      onTap: () {
                                        docController.toggleListType();
                                      },
                                    ),
                                    CustomIconButton(
                                      icon:
                                          docController.listType ==
                                                  ListType.list
                                              ? CustomIcons.function_fill
                                              : CustomIcons.menu_fill,
                                      onTap: () {
                                        docController.toggleListType();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              if (docController.listType == ListType.list) ...[
                                for (
                                  int i = 0;
                                  i < docController.documents.length;
                                  i++
                                )
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: DocumentCard(
                                      docData: docController.documents[i],
                                      list:
                                          docController.listType ==
                                          ListType.list,
                                    ),
                                  ),
                              ] else ...[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: Spaces.x2,
                                  ),
                                  child: Wrap(
                                    runSpacing: Spaces.x3,
                                    spacing: Spaces.x2,
                                    children: [
                                      for (
                                        int i = 0;
                                        i < docController.documents.length;
                                        i++
                                      )
                                        DocumentCard(
                                          docData: docController.documents[i],
                                          list:
                                              docController.listType ==
                                              ListType.list,
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
              floatingActionButtonAnimator:
                  FloatingActionButtonAnimator.noAnimation,
              floatingActionButton: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Column(
                  key: ValueKey<bool>(showButtons),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showButtons) ...[
                      CustomIconButton(
                        gradient: AppColors.gemini,
                        icon: CustomIcons.sparkling_fill,
                        color: AppColors.background,
                        padding: const EdgeInsets.all(Spaces.x1_half),
                        size: 24,
                        onTap: () {
                          // microphoneController.reset();
                          // AppRouter.goToListenPage();
                        },
                      ),
                      const SizedBox(height: Spaces.x2),
                      CustomIconButton(
                        badgedColor: AppColors.primary,
                        badged: true,
                        icon: CustomIcons.add_fill,
                        color: AppColors.background,
                        padding: const EdgeInsets.all(Spaces.x1_half),
                        size: 32,
                        onTap: () {
                          docController.resetCreateDocument();
                          AppRouter.goToCreatePage();

                          // docController.download();
                        },
                      ),
                    ],
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
