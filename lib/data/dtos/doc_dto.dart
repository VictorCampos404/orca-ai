import 'package:orca_ai/data/data.dart';

class DocDto {
  String? id;
  String? title;
  String? ac;
  String? description;
  String? value;
  DateTime? createdAt;
  FileDto? file;

  DocDto({
    this.id,
    this.title,
    this.ac,
    this.description,
    this.value,
    this.createdAt,
    this.file,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'ac': ac,
      'description': description,
      'value': value,
      'createdAt': createdAt?.toIso8601String(),
      'file': file?.toMap(),
    };
  }

  factory DocDto.fromMap(Map<String, dynamic> map) {
    return DocDto(
      id: map['id'],
      title: map['title'],
      ac: map['ac'],
      description: map['description'],
      value: map['value'],
      createdAt:
          map['createdAt'] == null
              ? null
              : DateTime.parse(map['createdAt'] as String),
      file: map['file'] == null ? null : FileDto.fromMap(map['file']),
    );
  }

  double? get valueToDouble {
    if ((value ?? '').isEmpty) return null;

    try {
      return double.tryParse(
        value
                ?.replaceAll('R\$', '')
                .trim()
                .replaceAll('.', '')
                .replaceAll(',', '.') ??
            '',
      );
    } catch (error) {
      return null;
    }
  }

  String? get valueInFull {
    final n = valueToDouble;

    if (n == null) return null;

    // return extenso(n).capitalizar();
    return '';
  }

  bool get havePreview {
    return !(file?.bytes == null || file?.name == null);
  }
}
