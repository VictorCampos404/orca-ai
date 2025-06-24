import 'package:flutter/rendering.dart';
import 'package:orca_ai/data/datasources/document/document_datasource.dart';
import 'package:orca_ai/data/dtos/doc_dto.dart';
import 'package:orca_ai/domain/repositories/document_repository.dart';

class DocumentImpRepository implements DocumentRepository {
  final DocumentDatasource _documentDatasource;

  DocumentImpRepository(this._documentDatasource);

  @override
  Future<String> save({required DocDto doc}) async {
    try {
      return await _documentDatasource.save(doc: doc);
    } catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  @override
  Future<void> delete({required String id}) async {
    try {
      return await _documentDatasource.delete(id: id);
    } catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  @override
  Future<DocDto> get({required String id}) async {
    try {
      return await _documentDatasource.get(id: id);
    } catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  @override
  Future<List<DocDto>> list() async {
    try {
      return await _documentDatasource.list();
    } catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  @override
  Future<void> update({required DocDto doc}) async {
    try {
      return await _documentDatasource.update(doc: doc);
    } catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }
}
