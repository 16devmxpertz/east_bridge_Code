import 'dart:convert';
import 'package:east_bridge/Global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class GlobalPermissionPortfolio extends StatefulWidget {
  static late int PortfolioId = 0;
  static var Portfoliodraftprogress = {};
  static Future<void> getdraftprogressfund(int PortfolioId) async {
    if (PortfolioId <= 0) {
      return;
    }
    var url =
        '${GlobalPermission.urlLink}/api/GetPortfolioDraftProgress/GetPortfolioDraftProgress?ShareId=${PortfolioId}';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print("Portfolio Draft");
        print(response.body);
        Portfoliodraftprogress = jsonDecode(response.body);

        print(Portfoliodraftprogress);
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
