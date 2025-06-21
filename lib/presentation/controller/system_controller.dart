import 'package:orca_ai/core/base/status.dart';
import 'package:orca_ai/domain/usecases/usecases.dart';

class SystemController extends BaseStatus {
  final PostGeminiUsecase _postGeminiUsecase;

  SystemController(this._postGeminiUsecase) {
    reset();
  }

  reset() {}
}
