import 'package:orca_ai/data/data.dart';

abstract class PostGeminiUsecase {
  Future<DocDto> call({required String prompt});
}
