import 'package:flutter_modular/flutter_modular.dart';
import 'package:orca_ai/core/constants/routes.dart';
import 'package:orca_ai/data/dtos/doc_dto.dart';

class AppRouter {
  static pop() {
    return Modular.to.pop();
  }

  static goToLandingPage() async {
    return Modular.to.pushNamedAndRemoveUntil(Routes.landingPage, (_) => false);
  }

  static goToHomePage() async {
    return Modular.to.pushNamed(Routes.homePage);
  }

  static goToCreatePage({bool popAndPush = false, String? prompt}) async {
    if (popAndPush) {
      return Modular.to.popAndPushNamed(
        Routes.createPage,
        arguments: {"prompt": prompt, "editMode": false},
      );
    }

    return Modular.to.pushNamed(
      Routes.createPage,
      arguments: {"prompt": prompt, "editMode": false},
    );
  }

  static goToEditPage({DocDto? doc}) async {
    return Modular.to.pushNamed(
      Routes.createPage,
      arguments: {"doc": doc, "editMode": true},
    );
  }

  static goToPreviewPage({bool popAndPush = false}) async {
    if (popAndPush) {
      return Modular.to.popAndPushNamed(Routes.previewPage);
    }

    return Modular.to.pushNamed(Routes.previewPage);
  }

  static goToListenPage() async {
    return Modular.to.pushNamed(Routes.listenPage);
  }

  static goToLoginPage() async {
    return Modular.to.pushNamed(Routes.loginPage);
  }

  static goToDashboardPage() async {
    return Modular.to.pushNamed(Routes.dashboardPage);
  }

  static goToCreateAccountPage() async {
    return Modular.to.pushNamed(Routes.createAccountPage);
  }
}
