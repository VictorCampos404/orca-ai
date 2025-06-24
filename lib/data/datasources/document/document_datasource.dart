import 'package:orca_ai/data/data.dart';

abstract class DocumentDatasource {
  Future<DocDto> create({required DocDto doc});
  Future<List<DocDto>> list();
  Future<DocDto> get({required String id});
  Future<void> update({required DocDto doc});
  Future<void> delete({required String id});
}
