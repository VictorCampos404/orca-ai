import 'package:orca_ai/data/dtos/doc_dto.dart';
import 'package:orca_ai/domain/repositories/document_repository.dart';
import 'package:orca_ai/domain/usecases/document/document_usecase.dart';

class DocumentImpUsecase implements DocumentUsecase {
  final DocumentRepository _documentRepository;

  DocumentImpUsecase(this._documentRepository);

  @override
  Future<String> save({required DocDto doc}) async {
    return await _documentRepository.save(doc: doc);
  }

  @override
  Future<void> delete({required String id}) async {
    return await _documentRepository.delete(id: id);
  }

  @override
  Future<DocDto> get({required String id}) async {
    return await _documentRepository.get(id: id);
  }

  @override
  Future<List<DocDto>> list() async {
    return await _documentRepository.list();
  }

  @override
  Future<void> update({required DocDto doc}) async {
    return await _documentRepository.update(doc: doc);
  }
}
