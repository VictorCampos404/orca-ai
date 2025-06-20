import 'package:flutter_modular/flutter_modular.dart';
import 'package:orca_ai/core/clients/gemini_client.dart';
import 'package:orca_ai/core/configs/api_config.dart';
import 'package:orca_ai/core/constants/routes.dart';
import 'package:orca_ai/core/utils/remote_config.dart';
import 'package:orca_ai/presentation/controller/system_controller.dart';
import 'package:orca_ai/presentation/pages/dashboard_page.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    //Controllers
    i.addLazySingleton(SystemController.new);
    // i.addLazySingleton(DocController.new);
    // i.addLazySingleton(MicrophoneController.new);
    // i.addLazySingleton(UserController.new);

    //Clients Https
    i.addLazySingleton(GeminiClient.new);

    //Services
    i.addLazySingleton(RemoteConfig.new);
    i.addLazySingleton(ApiConfig.new);
    // i.addLazySingleton(DocDataService.new);
    // i.addLazySingleton(PdfSerivce.new);
    // i.addLazySingleton(LocalConfigSerivce.new);

    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(Routes.dashboardPage, child: (ctx) => const DashboardPage());
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
