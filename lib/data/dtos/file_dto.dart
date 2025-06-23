import 'package:orca_ai/core/enums/file_provider_type.dart';
import 'package:orca_ai/core/enums/file_type.dart';
import 'package:orca_ai/core/enums/status.dart';
import 'package:collection/collection.dart';

class FileDto {
  String? url;
  String? name;
  String? path;
  FileType? type;
  FileProviderType? provider;
  DateTime? createdAt;
  Status? status;

  FileDto({
    this.url,
    this.name,
    this.path,
    this.type,
    this.provider,
    this.createdAt,
    this.status = Status.success,
  });

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

  // Future<File?> downloadFile() async {
  //   if (url == null || name == null) return null;

  //   final fileUseCase = Modular.get<FileUseCase>();

  //   return await fileUseCase.download(url: url ?? '', name: name ?? '');
  // }

  // Future<void> deleteRemoteFile() async {
  //   if (provider == null || path == null) return;

  //   final fileUseCase = Modular.get<FileUseCase>();

  //   await fileUseCase.delete(provider: provider!, path: path!);
  // }
}
