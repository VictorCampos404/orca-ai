import 'package:orca_ai/data/dtos/doc_dto.dart';
import 'package:orca_ai/domain/repositories/post_gemini_repository.dart';
import 'package:orca_ai/domain/usecases/post_gemini/post_gemini_usecase.dart';

class PostGeminiImpUsecase implements PostGeminiUsecase {
  final PostGeminiRepository _postGeminiRepository;

  PostGeminiImpUsecase(this._postGeminiRepository);

  @override
  Future<DocDto> call({required String prompt}) async {
    return await _postGeminiRepository(prompt: prompt);
  }
}
