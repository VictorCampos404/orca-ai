import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:orca_ai/core/enums/file_provider_type.dart';
import 'package:orca_ai/core/enums/file_type.dart';
import 'package:orca_ai/data/data.dart';
import 'package:orca_ai/services/firebase_storage_service.dart';
import 'package:share_plus/share_plus.dart';

class FileImpDatasource implements FileDatasource {
  final FirebaseStorageService _firebaseStorageService;

  FileImpDatasource(this._firebaseStorageService);

  @override
  Future<void> delete({
    required FileProviderType provider,
    required String path,
  }) async {
    if (provider == FileProviderType.firebase) {
      return _firebaseStorageService.delete(path: path);
    }
  }

  @override
  Future<Uint8List> download({required String url}) async {
    final dio = Dio();

    final response = await dio.get(
      url,
      options: Options(responseType: ResponseType.bytes),
    );

    if (response.statusCode == 200) {
      return Uint8List.fromList(response.data);
    }

    throw Exception(
      'Falha ao carregar dados. Código de status: ${response.statusCode}',
    );
  }

  @override
  Future<FileDto> upload({
    required String path,
    required String contentType,
    required Uint8List file,
    Function(double p1)? onProgress,
  }) async {
    final url = await _firebaseStorageService.upload(
      path: path,
      file: file,
      contentType: contentType,
      onProgress: onProgress,
    );

    final name = path.split('/').last.split('.').first;
    final typeString = path.split('/').last.split('.').last;

    return FileDto(
      url: url,
      path: path,
      provider: FileProviderType.firebase,
      type: FileType.values.firstWhere(
        (element) => element.name == typeString,
        orElse: () => FileType.unknow,
      ),
      name: name,
      bytes: file,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<ShareResult> share({required File file}) async {
    final params = ShareParams(files: [XFile(file.path)]);

    return await SharePlus.instance.share(params);
  }
}
