import 'package:flutter/material.dart';
import 'package:orca_ai/core/base/status.dart';
import 'package:orca_ai/core/enums/list_type.dart';
import 'package:orca_ai/core/enums/status.dart';
import 'package:orca_ai/core/models/request_result.dart';
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

  Future<RequestResult> deleteDocument(String id) async {
    setStatus(Status.loading);
    try {
      await _documentUsecase.delete(id: id);

      _documents.removeWhere((element) => element.id == id);

      setStatus(Status.success);
      return RequestResult(
        status: true,
        title: "Sucesso",
        message: "Arquivo excluído com sucesso!",
      );
    } catch (e) {
      setStatus(Status.loading);
      return RequestResult(status: false, title: "Erro", message: e.toString());
    }
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

      final documentCreated = await _documentUsecase.create(doc: newDoc);

      _documents.add(documentCreated);

      _selectedDoc = documentCreated;

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

      // await deleteDocDta(doc);

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
