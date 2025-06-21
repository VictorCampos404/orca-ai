import 'dart:io';

class DocDto {
  String? path;
  String? name;
  String? title;
  String? ac;
  String? description;
  String? value;
  DateTime? createdAt;

  DocDto({
    this.path,
    this.name,
    this.title,
    this.ac,
    this.description,
    this.value,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'path': path,
      'name': name,
      'title': title,
      'ac': ac,
      'description': description,
      'value': value,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory DocDto.fromMap(Map<String, dynamic> map) {
    return DocDto(
      path: map['path'],
      name: map['name'],
      title: map['title'],
      ac: map['ac'],
      description: map['description'],
      value: map['value'],
      createdAt:
          map['createdAt'] == null
              ? null
              : DateTime.parse(map['createdAt'] as String),
    );
  }

  File? get file {
    if (path == null) return null;

    return File(path!);
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
}
