import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class UserData {
  String? name;
  String? phone;
  List<Point>? signature;

  UserData({
    this.name,
    this.phone,
    this.signature,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'signature': signature
          ?.map(
            (element) => {
              'offset': {
                'x': element.offset.dx,
                'y': element.offset.dy,
              },
              'type': element.type.name,
              'pressure': element.pressure,
            },
          )
          .toList(),
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name'],
      phone: map['phone'],
      signature: map['signature'] != null
          ? List.from(
              (map['signature'] as List).map(
                (element) => Point(
                  Offset(
                    element['offset']['x'],
                    element['offset']['y'],
                  ),
                  PointType.values.firstWhere(
                    (type) => type.name == element['type'],
                    orElse: () => PointType.tap,
                  ),
                  element['pressure'],
                ),
              ),
            )
          : null,
    );
  }
}
