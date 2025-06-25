import 'package:flutter/material.dart';
import 'package:orca_ai/core/constants/app_colors.dart';
import 'package:orca_ai/core/constants/app_text_styles.dart';
import 'package:orca_ai/core/constants/custom_icons.dart';
import 'package:orca_ai/core/constants/spaces.dart';
import 'package:orca_ai/core/utils/app_router.dart';
import 'package:orca_ai/presentation/widgets/primary_button.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({super.key});

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Spaces.x2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CustomIcons.error_warning_fill,
                size: 80,
                color: AppColors.error,
              ),
              SizedBox(height: Spaces.x4),
              Text(
                '404 - Página Não Encontrada',
                textAlign: TextAlign.center,
                style: AppTextStyles.megaTitle,
              ),
              SizedBox(height: Spaces.x1),
              Text(
                'A rota que você tentou acessar não existe.',
                textAlign: TextAlign.center,
                style: AppTextStyles.subTitle,
              ),
              SizedBox(height: Spaces.x8),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 300),
                child: PrimaryButton(
                  enable: true,
                  text: "Voltar para o início",

                  onTap: () async {
                    AppRouter.goToLandingPage();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
