import 'dart:convert';

import 'package:east_bridge/Advisory/Advisory%20Subscribe/AdvisorySubscribe.dart';
import 'package:east_bridge/Advisory/AdvisoryAgreement/DefaultAgreement.dart';
import 'package:east_bridge/Advisory/AdvisoryAgreementNew/agreementSearchAdvisory.dart';
import 'package:east_bridge/Advisory/AdvisoryBankDetails.dart';
import 'package:east_bridge/Advisory/AdvisoryDetails.dart';
import 'package:east_bridge/Advisory/CustomerGetAdvisoryAgreementdefault.dart';
import 'package:east_bridge/Advisory/EditAdvisoryAgreementSearch.dart';
import 'package:east_bridge/Advisory/SubServiceCreation/subServiceCreationAdv.dart';
import 'package:east_bridge/Advisory/SubServiceCreation/subServiceFeesAdvNew.dart';

import 'package:east_bridge/Agreement%20Masters/CustomerAddAgreement.dart';
import 'package:east_bridge/Fund%20Creation/FundBankDetails.dart';
import 'package:east_bridge/Fund%20Creation/FundFinancialDetails.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

enum SingingCharacter { yes, no }

class masterServiceSearchAdvisory extends StatefulWidget {
  masterServiceSearchAdvisory({@required controller}) {
    tabController = controller;
  }

  @override
  State<masterServiceSearchAdvisory> createState() =>
      masterServiceSearchAdvisoryState();
}

enum RadioSelected { RadioOne, RadioTwo }

TabController? tabController;

class masterServiceSearchAdvisoryState
    extends State<masterServiceSearchAdvisory> {
  masterServiceSearchAdvisory({@required controller}) {
    tabController = controller;
  }

  int getKeyByValue(String value) {
    for (var entry in map.entries) {
      if (entry.value.split("-")[0] == value) {
        return int.parse(entry.key);
      }
    }
    return 0; // Value not found
  }

  List li = [];
  List key = [];
  Map map = {};
  Map treedic = {};
  List parentNodes = [];
  List treekeys = [];
  List treevalues = [];
  void fetchData() async {
    print("Shah");
    final response = await http.get(Uri.parse(
        '${GlobalPermission.urlLink}/api/AdvisoryCreateService/GetAdvisoryServiceNames'));

    if (response.statusCode == 200) {
      print("Shah2");
      final json = response.body;
      //print(json.decode(response.body));
      print(json);
      setState(() {
        map = jsonDecode(json);
      });

      // title=json.decode(response.body);
      li = map.values.toList();
      key = map.keys.toList();
      for (int i = 0; i < li.length; i++) {
        var templi = [];
        print(key[i]);
        for (int j = 0; j < li.length; j++) {
          if (li[j].split("-")[2] == key[i]) {
            templi.add((li[j].split("-")[0]));
          }
        }
        treedic[(li[i].split("-")[0])] = templi;
      }

      var values = treedic.values;
      print(values);
      for (var j in treedic.keys) {
        var flag = true;
        for (var i in values) {
          if (i.contains(j) == true) {
            flag = false;
          }
        }
        if (flag) {
          parentNodes.add(j);
        }
      }
      print("=====");
      treekeys = treedic.keys.toList();
      treevalues = treedic.values.toList();
      print(treedic);
      print(treekeys);
      print(treevalues);
      print(parentNodes);
      print(map);
      // }
    } else {
      print("ShahError");
      throw Exception('Failed to fetch data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Widget generateItems(String node, List childs, double ml, bool isparent) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: ColorSelect.tabBorderColor, width: 1),
          ),
        ),
        margin: EdgeInsets.only(left: ml),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  (isparent == true)
                      ? Container(
                          // margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 1,
                          width: 12,
                          color: ColorSelect.tabBorderColor,
                          // decoration: BoxDecoration(
                          //   color: Colors.black,
                          //   shape: BoxShape.circle,
                          // ),
                        )
                      : Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1,
                                    color: ColorSelect.tabBorderColor),
                              ),
                            ),
                          ),
                        ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(ColorSelect.east_blue)),
                      child: Text("${node}"),
                      onPressed: () {
                        print(node);
                        int id = getKeyByValue(node);
                        print(id);
                        subServiceCreationAdv.id.value = id;

                        // subServiceAdvisoryFees.id.value = id;
                        AdvisorygreementSearch.id.value = id;

                        tabController!.animateTo(1);
                      },
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    itemCount: childs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (childs.length > 0)
                                generateItems(childs[index],
                                    treedic[childs[index]], ml + 10, false),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: ColorSelect.tabBorderColor),
      ),
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: ListView.builder(
        // shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemCount: parentNodes.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: generateItems(
                  parentNodes[index], treedic[parentNodes[index]], 0, true));
        },
      ),
    );
  }
}
