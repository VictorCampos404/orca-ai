import 'package:flutter/cupertino.dart';
import 'package:orca_ai/core/enums/device.dart';

class DeviceBuilder extends StatelessWidget {
  final Widget Function(BuildContext, Device) builder;

  const DeviceBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= Device.phone.maxWidth) {
          return builder(context, Device.phone);
        }

        if (constraints.maxWidth <= Device.tablet.maxWidth) {
          return builder(context, Device.tablet);
        }

        return builder(context, Device.desktop);
      },
    );
  }
}
