import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:orca_ai/core/constants/app_colors.dart';
import 'package:orca_ai/core/constants/app_text_styles.dart';
import 'package:orca_ai/core/constants/custom_icons.dart';
import 'package:orca_ai/core/constants/spaces.dart';
import 'package:orca_ai/core/utils/app_router.dart';
import 'package:orca_ai/core/utils/pop_up.dart';
import 'package:orca_ai/data/data.dart';
import 'package:orca_ai/presentation/controller/doc_controller.dart';
import 'package:orca_ai/presentation/widgets/custom_icon_button.dart';
import 'package:orca_ai/presentation/widgets/custom_option_button.dart';
import 'package:orca_ai/presentation/widgets/widget_bottom_sheet.dart';

class DocumentCard extends StatelessWidget {
  final DocDto docData;
  final bool? list;

  const DocumentCard({super.key, required this.docData, this.list});

  @override
  Widget build(BuildContext context) {
    final width =
        ((MediaQuery.of(context).size.width - Spaces.x4) / 2) - Spaces.x1;

    return SizedBox(
      width: list ?? false ? null : width,
      child: Tooltip(
        message: docData.file?.name,
        child: Material(
          color: AppColors.background,
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              Modular.get<DocController>().setSelectedDoc(docData);
              AppRouter.goToPreviewPage();
            },
            child: Padding(
              padding:
                  list ?? false
                      ? const EdgeInsets.symmetric(
                        horizontal: Spaces.x2,
                        vertical: Spaces.x1,
                      )
                      : const EdgeInsets.symmetric(
                        horizontal: Spaces.half,
                        vertical: Spaces.half,
                      ),
              child: Column(
                children: [
                  // if (!(list ?? false))
                  //   Container(
                  //     height: 85,
                  //     padding: const EdgeInsets.only(bottom: Spaces.x1),
                  //     child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(5),
                  //       child: AbsorbPointer(
                  //         absorbing: true,
                  //         child: PDFView(
                  //           filePath: docData.file?.path,
                  //           enableSwipe: false,
                  //           swipeHorizontal: false,
                  //           autoSpacing: false,
                  //           pageSnap: false,
                  //           defaultPage: 1,
                  //           fitPolicy: FitPolicy.WIDTH,
                  //           pageFling: false,
                  //           preventLinkNavigation: true,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  Row(
                    children: [
                      const Icon(CustomIcons.file_3_fill, color: AppColors.pdf),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Spaces.x2,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                docData.file?.name ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.itemTitle,
                              ),
                              Text(
                                'Tamanho: ${((docData.file?.bytes?.length ?? 0) / 1024).toStringAsFixed(2)} KB',
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.itemSubTitle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomIconButton(
                        icon: CustomIcons.more_2_fill,
                        color: AppColors.text,
                        onTap: () {
                          WidgetBottomSheet.show(
                            context: context,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(Spaces.x2),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        CustomIcons.file_3_fill,
                                        color: AppColors.pdf,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: Spaces.x2,
                                          ),
                                          child: Text(
                                            docData.file?.name ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                AppTextStyles.bottomSheetTitle,
                                          ),
                                        ),
                                      ),
                                      CustomIconButton(
                                        icon: CustomIcons.close_fill,
                                        onTap: () {
                                          AppRouter.pop();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 0.5,
                                  color: AppColors.disable,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: Spaces.x2,
                                  ),
                                  child: CustomOptionButton(
                                    icon: CustomIcons.keynote_fill,
                                    text: 'Visualizar',
                                    onTap: () {
                                      AppRouter.pop();
                                      Modular.get<DocController>()
                                          .setSelectedDoc(docData);
                                      AppRouter.goToPreviewPage();
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: Spaces.x2,
                                  ),
                                  child: CustomOptionButton(
                                    icon: CustomIcons.pencil_fill,
                                    text: 'Editar',
                                    onTap: () {
                                      AppRouter.pop();
                                      Modular.get<DocController>()
                                          .resetCreateDocument(doc: docData);

                                      AppRouter.goToEditPage(doc: docData);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: Spaces.x2,
                                  ),
                                  child: CustomOptionButton(
                                    icon: CustomIcons.information_fill,
                                    text: 'Informações',
                                    onTap: () {
                                      AppRouter.pop();
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: Spaces.x2,
                                  ),
                                  child: CustomOptionButton(
                                    icon: CustomIcons.share_forward_2_fill,
                                    text: 'Compartilhar',
                                    onTap: () {
                                      AppRouter.pop();
                                      // Share.shareXFiles([
                                      //   XFile(docData.file?.path ?? ''),
                                      // ]);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: Spaces.x2,
                                    bottom: Spaces.x2,
                                  ),
                                  child: CustomOptionButton(
                                    icon: CustomIcons.delete_bin_7_fill,
                                    text: 'Excluir',
                                    onTap: () {
                                      AppRouter.pop();
                                      _handleDelete(docData, context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      // IconButton(
                      //   icon: const Icon(
                      //     Icons.delete,
                      //     color: Colors.black54,
                      //   ),
                      //   onPressed: () => _handleDelete(
                      //     docData,
                      //   ),
                      // ),
                      // IconButton(
                      //   icon: const Icon(
                      //     Icons.edit,
                      //     color: Colors.black54,
                      //   ),
                      //   onPressed: () {
                      //     context.read<DocController>().resetCreateDocument(
                      //           doc: docData,
                      //         );

                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => CreatePage(
                      //           editMode: true,
                      //           doc: docData,
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleDelete(DocDto? doc, BuildContext context) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: Text(
            'Você tem certeza que deseja excluir este arquivo ${doc?.file?.name} permanentemente?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      final result = await Modular.get<DocController>().deleteDocument(
        doc?.id ?? '',
      );

      PopUp.showResult(result: result);
    }
  }
}
