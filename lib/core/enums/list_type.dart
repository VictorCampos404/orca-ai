import 'package:flutter/material.dart';
import 'package:orca_ai/core/constants/custom_icons.dart';

enum ListType {
  list(
    icon: CustomIcons.function_fill,
  ),
  grid(
    icon: CustomIcons.menu_fill,
  );

  final IconData icon;

  const ListType({
    required this.icon,
  });
}
