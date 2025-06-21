import 'package:flutter/widgets.dart';
import 'package:orca_ai/data/datasources/post_gemini/post_gemini_datasource.dart';
import 'package:orca_ai/data/dtos/doc_dto.dart';
import 'package:orca_ai/domain/repositories/post_gemini_repository.dart';

class PostGeminiImpRepository implements PostGeminiRepository {
  final PostGeminiDatasource _postGeminiDatasource;

  PostGeminiImpRepository(this._postGeminiDatasource);

  @override
  Future<DocDto> call({required String prompt}) async {
    try {
      return await _postGeminiDatasource(prompt: prompt);
    } catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }
}
