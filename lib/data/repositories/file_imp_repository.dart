import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:orca_ai/core/enums/file_provider_type.dart';
import 'package:orca_ai/data/data.dart';
import 'package:orca_ai/data/datasources/file/file_datasource.dart';
import 'package:orca_ai/domain/repositories/file_repository.dart';
import 'package:share_plus/share_plus.dart';

class FileImpRepository implements FileRepository {
  late final FileDatasource _fileDataSource;

  FileImpRepository({required FileDatasource fileDataSource}) {
    _fileDataSource = fileDataSource;
  }

  @override
  Future<void> delete({
    required FileProviderType provider,
    required String path,
  }) async {
    try {
      return await _fileDataSource.delete(provider: provider, path: path);
    } catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  @override
  Future<Uint8List> download({required String url}) async {
    try {
      return await _fileDataSource.download(url: url);
    } catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  @override
  Future<FileDto> upload({
    required String path,
    required String contentType,
    required Uint8List file,
    Function(double p1)? onProgress,
  }) async {
    try {
      return await _fileDataSource.upload(
        path: path,
        file: file,
        contentType: contentType,
        onProgress: onProgress,
      );
    } catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  @override
  Future<ShareResult> share({required File file}) async {
    try {
      return await _fileDataSource.share(file: file);
    } catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }
}
