import 'package:orca_ai/core/utils/extensions.dart';
import 'package:orca_ai/data/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:orca_ai/domain/domain.dart';
import 'package:orca_ai/services/firebase_auth_service.dart';
import 'package:orca_ai/services/firebase_storage_service.dart';
import 'package:orca_ai/services/pdf_serivce.dart';

class DocumentImpDatasource implements DocumentDatasource {
  final FirebaseAuthService _firebaseAuthService;
  final FirebaseStorageService _firebaseStorageService;
  final PdfSerivce _pdfSerivce;
  final FileUsecase _fileUsecase;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DocumentImpDatasource(
    this._firebaseAuthService,
    this._firebaseStorageService,
    this._pdfSerivce,
    this._fileUsecase,
  );

  @override
  Future<DocDto> create({required DocDto doc}) async {
    final result = await _pdfSerivce.create(
      doc,
      UserDto(name: "Victor", phone: "Exemplo"),
    );

    final file = await _fileUsecase.upload(
      path: _getStoragePath(),
      contentType: 'application/pdf',
      file: result!,
    );

    doc.file = file;

    final response = await _getCollection().add(doc.toMap());

    doc.id = response.id;

    return doc;
  }

  @override
  Future<void> delete({required String id}) async {
    final doc = await get(id: id);

    _firebaseStorageService.delete(path: doc.file?.path ?? '');

    await _getCollection().doc(id).delete();
  }

  @override
  Future<DocDto> get({required String id}) async {
    final response = await _getCollection().doc(id).get();

    final map = response.data() ?? {};

    map.addAll({'id': response.id});

    final doc = DocDto.fromMap(map);

    await doc.file?.downloadBytes();

    return doc;
  }

  @override
  Future<List<DocDto>> list() async {
    final response = await _getCollection().get();

    List<DocDto> list = [];

    for (int i = 0; i < response.docs.length; i++) {
      final map = response.docs[i].data();

      map.addAll({'id': response.docs[i].id});

      final doc = DocDto.fromMap(map);

      await doc.file?.downloadBytes();

      list.add(doc);
    }

    return list;
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

  String _getStoragePath() {
    if (_firebaseAuthService.isLogged) {
      return "${_firebaseAuthService.user?.uid}/Orçamento-${DateTime.now().toFileName}.pdf";
    }

    throw Exception("O usuário não esta logado");
  }
}
