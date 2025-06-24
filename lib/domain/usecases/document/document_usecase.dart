import 'package:orca_ai/data/data.dart';

abstract class DocumentUsecase {
  Future<String> save({required DocDto doc});
  Future<List<DocDto>> list();
  Future<DocDto> get({required String id});
  Future<void> update({required DocDto doc});
  Future<void> delete({required String id});
}
