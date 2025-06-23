import 'dart:io';
import 'dart:typed_data';

import 'package:orca_ai/core/enums/file_provider_type.dart';
import 'package:orca_ai/core/enums/file_type.dart';
import 'package:orca_ai/data/data.dart';
import 'package:orca_ai/data/datasources/file/file_datasource.dart';
import 'package:orca_ai/services/firebase_storage_service.dart';
import 'package:share_plus/share_plus.dart';

class FileImpDatasource implements FileDatasource {
  // late CustomFileDownload downloaderService;
  late FirebaseStorageService firebaseStorageService;

  FileImpDatasource({
    // required this.downloaderService,
    required this.firebaseStorageService,
  });

  @override
  Future<void> delete({
    required FileProviderType provider,
    required String path,
  }) async {
    if (provider == FileProviderType.firebase) {
      return firebaseStorageService.delete(path: path);
    }
  }

  @override
  Future<File> download({required String url, required String name}) async {
    // return await downloaderService.inTemporaryDirectoryFromUrl(
    //   url: url,
    //   name: name,
    // );
    return File("");
  }

  @override
  Future<FileDto> upload({
    required String path,
    required String contentType,
    required Uint8List file,
    Function(double p1)? onProgress,
  }) async {
    final url = await firebaseStorageService.upload(
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
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<ShareResult> share({required File file}) async {
    final params = ShareParams(files: [XFile(file.path)]);

    return await SharePlus.instance.share(params);
  }
}
