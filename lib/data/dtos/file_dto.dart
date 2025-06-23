import 'dart:typed_data';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:orca_ai/core/enums/file_provider_type.dart';
import 'package:orca_ai/core/enums/file_type.dart';
import 'package:orca_ai/core/enums/status.dart';
import 'package:collection/collection.dart';
import 'package:orca_ai/domain/domain.dart';

class FileDto {
  String? url;
  String? name;
  String? path;
  FileType? type;
  FileProviderType? provider;
  DateTime? createdAt;
  Status? status;
  Uint8List? bytes;

  FileDto({
    this.url,
    this.name,
    this.path,
    this.type,
    this.provider,
    this.createdAt,
    this.bytes,
    this.status = Status.success,
  }) {
    _downloadBytes();
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'name': name,
      'path': path,
      'type': type?.name,
      'provider': provider?.name,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory FileDto.fromMap(Map<String, dynamic> map) {
    return FileDto(
      url: map['url'],
      name: map['name'],
      path: map['path'],
      type: FileType.values.firstWhereOrNull(
        (type) => type.name == map['type'],
      ),
      provider: FileProviderType.values.firstWhereOrNull(
        (type) => type.name == map['provider'],
      ),
      createdAt:
          map['createdAt'] == null
              ? null
              : DateTime.parse(map['createdAt'] as String),
    );
  }

  void _downloadBytes() async {
    if (url == null || bytes != null) return;

    final fileUseCase = Modular.get<FileUsecase>();

    bytes = await fileUseCase.download(url: url ?? '');
  }
}
