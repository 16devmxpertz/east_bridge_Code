import 'dart:convert';
import 'package:east_bridge/Global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class GlobalPermissionAdvisory extends StatefulWidget {
  static late int Advisoryclientid = 0;
  static late int AdvisoryIdService = 0;
  static var Advisorydraftprogress = {
    "Fees": false,
    "MileStone": false,
    "ScopeOfWork": false
  };

  static int clientIdglobal = 0; // Initialize with your default value
  static int AdvisoryIdglobal = 0;
  static String clientNameGlobal = "";
  static String AdvisoryServiceNameGlobal = "";
  static List<String> milestones = [];
  static List<int> milestonesduration = [];
  static int clientIdglobalRedeem = 0; // Initialize with your default value
  static int AdvisoryIdglobalRedeem = 0;
  static Map<String, bool> items = {};
  static TextEditingController TotalFeesValue = new TextEditingController();
  static List<TextEditingController> li = [];
  static List<TextEditingController> duration = [];
  static List<List<TextEditingController>> FeesList = [];
  static List<Map<String, dynamic>> feesListfinal = [];
  static TextEditingController scopeOfWork = new TextEditingController();
  static TextEditingController description = new TextEditingController();
}
