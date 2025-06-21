import 'package:orca_ai/data/dtos/doc_dto.dart';

abstract class PostGeminiDatasource {
  Future<DocDto> call({required String prompt});
}
