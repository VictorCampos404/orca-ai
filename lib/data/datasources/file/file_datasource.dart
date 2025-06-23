import 'dart:io';
import 'dart:typed_data';

import 'package:orca_ai/core/enums/file_provider_type.dart';
import 'package:orca_ai/data/data.dart';
import 'package:share_plus/share_plus.dart';

abstract class FileDatasource {
  Future<File> download({required String url, required String name});
  Future<FileDto> upload({
    required String path,
    required String contentType,
    required Uint8List file,
    Function(double)? onProgress,
  });
  Future<void> delete({
    required FileProviderType provider,
    required String path,
  });
  Future<ShareResult> share({required File file});
}
