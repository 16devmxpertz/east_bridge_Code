import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:east_bridge/Advisory/AdvisoryCreation.dart';
import 'package:east_bridge/Advisory/AdvisoryGlobal.dart';
import 'package:east_bridge/Global.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as getX;
import 'package:get/get_core/get_core.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:east_bridge/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';

import 'dart:convert';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AdvisoryDetailss extends StatefulWidget {
  static ValueNotifier<int> id = ValueNotifier(0);
  static ValueNotifier<int> clientId = ValueNotifier(0);
  AdvisoryDetailss({@required controller}) {
    tabController = controller;
  }

  @override
  _AdvisoryDetailssState createState() => _AdvisoryDetailssState();
}

class _AdvisoryDetailssState extends State<AdvisoryDetailss> {
  //  Map<String, bool> items = {}; // List to store text field values
  // List<TextEditingController> li = [];
  // List<TextEditingController> duration = [];

  ////////////

  /////////////////
  bool _descError = false;
  bool _durationError = false;
  final _formKey = GlobalKey<FormState>();

  ///
  void addmilestone() async {
    GlobalPermissionAdvisory.items.clear();
    GlobalPermissionAdvisory.milestonesduration.clear();
    for (TextEditingController t in GlobalPermissionAdvisory.li) {
      GlobalPermissionAdvisory.items[t.text] = false;
    }
    setState(() {
      for (TextEditingController d in GlobalPermissionAdvisory.duration) {
        GlobalPermissionAdvisory.milestonesduration.add(int.parse(d.text));
      }
    });
    print("dataSending");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AdvisoryMileStone/ClientMileStroneCreation');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "ClientId": GlobalPermissionAdvisory.Advisoryclientid,
      "Milestones": GlobalPermissionAdvisory.items,
      "advisoryId": GlobalPermissionAdvisory.AdvisoryIdService,
      "Duration": GlobalPermissionAdvisory.milestonesduration
    };
    print(body);
    var response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      GlobalPermissionAdvisory.milestones =
          GlobalPermissionAdvisory.items.keys.toList();

      print(GlobalPermissionAdvisory.milestones);

      tabController!.animateTo(3);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  void PutData() async {
    for (TextEditingController t in GlobalPermissionAdvisory.li) {
      GlobalPermissionAdvisory.items[t.text] = false;
    }
    setState(() {
      for (TextEditingController d in GlobalPermissionAdvisory.duration) {
        GlobalPermissionAdvisory.milestonesduration.add(int.parse(d.text));
      }
    });
    print("dataSending");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AdvisoryMileStone/ClientMileStonAchived?ClientId=${GlobalPermissionAdvisory.Advisoryclientid}&AdvisoryId=${GlobalPermissionAdvisory.AdvisoryIdService}&MileStoneNumber=${GlobalPermissionAdvisory.milestonesduration}');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "ClientId": GlobalPermissionAdvisory.Advisoryclientid,
      "Milestones": GlobalPermissionAdvisory.items,
      "advisoryId": GlobalPermissionAdvisory.AdvisoryIdService,
      "Duration": GlobalPermissionAdvisory.milestonesduration
    };
    print(body);
    var response =
        await http.put(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      GlobalPermissionAdvisory.milestones =
          GlobalPermissionAdvisory.items.keys.toList();
      print(GlobalPermissionAdvisory.milestones);

      tabController!.animateTo(3);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  Future<void> fetchData(int Id) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AdvisoryMileStone/ClientMileStroneGet?ClientId=${GlobalPermissionAdvisory.Advisoryclientid}&Advisoryid=${GlobalPermissionAdvisory.AdvisoryIdService}'); // Replace with your API endpoint
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print("Data is Fetching");

      // Request was successful
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      List<dynamic> milestones = jsonResponse;

      setState(() {
        for (var x in milestones) {
          GlobalPermissionAdvisory.li
              .add(TextEditingController(text: x.toString().split("-")[0]));
        }
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    // li.clear();
    // items.clear();
    // duration.clear();

    // GlobalPermissionAdvisory.li.add(TextEditingController());
    // GlobalPermissionAdvisory.duration.add(TextEditingController());
    print(GlobalPermissionAdvisory.Advisorydraftprogress);
    //fetchData(9557);

    // if (GlobalPermissionAdvisory
    //         .Advisorydraftprogress["ClientAdvisoryMileStoneRelation"] ==
    //     true) {
    //   print("ftechinggg----------");
    //   fetchData(GlobalPermissionAdvisory.Advisoryclientid);
    // } else {}

    print(GlobalPermissionAdvisory.Advisorydraftprogress);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(children: [
              Text(
                "Service Name: ",
                style: TextController.InvA,
              ),
              Text(
                "${GlobalPermissionAdvisory.AdvisoryServiceNameGlobal}",
                style: TextController.InvA,
              ),
            ]),
            SizedBox(
              height: 20,
            ),
            Row(children: [
              Text(
                "Client Name: ",
                style: TextController.InvA,
              ),
              Text(
                "${GlobalPermissionAdvisory.clientNameGlobal}",
                style: TextController.InvA,
              ),
            ]),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),

                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: GlobalPermissionAdvisory
                        .li.length, // +1 for the "Add" button
                    itemBuilder: (context, index) {
                      // This is a text form field for an item
                      return Container(
                        child: ListTile(
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: 35,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  '${index + 1}',
                                  style: TextController.BodyHeadingText,
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      child: Text(
                                        "Milestone Description",
                                        style: TextController.BodyHeadingText,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 35,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          alignment: Alignment.centerLeft,
                                          child: TextFormField(
                                            style: TextController.BodyText,
                                            controller: GlobalPermissionAdvisory
                                                .li[index],
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                setState(() {
                                                  _descError = true;
                                                });
                                                return '';
                                              } else {
                                                setState(() {
                                                  _descError = false;
                                                });
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                              isDense: true,
                                              border: InputBorder.none,
                                              hintStyle:
                                                  TextController.labelText,
                                              hintText: 'Type Here',
                                            ),
                                          ),
                                        ),
                                        if (_descError)
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              "This field is required",
                                              style: TextController.errorText,
                                            ),
                                          )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      child: Text(
                                        "Duration (in days)",
                                        style: TextController.BodyHeadingText,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 35,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          alignment: Alignment.centerLeft,
                                          child: TextFormField(
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9]')),
                                            ],
                                            maxLength: 9,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                setState(() {
                                                  _durationError = true;
                                                });
                                                return '';
                                              } else {
                                                setState(() {
                                                  _durationError = false;
                                                });
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            controller: GlobalPermissionAdvisory
                                                .duration[index],
                                            style: TextController.BodyText,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              hintText: S.of(context).TypeHere,
                                              errorStyle:
                                                  TextStyle(height: 0.0),
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none,
                                              counterText: "",
                                            ),
                                          ),
                                        ),
                                        if (_durationError)
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              "This field is required",
                                              style: TextController.errorText,
                                            ),
                                          )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Flexible(
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     children: [
                              //       Container(
                              //         margin: EdgeInsets.symmetric(
                              //             vertical: 10, horizontal: 15),
                              //         child: Text(
                              //           "Milestone Fees",
                              //           style: TextController.BodyHeadingText,
                              //         ),
                              //       ),
                              //       Container(
                              //         height: 35,
                              //         margin: EdgeInsets.symmetric(horizontal: 15),
                              //         padding: EdgeInsets.symmetric(horizontal: 15),
                              //         decoration: BoxDecoration(
                              //             color: Colors.white,
                              //             border: Border.all(
                              //                 color: ColorSelect.textField)),
                              //         alignment: Alignment.centerLeft,
                              //         child: TextFormField(
                              //           style: TextController.BodyText,
                              //           controller: li[index],
                              //           decoration: InputDecoration(
                              //             isDense: true,
                              //             border: InputBorder.none,
                              //             hintStyle: TextController.labelText,
                              //             hintText: 'Type Here',
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Container(
                                height: 35,
                                alignment: Alignment.center,
                                child: IconButton(
                                    onPressed: () {
                                      print("delete");
                                      setState(() {
                                        GlobalPermissionAdvisory.li
                                            .removeAt(index);
                                        GlobalPermissionAdvisory.duration
                                            .removeAt(index);
                                      });
                                      print(GlobalPermissionAdvisory.li);
                                    },
                                    icon: Icon(Icons.delete)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // This is the "Add" button
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorSelect.east_blue,
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(ColorSelect.east_blue),
                      ),
                      onPressed: () {
                        print(GlobalPermissionAdvisory.li.length != 0);

                        setState(() {
                          if ((GlobalPermissionAdvisory.li.length != 0) &&
                              ((GlobalPermissionAdvisory.li.last.text == "") ||
                                  (GlobalPermissionAdvisory
                                          .duration.last.text ==
                                      ""))) {
                            Fluttertoast.showToast(
                                msg: "Fill Data",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            TextEditingController t =
                                new TextEditingController(text: "");
                            TextEditingController d =
                                new TextEditingController(text: "");
                            GlobalPermissionAdvisory.li.add(t);
                            GlobalPermissionAdvisory.duration
                                .add(d); // Add an empty item to the list
                          }
                        });
                      },
                      child: Text('Add'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 35,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: ColorSelect.tabBorderColor)),
                        child: TextButton(
                          onPressed: () {
                            tabController!.animateTo(1);
                          }, // Switch tabs
                          child: Text(
                            S.of(context).Back,
                            style: TextController.SideMenuText,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 35,
                    width: 140,
                    decoration: BoxDecoration(
                      color: ColorSelect.east_blue,
                    ),
                    child: TextButton(
                      onPressed: () {
                        if ((GlobalPermissionAdvisory.li.length != 0) &&
                            ((GlobalPermissionAdvisory.li.last.text == "") ||
                                (GlobalPermissionAdvisory.duration.last.text ==
                                    ""))) {
                          Fluttertoast.showToast(
                              msg: "Fill Data",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          return;
                        }
                        if (_formKey.currentState!.validate() &&
                            GlobalPermissionAdvisory.Advisoryclientid != 0 &&
                            !_descError &&
                            !_durationError &&
                            GlobalPermissionAdvisory.AdvisoryIdService != 0) {
                          addmilestone();
                        } else {
                          Fluttertoast.showToast(
                              msg:
                                  "Please Select Client Then Advisory Id First",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }

                        // subServiceAdvisoryFees.id.value = id;
                      }, // Switch tabs
                      child: Text(
                        S.of(context).Next,
                        style: TextController.btnText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
