import 'package:flutter_modular/flutter_modular.dart';
import 'package:orca_ai/core/clients/gemini_client.dart';
import 'package:orca_ai/core/configs/api_config.dart';
import 'package:orca_ai/core/constants/routes.dart';
import 'package:orca_ai/presentation/controller/user_session_controller.dart';
import 'package:orca_ai/presentation/pages/login_page.dart';
import 'package:orca_ai/services/firebase_auth_service.dart';
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

    //Repositories
    i.addLazySingleton<PostGeminiRepository>(PostGeminiImpRepository.new);

    //Datasources
    i.addLazySingleton<PostGeminiDatasource>(PostGeminiImpDatasource.new);

    //Controllers
    i.addLazySingleton(SystemController.new);
    i.addLazySingleton(UserSessionController.new);

    //Clients Https
    i.addLazySingleton(GeminiClient.new);

    //Services
    i.addLazySingleton(RemoteConfigService.new);
    i.addLazySingleton(ApiConfig.new);
    i.addLazySingleton(FirebaseAuthService.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(Routes.dashboardPage, child: (ctx) => const DashboardPage());
    r.child(Routes.loginPage, child: (ctx) => const LoginPage());
    // r.child(Routes.homePage, child: (ctx) => const HomePage());
    // r.child(
    //   Routes.createPage,
    //   child:
    //       (ctx) => CreatePage(
    //         editMode: r.args.data?['editMode'],
    //         prompt: r.args.data?['prompt'],
    //         doc: r.args.data?['doc'],
    //       ),
    // );
    // r.child(Routes.previewPage, child: (ctx) => const PreviewPage());
    // r.child(Routes.listenPage, child: (ctx) => const ListenPage());

    super.routes(r);
  }
}
