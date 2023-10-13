import 'dart:convert';
import 'package:east_bridge/Global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class GlobalPermissionDPM extends StatefulWidget {
  static late int DPMid = 0;
  static var DPMdraftprogress = {};
  static Future<void> getdraftprogressfund(int DPMid) async {
    if (DPMid <= 0) {
      return;
    }
    var url =
        '${GlobalPermission.urlLink}/api/GetDpmDraftProgress/GetDpmDraftProgress?ShareId=${DPMid}';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
      
        DPMdraftprogress = jsonDecode(response.body);

        print(DPMdraftprogress);
      } else {
        // Request failed, handle the error
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      // Request failed, handle the exception
      print('Exception occurred while fetching data: $e');
    }
  }
}
