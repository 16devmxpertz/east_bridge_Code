import 'dart:convert';
import 'package:east_bridge/Fund%20Creation/FundGlobal.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/CC3.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/GlobalCorporate.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/KYC%20Components%20(Corporate)/InvestmentPortfolioBCorporate.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/contact.dart';
import 'package:east_bridge/KYC/KYC%20Components%20POA/GlobalPOA.dart';
import 'package:east_bridge/KYC/KYC%20Components%20POA/InvestmentPortfolioBPOA.dart';
import 'package:east_bridge/KYC/KYC%20Components/CC2.dart';
import 'package:east_bridge/KYC/KYC%20Components/FATCA.dart';
import 'package:east_bridge/KYC/KYC%20Components/GloablIndividual.dart';
import 'package:east_bridge/KYC/KYC%20Components/InvestmentPortfolioB.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class DropdownValuesGlobal extends StatefulWidget {
  static Map<String, List<String>> dropDown = {};

  static void getDropownValues(String type) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse(
          '${GlobalPermission.urlLink}/api/DropDownItems/getDropdownMap?type=${type}'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      dynamic x = jsonDecode(response.body);

      for (var i in x.keys.toList()) {
        List<String> k = [];
        for (var j in x[i]) {
          k.add(j.toString());
        }
        dropDown[i] = k;
      }
      print("nnnnnnnnnnnnnnnnnnnnnnnn");
      print(dropDown);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }
}
