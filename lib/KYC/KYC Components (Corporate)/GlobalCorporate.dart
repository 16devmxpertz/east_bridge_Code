import 'dart:convert';
import 'package:east_bridge/Global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class GlobalPermissionCorporate extends StatefulWidget {
  static late int corporateclientid = 0;
  static var corporatedraftprogress = {};
  static Future<void> getdraftprogresscorporate(int clientid) async {
    if (clientid <= 0) {
      return;
    }
    var url =
        '${GlobalPermission.urlLink}/api/getDraftProgress/getDraftProgressOfClientCorporate?ClientId=${clientid}';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print("ducccccc");
        var jsonResponse = jsonDecode(response.body);
        corporatedraftprogress = jsonResponse;
        print(corporatedraftprogress);
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
