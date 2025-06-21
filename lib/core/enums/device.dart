enum Device {
  desktop(maxWidth: 0),
  tablet(maxWidth: 780),
  phone(maxWidth: 450);

  final double maxWidth;

  const Device({required this.maxWidth});
}
