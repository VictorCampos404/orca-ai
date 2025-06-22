import 'dart:io';

import 'package:flutter/material.dart';
import 'package:orca_ai/core/base/status.dart';
import 'package:orca_ai/core/enums/list_type.dart';
import 'package:orca_ai/core/utils/extensions.dart';
import 'package:orca_ai/data/data.dart';
import 'package:orca_ai/domain/domain.dart';

class DocController extends BaseStatus {
  final PostGeminiUsecase _postGeminiUsecase;

  late List<DocDto> _documents;
  List<DocDto> get documents => _documents;

  late ListType? _listType;
  ListType? get listType => _listType;

  late bool _isLoading;
  bool get isLoading => _isLoading;

  late bool _isGeminiLoading;
  bool get isGeminiLoading => _isGeminiLoading;

  late TextEditingController titleCtrl;
  late TextEditingController acCtrl;
  late TextEditingController descriptionCtrl;
  late TextEditingController valueCtrl;

  late File? _preview;
  File? get preview => _preview;

  DocController(this._postGeminiUsecase) {
    reset();
  }

  void reset() async {
    _preview = null;
    _documents = [];
    _listType = ListType.list;
    _isLoading = false;
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
    _preview = null;
    titleCtrl = TextEditingController(text: doc?.title);
    acCtrl = TextEditingController(text: doc?.ac);
    descriptionCtrl = TextEditingController(text: doc?.description);
    valueCtrl = TextEditingController(text: doc?.value);
    notifyListeners();
  }

  void setPreview(File? file) {
    _preview = file;
    notifyListeners();
  }

  Future<void> getSavedPdfs() async {
    _isLoading = true;
    notifyListeners();

    try {
      _documents = [
        DocDto(
          name: 'Orçamento-${DateTime.now().toFileName}',
          title: titleCtrl.text,
          ac: acCtrl.text,
          description: descriptionCtrl.text,
          value: valueCtrl.text,
          createdAt: DateTime.now(),
        ),
        DocDto(
          name: 'Orçamento-${DateTime.now().toFileName}',
          title: titleCtrl.text,
          ac: acCtrl.text,
          description: descriptionCtrl.text,
          value: valueCtrl.text,
          createdAt: DateTime.now(),
        ),
      ];
      _documents.sort(
        (a, b) =>
            (a.createdAt?.isBefore(b.createdAt ?? DateTime.now()) ?? false)
                ? -1
                : 1,
      );
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Ocorreu um erro ao buscar os PDFs: $e');
      _isLoading = false;
      notifyListeners();
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
    try {
      final newDoc = DocDto(
        name: 'Orçamento-${DateTime.now().toFileName}',
        title: titleCtrl.text,
        ac: acCtrl.text,
        description: descriptionCtrl.text,
        value: valueCtrl.text,
        createdAt: DateTime.now(),
      );

      // _preview = await _pdfSerivce.create(newDoc, user);

      // newDoc.path = _preview?.path;

      // await _docDataService.addDoc(newDoc);

      notifyListeners();
      getSavedPdfs();
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateDocument(DocDto doc, UserDto user) async {
    try {
      final newDoc = DocDto(
        name: doc.name,
        path: doc.path,
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
