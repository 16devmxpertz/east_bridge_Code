import 'dart:convert';
import 'package:east_bridge/Global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class GlobalPermissionFund extends StatefulWidget {
  static late int Fundclientid = 0;
  static var Funddraftprogress = {};
  static Future<void> getdraftprogressfund(int fundid) async {
    if (fundid <= 0) {
      return;
    }
    var url =
        '${GlobalPermission.urlLink}/api/getFundDraftProgress/getDraftProgressOfFund?FundId=${fundid}';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print("Fund Draft");
        print(response.body);
        Funddraftprogress = jsonDecode(response.body);

        print(Funddraftprogress);
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
