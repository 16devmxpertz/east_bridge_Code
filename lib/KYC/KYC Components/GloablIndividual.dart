import 'dart:convert';
import 'package:east_bridge/Global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class GlobalIndividual extends StatefulWidget {
  static late int individualclientid = 0;
  static var individualdraftprogress = {};

  static Future<void> getdraftprogressindividual(int clientid) async {
    if (clientid <= 0) {
      return;
    }
    var url =
        '${GlobalPermission.urlLink}/api/getDraftProgress/getDraftProgressOfClientIndividual?ClientId=${clientid}';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        individualdraftprogress = jsonResponse;
        print(individualdraftprogress);
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
