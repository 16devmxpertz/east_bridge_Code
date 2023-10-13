import 'package:east_bridge/User%20Management/UserManagement.dart';
import 'package:flutter/material.dart';

class DesktopDashboard extends StatelessWidget {
  const DesktopDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green[300],
      body: UserManagement(),
    );
  }
}
