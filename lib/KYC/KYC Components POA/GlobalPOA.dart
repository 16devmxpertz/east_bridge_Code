import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class GlobalPOA extends StatefulWidget {
  static late int poalclientid = 0;
  static var poadraftprogress = {};

  static Future<void> getdraftprogresspoa(int clientid) async {
    if (clientid <= 0) {
      return;
    }
    var url =
        'https://eastbridge.online/apicore/api/getDraftProgress/getDraftProgressOfClientPOA?ClientId=${clientid}';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        poadraftprogress = jsonResponse;
        print(poadraftprogress);
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
