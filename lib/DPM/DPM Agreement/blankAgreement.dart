import 'dart:convert';

import 'package:east_bridge/Agreement%20Masters/CustomerGetAgreement.dart';
import 'package:east_bridge/DPM/DPM%20Agreement/DefaultAgreement.dart';
import 'package:east_bridge/DPM/DPM%20Agreement/GetAgreement.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BlankAgreement extends StatefulWidget {
  BlankAgreement({super.key, TabController? controller});

  @override
  State<BlankAgreement> createState() => _CustomerDPMAgreementSearchState();
  static ValueNotifier<int> id = new ValueNotifier(0);
}

class _CustomerDPMAgreementSearchState extends State<BlankAgreement> {
  List title = [];
  String dropdownvalue = 'Item 1';
  List li = [];
  List key = [];
  @override
  void initState() {
    super.initState();
  }

  double yOffset = 0;
  double xOffset = 0;
  bool sidBarOpen = false;
  bool _sidebarVisible = false;

  bool get sidebarVisible => _sidebarVisible;

  Map map = {};

  void toggleSidebar() {
    _sidebarVisible = !_sidebarVisible;
  }

  void setSideBarState() {
    setState(() {
      xOffset = sidBarOpen ? 250 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Text("Please select Client & Agreement first !"),
          ),
        ],
      ),
    ));
  }
}
