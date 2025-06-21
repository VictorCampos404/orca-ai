import 'package:orca_ai/data/data.dart';

abstract class PostGeminiRepository {
  Future<DocDto> call({required String prompt});
}
