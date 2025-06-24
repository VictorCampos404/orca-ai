import 'package:flutter/material.dart';
import 'package:orca_ai/core/base/status.dart';
import 'package:orca_ai/core/enums/list_type.dart';
import 'package:orca_ai/core/enums/status.dart';
import 'package:orca_ai/core/utils/extensions.dart';
import 'package:orca_ai/data/data.dart';
import 'package:orca_ai/domain/domain.dart';
import 'package:orca_ai/services/pdf_serivce.dart';

class DocController extends BaseStatus {
  final PostGeminiUsecase _postGeminiUsecase;
  final FileUsecase _fileUsecase;
  final PdfSerivce _pdfSerivce;
  final DocumentUsecase _documentUsecase;

  late List<DocDto> _documents;
  List<DocDto> get documents => _documents;

  late ListType? _listType;
  ListType? get listType => _listType;

  late bool _isGeminiLoading;
  bool get isGeminiLoading => _isGeminiLoading;

  late TextEditingController titleCtrl;
  late TextEditingController acCtrl;
  late TextEditingController descriptionCtrl;
  late TextEditingController valueCtrl;

  late DocDto? _selectedDoc;
  DocDto? get selectedDoc => _selectedDoc;

  DocController(
    this._postGeminiUsecase,
    this._fileUsecase,
    this._pdfSerivce,
    this._documentUsecase,
  ) {
    reset();
  }

  void reset() async {
    _selectedDoc = null;
    _documents = [];
    _listType = ListType.list;
    _isGeminiLoading = false;
    titleCtrl = TextEditingController();
    acCtrl = TextEditingController();
    descriptionCtrl = TextEditingController();
    valueCtrl = TextEditingController();
  }

  void initialize() async {
    // _listType = await _localConfigSerivce.getListType();
    await getSavedPdfs();
    notifyListeners();
  }

  void toggleListType() {
    if (_listType == ListType.list) {
      // _localConfigSerivce.setListType(ListType.grid);
      _listType = ListType.grid;
    } else {
      // _localConfigSerivce.setListType(ListType.list);
      _listType = ListType.list;
    }
    notifyListeners();
  }

  void resetCreateDocument({DocDto? doc}) {
    _selectedDoc = null;
    titleCtrl = TextEditingController(text: doc?.title);
    acCtrl = TextEditingController(text: doc?.ac);
    descriptionCtrl = TextEditingController(text: doc?.description);
    valueCtrl = TextEditingController(text: doc?.value);
    notifyListeners();
  }

  void setSelectedDoc(DocDto? doc) {
    _selectedDoc = doc;
    notifyListeners();
  }

  Future<void> getSavedPdfs() async {
    setStatus(Status.loading);

    try {
      final response = await _documentUsecase.list();

      _documents.clear();
      _documents.addAll(response);
      _documents.sort(
        (a, b) =>
            (a.createdAt?.isBefore(b.createdAt ?? DateTime.now()) ?? false)
                ? -1
                : 1,
      );
      setStatus(Status.success);
    } catch (e) {
      print('Ocorreu um erro ao buscar os PDFs: $e');
      setStatus(Status.error);
    }
  }

  Future<void> deleteDocDta(DocDto doc) async {
    // try {
    //   await _docDataService.deleteDoc(doc.path ?? '');

    //   if ((await doc.file?.exists()) ?? false) {
    //     await doc.file?.delete();
    //     print('Arquivo excluído com sucesso');
    //   } else {
    //     print('O arquivo não foi encontrado no caminho');
    //   }
    // } catch (e) {
    //   print('Erro ao excluir o arquivo: $e');
    //   rethrow;
    // }
  }

  Future<void> createDocument(UserDto user) async {
    setStatus(Status.loading);
    try {
      final newDoc = DocDto(
        title: titleCtrl.text,
        ac: acCtrl.text,
        description: descriptionCtrl.text,
        value: valueCtrl.text,
        createdAt: DateTime.now(),
      );

      final result = await _pdfSerivce.create(newDoc, user);

      if (result == null) return;

      final file = await _fileUsecase.upload(
        path: 'teste.pdf',
        contentType: 'application/pdf',
        file: result,
      );

      newDoc.file = file;

      final id = await _documentUsecase.save(doc: newDoc);

      newDoc.id = id;

      _documents.add(newDoc);

      _selectedDoc = newDoc;

      // newDoc.path = _preview?.path;

      // await _docDataService.addDoc(newDoc);

      setStatus(Status.success);
    } catch (error) {
      print(error);
      setStatus(Status.error);
    }
  }

  Future<void> updateDocument(DocDto doc, UserDto user) async {
    try {
      final newDoc = DocDto(
        createdAt: doc.createdAt,
        title: titleCtrl.text,
        ac: acCtrl.text,
        description: descriptionCtrl.text,
        value: valueCtrl.text,
      );

      await deleteDocDta(doc);

      // _preview = await _pdfSerivce.create(newDoc, user);

      // newDoc.path = _preview?.path;

      // await _docDataService.addDoc(newDoc);
      notifyListeners();
      getSavedPdfs();
    } catch (error) {
      print(error);
    }
  }

  Future<void> sendToGemini(String text) async {
    if (text.isEmpty) return;

    _isGeminiLoading = true;
    notifyListeners();

    try {
      final doc = await _postGeminiUsecase(prompt: text);

      resetCreateDocument(doc: doc);
      _isGeminiLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      _isGeminiLoading = false;
      notifyListeners();
    }
  }
}
