import 'package:orca_ai/data/datasources/document/document_datasource.dart';
import 'package:orca_ai/data/dtos/doc_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orca_ai/services/firebase_auth_service.dart';

class DocumentImpDatasource implements DocumentDatasource {
  final FirebaseAuthService _firebaseAuthService;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DocumentImpDatasource(this._firebaseAuthService);

  @override
  Future<String> save({required DocDto doc}) async {
    final response = await _getCollection().add(doc.toMap());

    return response.id;
  }

  @override
  Future<void> delete({required String id}) async {
    await _getCollection().doc(id).delete();
  }

  @override
  Future<DocDto> get({required String id}) async {
    final response = await _getCollection().doc(id).get();

    final map = response.data() ?? {};

    map.addAll({'id': response.id});

    return DocDto.fromMap(map);
  }

  @override
  Future<List<DocDto>> list() async {
    final response = await _getCollection().get();

    return response.docs.map((element) {
      final map = element.data();

      map.addAll({'id': element.id});

      return DocDto.fromMap(map);
    }).toList();
  }

  @override
  Future<void> update({required DocDto doc}) async {
    await _getCollection().doc(doc.id).update(doc.toMap());
  }

  CollectionReference<Map<String, dynamic>> _getCollection() {
    if (_firebaseAuthService.isLogged) {
      return _db
          .collection("user")
          .doc(_firebaseAuthService.user?.uid)
          .collection('documents');
    }

    throw Exception("O usuário não esta logado");
  }
}
