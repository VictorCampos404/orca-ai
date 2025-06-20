import 'package:flutter/material.dart';
import 'package:orca_ai/core/constants/app_text_styles.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Dashboard", style: AppTextStyles.megaTitle)),
    );
  }
}
