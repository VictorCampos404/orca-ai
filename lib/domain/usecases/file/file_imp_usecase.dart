import 'dart:io';
import 'dart:typed_data';
import 'package:orca_ai/core/enums/file_provider_type.dart';
import 'package:orca_ai/data/data.dart';
import 'package:orca_ai/domain/repositories/file_repository.dart';
import 'package:orca_ai/domain/usecases/file/file_usecase.dart';
import 'package:share_plus/share_plus.dart';

class FileImpUsecase implements FileUsecase {
  final FileRepository _fileRepository;

  FileImpUsecase(this._fileRepository);

  @override
  Future<Uint8List> download({required String url}) async {
    return await _fileRepository.download(url: url);
  }

  @override
  Future<FileDto> upload({
    required String path,
    required String contentType,
    required Uint8List file,
    Function(double)? onProgress,
  }) async {
    return await _fileRepository.upload(
      path: path,
      file: file,
      contentType: contentType,
      onProgress: onProgress,
    );
  }

  @override
  Future<void> delete({
    required FileProviderType provider,
    required String path,
  }) async {
    return await _fileRepository.delete(provider: provider, path: path);
  }

  @override
  Future<ShareResult> share({required File file}) async {
    return await _fileRepository.share(file: file);
  }
}
