import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:orca_ai/core/constants/app_colors.dart';
import 'package:orca_ai/core/constants/app_text_styles.dart';
import 'package:orca_ai/core/constants/custom_icons.dart';
import 'package:orca_ai/core/constants/spaces.dart';
import 'package:orca_ai/core/utils/app_router.dart';
import 'package:orca_ai/presentation/controller/doc_controller.dart';
import 'package:orca_ai/presentation/widgets/custom_app_bar.dart';
import 'package:orca_ai/presentation/widgets/custom_icon_button.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:provider/provider.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DocController>(
      builder: (context, docController, _) {
        return Scaffold(
          backgroundColor: AppColors.backgroundSmoke,
          appBar: CustomAppBar(
            leading: CustomIconButton(
              icon: CustomIcons.home_2_fill,
              onTap: () {
                AppRouter.pop();
              },
            ),
            title: docController.selectedDoc?.file?.name ?? '',
            actions: [
              CustomIconButton(
                icon: CustomIcons.share_forward_2_fill,
                onTap: () {
                  // Share.shareXFiles(
                  //   [XFile(docController.preview?.path ?? '')],
                  // );
                },
              ),
            ],
          ),
          body:
              docController.selectedDoc?.havePreview ?? false
                  ? PdfViewer.data(
                    params: PdfViewerParams(
                      backgroundColor: AppColors.backgroundSmoke,
                      margin: Spaces.x2,
                      onViewerReady: (document, controller) {
                        controller.setZoom(
                          controller.centerPosition,
                          controller.minScale,
                        );
                      },
                    ),

                    docController.selectedDoc!.file!.bytes!,
                    sourceName: docController.selectedDoc!.file!.name!,
                  )
                  : Center(
                    child: Text(
                      "Erro ao carregar pdf",
                      style: AppTextStyles.subTitle,
                    ),
                  ),
        );
      },
    );
  }
}
