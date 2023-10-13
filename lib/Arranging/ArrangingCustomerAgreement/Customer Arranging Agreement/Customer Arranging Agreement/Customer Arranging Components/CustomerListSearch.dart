import 'dart:convert';

import 'package:east_bridge/Agreement%20Masters/CustomerGetAgreement.dart';
import 'package:east_bridge/FundAgreement/Customer%20Fund%20Agreement/Customer%20Fund%20Agreement/Customer%20Fund%20Components/AgreementCustomerSearchComponent.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomerListArr extends StatefulWidget {
  const CustomerListArr({super.key, TabController? controller});

  @override
  State<CustomerListArr> createState() => _CustomerListArrState();
}

class _CustomerListArrState extends State<CustomerListArr> {
  List title = [];
  String dropdownvalue = 'Item 1';
  List li = [];
  List key = [];
  @override
  void initState() {
    super.initState();
    //fetchData();
  }

  void getData() async {
    try {
      print("ShahGet1");
      //Map fetchedData = await fetchData();
      print("ShahGet2");
      setState(() {
        print("ShahGet3");
        //title = fetchedData as List ;
        print("ShahGet4");
      });
    } catch (e) {
      print("ShahGetError");
      print(e);
    }
  }

  var services = [
    'DPM',
    'Non DPM',
    'Advisory',
    'Arranging',
    'Fund',
  ];

  double yOffset = 0;
  double xOffset = 0;
  bool sidBarOpen = false;
  bool _sidebarVisible = false;

  bool get sidebarVisible => _sidebarVisible;

  Map map = {};

  void toggleSidebar() {
    _sidebarVisible = !_sidebarVisible;
  }

  void setSideBarState() {
    setState(() {
      xOffset = sidBarOpen ? 250 : 0;
    });
  }

  void customerSearch() async {
    var url = Uri.parse(
        'http://8.213.23.26:8081/apicore/api/EmployerInformation1/EmployerInformation/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        // "name": EmployerInfo.id.value,
        // "email": _employerName.text,
        // "clienttye": _employerAddress.text,
        // "CountryName": _employerPhone.text,
        // "State": _duration.text,
        // "City": dropdownvalue,
        // "range":
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AgreementCustomerSearchComponent(),
            Container(
              // height: 800,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: li.length,
                itemBuilder: (BuildContext context, int index) {
                  return card(li[index], key[index], context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget card(String templateName, String templateKeys, BuildContext context) {
  return SingleChildScrollView(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SingleChildScrollView(
          child: Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Card(
              //color: Colors.white,
              elevation: 5.0,
              margin: EdgeInsets.all(4.0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      templateName,
                      style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      templateKeys,
                      style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Fund Name",
                      style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                new customerGetAgreement(templateKeys)));
                      },
                      child: Icon(
                        Icons.edit,
                        color: ColorSelect.tabTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

void getTemplate() async {
  var url = Uri.parse(
      'http://8.213.23.26:8081/apicore/api/AgreementTemplate/AgreementTemplatesGet?templateid=4002');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    print(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}
