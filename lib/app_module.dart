import 'package:flutter_modular/flutter_modular.dart';
import 'package:orca_ai/core/clients/gemini_client.dart';
import 'package:orca_ai/core/configs/api_config.dart';
import 'package:orca_ai/core/constants/routes.dart';
import 'package:orca_ai/core/utils/auth_guard.dart';
import 'package:orca_ai/presentation/controller/doc_controller.dart';
import 'package:orca_ai/presentation/controller/user_controller.dart';
import 'package:orca_ai/presentation/controller/user_session_controller.dart';
import 'package:orca_ai/presentation/pages/create_account_page.dart';
import 'package:orca_ai/presentation/pages/create_page.dart';
import 'package:orca_ai/presentation/pages/landing_page.dart';
import 'package:orca_ai/presentation/pages/login_page.dart';
import 'package:orca_ai/presentation/pages/preview_page.dart';
import 'package:orca_ai/services/firebase_auth_service.dart';
import 'package:orca_ai/services/firebase_storage_service.dart';
import 'package:orca_ai/services/pdf_serivce.dart';
import 'package:orca_ai/services/remote_config_service.dart';
import 'package:orca_ai/data/data.dart';
import 'package:orca_ai/domain/domain.dart';
import 'package:orca_ai/presentation/controller/system_controller.dart';
import 'package:orca_ai/presentation/pages/dashboard_page.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    //Usecases
    i.addLazySingleton<PostGeminiUsecase>(PostGeminiImpUsecase.new);
    i.addLazySingleton<FileUsecase>(FileImpUsecase.new);
    i.addLazySingleton<DocumentUsecase>(DocumentImpUsecase.new);

    //Repositories
    i.addLazySingleton<PostGeminiRepository>(PostGeminiImpRepository.new);
    i.addLazySingleton<FileRepository>(FileImpRepository.new);
    i.addLazySingleton<DocumentRepository>(DocumentImpRepository.new);

    //Datasources
    i.addLazySingleton<PostGeminiDatasource>(PostGeminiImpDatasource.new);
    i.addLazySingleton<FileDatasource>(FileImpDatasource.new);
    i.addLazySingleton<DocumentDatasource>(DocumentImpDatasource.new);

    //Controllers
    i.addLazySingleton(SystemController.new);
    i.addLazySingleton(UserSessionController.new);
    i.addLazySingleton(DocController.new);
    i.addLazySingleton(UserController.new);

    //Clients Https
    i.addLazySingleton(GeminiClient.new);

    //Services
    i.addLazySingleton(RemoteConfigService.new);
    i.addLazySingleton(ApiConfig.new);
    i.addLazySingleton(FirebaseAuthService.new);
    i.addLazySingleton(FirebaseStorageService.new);
    i.addLazySingleton(PdfSerivce.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(Routes.landingPage, child: (ctx) => const LandingPage());
    r.child(Routes.loginPage, child: (ctx) => const LoginPage());
    r.child(
      Routes.createAccountPage,
      child: (ctx) => const CreateAccountPage(),
    );
    r.child(
      Routes.dashboardPage,
      child: (ctx) => const DashboardPage(),
      guards: [AuthGuard()],
    );
    r.child(
      Routes.createPage,
      child:
          (ctx) => CreatePage(
            editMode: r.args.data?['editMode'],
            prompt: r.args.data?['prompt'],
            doc: r.args.data?['doc'],
          ),
    );
    r.child(Routes.previewPage, child: (ctx) => const PreviewPage());
    // r.child(Routes.homePage, child: (ctx) => const HomePage());

    // r.child(Routes.previewPage, child: (ctx) => const PreviewPage());
    // r.child(Routes.listenPage, child: (ctx) => const ListenPage());

    super.routes(r);
  }
}
