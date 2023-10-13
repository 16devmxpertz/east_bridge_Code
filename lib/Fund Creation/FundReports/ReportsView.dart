import 'dart:convert';

import 'package:east_bridge/Fund%20Creation/FundGlobal.dart';
import 'package:east_bridge/Fund%20Creation/TabOfFundCreation.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components/GloablIndividual.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:webview_flutter/webview_flutter.dart';

class ReportsView extends StatefulWidget {
  ReportsView({@required controller}) {
    tabController = controller;
  }
  @override
  State<ReportsView> createState() => _ReportsViewState();
  static ValueNotifier<String> name = ValueNotifier("");
}

TabController? tabController;

class _ReportsViewState extends State<ReportsView> {
  Map<String, String> typename = {};

  TextEditingController tempName = new TextEditingController();
  String? valueText;
  List<String> finalitems = [];
  bool _agreementError = false;
  final _formKey = GlobalKey<FormState>();
  String button = "Browse";
  int? editIndex; // Updated type to int?
  bool btn = true;
  @override
  void initState() {
    super.initState();
    print("----");
  }

  var username = 'Administrator';
  var password = 'hX9b7aBd\$2Z';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          // height: 1000, // Adjust the height as needed
          // color: Colors.red,
          child: Html(
            data: '''
                <div>
            <iframe src="https://${username}:${password}@eastbridge.online/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2fClientDetailsReport&rs:Command=Render"
                    type="application/pdf" width="100%" height="1000"></iframe>
                </div>
              ''',
          ),
        ),
      ],
    );
  }
}
