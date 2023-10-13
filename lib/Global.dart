import 'dart:convert';
import 'package:east_bridge/Fund%20Creation/FundGlobal.dart';
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

abstract class GlobalPermission extends StatefulWidget {
  static late int? employeeId = -10;
  static late String? userType = "";

  static late String urlLink = "https://eastbridge.online/apicore";
  //static late String urlLink = "https://localhost:44323";
  static var userRole = [
    'Admin',
    'Compliance',
    'Relationship Manager',
    'Investment Department',
    'Operation Manager',
    'Portfolio Manager',
    'Finance Manager',
    'CEO'
  ];
  static Future<Map<String, dynamic>> formPermission(String formName) async {
    var p = {};
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.get(
      Uri.parse(
          '${GlobalPermission.urlLink}/api/DashBoardAdminPermisssions/AdminPermissions?EmployeeId=$employeeId&FormName=$formName'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      // Request successful, handle the response
      var responseData = jsonDecode(response.body);
      final Map<String, dynamic> data =
          (json.decode(response.body) as Map<String, dynamic>)
              .map((key, value) => MapEntry(key, value as bool));
      return data;

      // Process the responseData
    } else {
      // Request failed, handle the error
      var errorMessage = response.reasonPhrase;
      print(response.statusCode);
      print(response.body);
      final Map<String, bool> data =
          (json.decode(response.body) as Map<String, dynamic>)
              .map((key, value) => MapEntry(key, value as bool));
      return data;
    }
  }

  static Future<bool> formApproval(
      String Formname, int owner, String name, int FormId) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/FormTableLive/FormApprovals?FormName=${Formname}&owner=${owner}&name=${name}&FormId=${FormId}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = {"FormName": Formname, "owner": owner, "name": name};
      print(body);
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        return true;
      } else {
        print(response.statusCode);
        return (false);
        // Handle the error condition
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static late var notificationList = [];
  static late var version = 0.5;
  static late var notifiacationbottomvalues = [];
  static late int count = 0;
  static Future<bool> getnotoficationslist(String? usertype) async {
    notifiacationbottomvalues.clear();
    notificationList.clear();
    count = 0;
    print(GlobalPermission.notifiacationbottomvalues);
    print(GlobalPermission.notificationList);

    final response = await http.get(Uri.parse(
        '${GlobalPermission.urlLink}/api/FormPermissionAssign/GetApprovalsOfForm'));

    print("tanveer");
    // print(GlobalPermission.userType);

    if (response.statusCode == 200) {
      final json = response.body;
      var li = jsonDecode(json) as List;
      print(li);

      for (var i in li) {
        if (i.values.contains(usertype)) {
          GlobalPermission.notificationList.add(i["formName"]);
          GlobalPermission.notifiacationbottomvalues.add(0);
          print(i["formName"]);
        }
      }

      print(notificationList);
    } else {
      print("tanveer Error");
      return false;

      // throw Exception('Failed to fetch data');
    }
    return false;
  }

  static late var countries = [""];
  static late var states = [""];
  static late var cities = [""];
  static getCountries() async {
    var res = await rootBundle
        .loadString('packages/csc_picker/lib/assets/country.json');
    var r = jsonDecode(res);
    List<String> li = [];

    for (int i = 0; i < r.length; i++) {
      li.add(r[i]["emoji"] + "~" + r[i]["name"]);
    }
    countries = li;
  }

  static getState(String country) async {
    print(country);
    var res = await rootBundle
        .loadString('packages/csc_picker/lib/assets/country.json');
    var r = jsonDecode(res);
    List<String> li = [];
    for (int i = 0; i < r.length; i++) {
      if (r[i]["name"] == country.split("~")[1]) {
        var block = r[i]["state"];
        for (int j = 0; j < block.length; j++) {
          print(block[j]["name"]);
          li.add(block[j]["name"]);
        }
      }
    }
    states = li;
  }

  static getCity(String country, String state) async {
    var res = await rootBundle
        .loadString('packages/csc_picker/lib/assets/country.json');
    var r = jsonDecode(res);
    List<String> li = [];
    for (int i = 0; i < r.length; i++) {
      if (r[i]["name"] == country.split("~")[1]) {
        var block = r[i]["state"];
        for (int j = 0; j < block.length; j++) {
          if (block[j]["name"] == state) {
            var blocki = block[j]["city"];
            // print(blocki);
            for (int k = 0; k < blocki.length; k++) {
              li.add(blocki[k]["name"]);
            }
          }
        }
      }
    }
    cities = li;
  }

  static reportsDownloadKYC(int id, String formname) async {
    // formname = formname.split('~')[1];

    if (formname == "Individual") {
      formname = "IndividualFinal";
    }
    if (formname == "Corporate") {
      formname = "Corporate";
    }
    if (formname == "POA") {
      formname = "POAFinal";
    }
    // Replace 'your_username' and 'your_password' with your actual credentials
    var username = 'Administrator';
    var password = 'hX9b7aBd\$2Z';
    var url = Uri.parse(
        "https://${username}:${password}@eastbridge.online/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2f${formname}&rs:Command=Render&ID=${id}");

    //   if (await canLaunchUrl(url)) {
    //     await launchUrl(url);
    //   } else {
    //     print("error can' ssrs launch");
    //   }
    await launchUrl(url);
  }

  static reportsDownloadKYCApproval(int id, String formname) async {
    formname = formname.split('~')[1];

    if (formname == "Individual") {
      formname = "IndividualFinal";
    }
    if (formname == "Corporate") {
      formname = "Corporate";
    }
    if (formname == "POA") {
      formname = "POAFinal";
    }
    // Replace 'your_username' and 'your_password' with your actual credentials
    var username = 'Administrator';
    var password = 'hX9b7aBd\$2Z';
    var url = Uri.parse(
        "https://${username}:${password}@eastbridge.online/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2f${formname}&rs:Command=Render&ID=${id}");

    //   if (await canLaunchUrl(url)) {
    //     await launchUrl(url);
    //   } else {
    //     print("error can' ssrs launch");
    //   }
    await launchUrl(url);
  }

  static reportsDownloadFund(
      int clientid, int fundid, String formname, String year) async {
    String reportname = "";
    if (formname == "Trading Movements") {
      reportname = "TradingMovementNew";
    }
    if (formname == "Fund") {
      reportname = "FundReport";
    }
    if (formname == "Fund Annual") {
      reportname = "InvestmentFundAnnualReport";
    }

    // Replace 'your_username' and 'your_password' with your actual credentials
    var username = 'Administrator';
    var password = 'hX9b7aBd\$2Z';
    var url;
    if (formname == "Fund") {
      url = Uri.parse(
          "https://${username}:${password}@eastbridge.online/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2f${reportname}&rs:Command=Render&ID=${fundid}&Year=${year}&FID=${fundid}");
    } else if (formname == "Fund Annual") {
      url = Uri.parse(
          "https://${username}:${password}@eastbridge.online/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2f${reportname}&rs:Command=Render&FID=${fundid}&Year=${year}");
    } else {
      url = Uri.parse(
          "https://${username}:${password}@eastbridge.online/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2f${reportname}&rs:Command=Render&CID=${clientid}&FID=${fundid}");
    }
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static reportsDownloadFund2(int clientid, String formname) async {
    String reportname = "";

    if (formname == "Realized P/L") {
      reportname = "real2";
    }
    if (formname == "Order History") {
      reportname = "ordernew2";
    }
    if (formname == "Transfer Inquiry") {
      reportname = "TransferInquiry";
    }
    if (formname == "Cash Statement") {
      reportname = "CashStatement";
    }
    if (formname == "Client") {
      reportname = "ClientsReportnew";
    }
    if (formname == "DPM") {
      reportname = "DPMReport";
    }
    // Replace 'your_username' and 'your_password' with your actual credentials
    var username = 'Administrator';
    var password = 'hX9b7aBd\$2Z';
    var url;
    if (formname == "Client") {
      url = Uri.parse(
          "https://${username}:${password}@eastbridge.online/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2f${reportname}&rs:Command=Render&CID=${clientid}&IT=Fund");
    } else if (formname == "DPM") {
      url = Uri.parse(
          "https://${username}:${password}@eastbridge.online/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2f${reportname}&rs:Command=Render");
    } else {
      url = Uri.parse(
          "https://${username}:${password}@eastbridge.online/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2f${reportname}&rs:Command=Render&CID=${clientid}");
    }

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void SetDefault() {
    GlobalIndividual.individualclientid = 0;
    GlobalIndividual.individualdraftprogress = {};
    GlobalPermissionCorporate.corporateclientid = 0;
    GlobalPermissionCorporate.corporatedraftprogress = {};
    GlobalPOA.poalclientid = 0;
    GlobalPOA.poadraftprogress = {};

    FATCA.country.value = "";
    FATCA.city.value = "";
    FATCA.state.value = "";
    FATCA.buildingNum.value = "";
    FATCA.streetNAme.value = "";
    FATCA.district.value = "";
    FATCA.postalCode.value = "";
    FATCA.firstNAme.value = "";
    FATCA.fatherName.value = "";
    FATCA.grandFatherName.value = "";
    FATCA.familyName.value = "";
    FATCA.firstNameArabic.value = "";
    FATCA.fatherNameArabic.value = "";
    FATCA.grandFatherNameArabic.value = "";
    FATCA.familyNameArabic.value = "";
    FATCA.placeOfBirth.value = "";
    FATCA.dob.value = "";
    FATCA.dobHijri.value = "";

    FATCA.clientName.value = "";
    FATCA.clientNameAr.value = "";
    // CC2.clientType2.value = "";
    // CC3.clientType2.value = "";

    GlobalPermissionFund.Fundclientid = 0;
    GlobalPermissionFund.Funddraftprogress = {};
    InvestmentPortfolioBPOA.clientName.value = "";
    InvestmentPortfolioB.clientName.value = "";
    // InvestmentPortfolioBCorporate
    ContactInfoo.city.value = "";
    ContactInfoo.country.value = "";
    ContactInfoo.state.value = "";
    ContactInfoo.street.value = "";
    ContactInfoo.bn.value = "";
  }
}
