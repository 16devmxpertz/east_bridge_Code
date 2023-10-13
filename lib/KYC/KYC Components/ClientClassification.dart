import 'package:csc_picker/csc_picker.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:intl/intl.dart';

enum SingingCharacter { yes, no }

class ClientClassification extends StatefulWidget {
  //const ClientClassification({Key? key}) : super(key: key);
  ClientClassification({@required controller}) {
    tabController = controller;
  }
  @override
  State<ClientClassification> createState() => _ClientClassificationState();
}

TabController? tabController;

class _ClientClassificationState extends State<ClientClassification> {
  bool? isChecked = false;
  ClientClassification({@required controller}) {
    tabController = controller;
  }

  String ClientType = "";
  @override
  Widget build(BuildContext context) {
    int selectedValue = -1;
    @override
    void initState() {
      super.initState();
    }

    return Container(
      height: 650,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            S.of(context).PleaseClickOnTheLinkToKnowAbout,
                            style: TextController.BodyText,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            S.of(context).RnQClient,
                            style: TextController.browseText,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: Text(
                                S.of(context).RetailClient,
                                style: TextController.BodyText,
                              ),
                              value: "Retail",
                              tileColor: Colors.white,
                              groupValue: ClientType,
                              onChanged: (value) {
                                setState(() {
                                  ClientType = value.toString();
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: Text(
                                S.of(context).QualifiedClient,
                                style: TextController.BodyText,
                              ),
                              value: "Qualified",
                              tileColor: Colors.white,
                              groupValue: ClientType,
                              onChanged: (value) {
                                setState(() {
                                  ClientType = value.toString();
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: Text(
                                S.of(context).InstitutionalClient,
                                style: TextController.BodyText,
                              ),
                              value: "Institutional",
                              tileColor: Colors.white,
                              groupValue: ClientType,
                              onChanged: (value) {
                                setState(() {
                                  ClientType = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          S
                              .of(context)
                              .SubmitrelevantdocumentsifyouareQualifiedClient,
                          style: TextController.BodyHeadingText,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          child: Table(
                              border: TableBorder.all(
                                  color: ColorSelect.tabBorderColor),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: {
                                0: FixedColumnWidth(1000),
                                1: FixedColumnWidth(50),
                                2: FixedColumnWidth(200),
                              },
                              children: [
                                TableRow(children: [
                                  Container(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            S.of(context).CC1,
                                            style:
                                                TextController.BodyHeadingText,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 40,
                                  ),
                                  Container(
                                      height: 40,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Center(
                                            child: Text(
                                          S.of(context).DocumentType,
                                          style: TextController.BodyHeadingText,
                                          maxLines: 3,
                                        )),
                                      )),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            S.of(context).CC2,
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 40,
                                    child: Checkbox(
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            isChecked = val;
                                          });
                                        }),
                                  ),
                                  Center(
                                    child: Container(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Center(
                                              child: Column(
                                            children: [
                                              Text(
                                                S.of(context).UploadStatement,
                                                style: TextController
                                                    .BodyHeadingText,
                                                maxLines: 3,
                                              ),
                                              Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ],
                                          )),
                                        )),
                                  ),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            S.of(context).CC3,
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 40,
                                    child: Checkbox(
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            isChecked = val;
                                          });
                                        }),
                                  ),
                                  Center(
                                    child: Container(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Center(
                                              child: Column(
                                            children: [
                                              Text(
                                                S.of(context).UploadIncomeProof,
                                                style: TextController
                                                    .BodyHeadingText,
                                                maxLines: 3,
                                              ),
                                              Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ],
                                          )),
                                        )),
                                  ),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            S.of(context).CC4,
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 40,
                                    child: Checkbox(
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            isChecked = val;
                                          });
                                        }),
                                  ),
                                  Center(
                                    child: Container(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Center(
                                              child: Column(
                                            children: [
                                              Text(
                                                S
                                                    .of(context)
                                                    .UploadWorkExperience,
                                                style: TextController
                                                    .BodyHeadingText,
                                                maxLines: 3,
                                              ),
                                              Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ],
                                          )),
                                        )),
                                  ),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            S.of(context).CC5,
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 40,
                                    child: Checkbox(
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            isChecked = val;
                                          });
                                        }),
                                  ),
                                  Center(
                                    child: Container(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Center(
                                              child: Column(
                                            children: [
                                              Text(
                                                S.of(context).UploadCertificate,
                                                style: TextController
                                                    .BodyHeadingText,
                                                maxLines: 3,
                                              ),
                                              Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ],
                                          )),
                                        )),
                                  ),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            S.of(context).CC6,
                                            style: TextController.BodyTextCC,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 40,
                                    child: Checkbox(
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            isChecked = val;
                                          });
                                        }),
                                  ),
                                  Center(
                                    child: Container(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Center(
                                              child: Column(
                                            children: [
                                              Text(
                                                S.of(context).UploadCertificate,
                                                style: TextController
                                                    .BodyHeadingText,
                                                maxLines: 3,
                                              ),
                                              Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ],
                                          )),
                                        )),
                                  ),
                                ]),
                                /*TableRow(children: [
                                  Container(
                                      height: 50,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  S.of(context).CC71,
                                                  style:
                                                      TextController.BodyTextCC,
                                                ),
                                              ),
                                            ),

                                            /*Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      S.of(context).CC71,
                                                      style: TextController
                                                          .BodyTextCC,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      S.of(context).CC712,
                                                      style: TextController
                                                          .BodyTextCC,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      S.of(context).CC713,
                                                      style: TextController
                                                          .BodyTextCC,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),*/
                                          ))),
                                  Container(
                                    height: 50,
                                    child: Checkbox(
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            isChecked = val;
                                          });
                                        }),
                                  ),
                                  Center(
                                    child: Container(
                                        height: 50,
                                        child: Center(
                                            child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: Column(
                                              children: [
                                                Center(
                                                  child: Text(
                                                    S.of(context).UploadProof,
                                                    style: TextController
                                                        .BodyHeadingText,
                                                    maxLines: 3,
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    S.of(context).Browse,
                                                    style: TextController
                                                        .browseText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))),
                                  ),
                                ]),*/
                                TableRow(children: [
                                  Container(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            S.of(context).CC71,
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 40,
                                    child: Checkbox(
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            isChecked = val;
                                          });
                                        }),
                                  ),
                                  Center(
                                    child: Container(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Center(
                                              child: Column(
                                            children: [
                                              Text(
                                                S.of(context).UploadProof,
                                                style: TextController
                                                    .BodyHeadingText,
                                                maxLines: 3,
                                              ),
                                              Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ],
                                          )),
                                        )),
                                  ),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            S.of(context).CC8,
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 40,
                                    child: Checkbox(
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            isChecked = val;
                                          });
                                        }),
                                  ),
                                  Center(
                                    child: Container(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Center(
                                              child: Column(
                                            children: [
                                              Text(
                                                S.of(context).UploadProof,
                                                style: TextController
                                                    .BodyHeadingText,
                                                maxLines: 3,
                                              ),
                                              Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ],
                                          )),
                                        )),
                                  ),
                                ]),
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          child: Table(
                              border: TableBorder.all(
                                  color: ColorSelect.tabBorderColor),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: {
                                0: FixedColumnWidth(1000),
                                1: FixedColumnWidth(50),
                                2: FixedColumnWidth(200),
                              },
                              children: [
                                TableRow(children: [
                                  Container(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            S.of(context).CC9,
                                            style:
                                                TextController.BodyHeadingText,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 40,
                                  ),
                                  Container(
                                      height: 40,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Center(
                                            child: Text(
                                          S.of(context).DocumentType,
                                          style: TextController.BodyHeadingText,
                                          maxLines: 3,
                                        )),
                                      )),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 120,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Center(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      S.of(context).CC10,
                                                      style: TextController
                                                          .BodyTextCC,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      S.of(context).CC101,
                                                      style: TextController
                                                          .BodyTextCC,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      S.of(context).CC102,
                                                      style: TextController
                                                          .BodyTextCC,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 66,
                                    child: Checkbox(
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            isChecked = val;
                                          });
                                        }),
                                  ),
                                  Center(
                                    child: Container(
                                        height: 66,
                                        child: Center(
                                            child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: Column(
                                              children: [
                                                Center(
                                                  child: Text(
                                                    S.of(context).UploadProof,
                                                    style: TextController
                                                        .BodyHeadingText,
                                                    maxLines: 3,
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    S.of(context).Browse,
                                                    style: TextController
                                                        .browseText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))),
                                  ),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 140,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Center(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      S.of(context).CC11,
                                                      style: TextController
                                                          .BodyTextCC,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      S.of(context).CC111,
                                                      style: TextController
                                                          .BodyTextCC,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      S.of(context).CC112,
                                                      style: TextController
                                                          .BodyTextCC,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 66,
                                    child: Checkbox(
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            isChecked = val;
                                          });
                                        }),
                                  ),
                                  Center(
                                    child: Container(
                                        height: 66,
                                        child: Center(
                                            child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: Column(
                                              children: [
                                                Center(
                                                  child: Text(
                                                    S.of(context).UploadProof,
                                                    style: TextController
                                                        .BodyHeadingText,
                                                    maxLines: 3,
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    S.of(context).Browse,
                                                    style: TextController
                                                        .browseText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))),
                                  ),
                                ]),
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          child: Table(
                              border: TableBorder.all(
                                  color: ColorSelect.tabBorderColor),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: {
                                0: FixedColumnWidth(1000),
                                1: FixedColumnWidth(50),
                                2: FixedColumnWidth(200),
                              },
                              children: [
                                TableRow(children: [
                                  Container(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            S.of(context).CC14,
                                            style:
                                                TextController.BodyHeadingText,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 40,
                                  ),
                                  Container(
                                      height: 40,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Center(
                                            child: Text(
                                          S.of(context).DocumentType,
                                          style: TextController.BodyHeadingText,
                                          maxLines: 3,
                                        )),
                                      )),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 15,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              S.of(context).CC15,
                                              style: TextController.BodyTextCC,
                                            ),
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 66,
                                    child: Checkbox(
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            isChecked = val;
                                          });
                                        }),
                                  ),
                                  Center(
                                    child: Container(
                                        height: 66,
                                        child: Center(
                                            child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: Column(
                                              children: [
                                                Center(
                                                  child: Text(
                                                    S.of(context).UploadProof,
                                                    style: TextController
                                                        .BodyHeadingText,
                                                    maxLines: 3,
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    S.of(context).Browse,
                                                    style: TextController
                                                        .browseText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))),
                                  ),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 15,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              S.of(context).CC16,
                                              style: TextController.BodyTextCC,
                                            ),
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 66,
                                    child: Checkbox(
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            isChecked = val;
                                          });
                                        }),
                                  ),
                                  Center(
                                    child: Container(
                                        height: 66,
                                        child: Center(
                                            child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: Column(
                                              children: [
                                                Center(
                                                  child: Text(
                                                    S.of(context).UploadProof,
                                                    style: TextController
                                                        .BodyHeadingText,
                                                    maxLines: 3,
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    S.of(context).Browse,
                                                    style: TextController
                                                        .browseText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))),
                                  ),
                                ]),
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          S
                              .of(context)
                              .SubmitrelevantdocumentsifyouareInstitutionalClient,
                          style: TextController.BodyHeadingText,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          child: Table(
                              border: TableBorder.all(
                                  color: ColorSelect.tabBorderColor),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: {
                                0: FixedColumnWidth(1000),
                                1: FixedColumnWidth(50),
                                2: FixedColumnWidth(200),
                              },
                              children: [
                                TableRow(children: [
                                  Container(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            S.of(context).CC17,
                                            style:
                                                TextController.BodyHeadingText,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 40,
                                  ),
                                  Container(
                                      height: 40,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Center(
                                            child: Text(
                                          S.of(context).DocumentType,
                                          style: TextController.BodyHeadingText,
                                          maxLines: 3,
                                        )),
                                      )),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            S.of(context).CC18,
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 40,
                                    child: Checkbox(
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            isChecked = val;
                                          });
                                        }),
                                  ),
                                  Center(
                                    child: Container(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Center(
                                              child: Column(
                                            children: [
                                              Text(
                                                S.of(context).UploadDocument,
                                                style: TextController
                                                    .BodyHeadingText,
                                                maxLines: 3,
                                              ),
                                              Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ],
                                          )),
                                        )),
                                  ),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            S.of(context).CC19,
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 40,
                                    child: Checkbox(
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            isChecked = val;
                                          });
                                        }),
                                  ),
                                  Center(
                                    child: Container(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Center(
                                              child: Column(
                                            children: [
                                              Text(
                                                S.of(context).UploadDocument,
                                                style: TextController
                                                    .BodyHeadingText,
                                                maxLines: 3,
                                              ),
                                              Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ],
                                          )),
                                        )),
                                  ),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 120,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Center(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      S.of(context).CC20,
                                                      style: TextController
                                                          .BodyTextCC,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      S.of(context).CC201,
                                                      style: TextController
                                                          .BodyTextCC,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      S.of(context).CC202,
                                                      style: TextController
                                                          .BodyTextCC,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      S.of(context).CC203,
                                                      style: TextController
                                                          .BodyTextCC,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 66,
                                    child: Checkbox(
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            isChecked = val;
                                          });
                                        }),
                                  ),
                                  Center(
                                    child: Container(
                                        height: 66,
                                        child: Center(
                                            child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: Column(
                                              children: [
                                                Center(
                                                  child: Text(
                                                    S
                                                        .of(context)
                                                        .UploadDocument,
                                                    style: TextController
                                                        .BodyHeadingText,
                                                    maxLines: 3,
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    S.of(context).Browse,
                                                    style: TextController
                                                        .browseText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))),
                                  ),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            S.of(context).CC21,
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 40,
                                    child: Checkbox(
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            isChecked = val;
                                          });
                                        }),
                                  ),
                                  Center(
                                    child: Container(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Center(
                                              child: Column(
                                            children: [
                                              Text(
                                                S.of(context).UploadDocument,
                                                style: TextController
                                                    .BodyHeadingText,
                                                maxLines: 3,
                                              ),
                                              Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ],
                                          )),
                                        )),
                                  ),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            S.of(context).CC22,
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 40,
                                    child: Checkbox(
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            isChecked = val;
                                          });
                                        }),
                                  ),
                                  Center(
                                    child: Container(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Center(
                                              child: Column(
                                            children: [
                                              Text(
                                                S.of(context).UploadDocument,
                                                style: TextController
                                                    .BodyHeadingText,
                                                maxLines: 3,
                                              ),
                                              Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ],
                                          )),
                                        )),
                                  ),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            S.of(context).CC23,
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    height: 40,
                                    child: Checkbox(
                                        value: isChecked,
                                        onChanged: (val) {
                                          setState(() {
                                            isChecked = val;
                                          });
                                        }),
                                  ),
                                  Center(
                                    child: Container(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Center(
                                              child: Column(
                                            children: [
                                              Text(
                                                S.of(context).UploadDocument,
                                                style: TextController
                                                    .BodyHeadingText,
                                                maxLines: 3,
                                              ),
                                              Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ],
                                          )),
                                        )),
                                  ),
                                ]),
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 35,
                            width: 140,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: ColorSelect.tabBorderColor)),
                            child: TextButton(
                              onPressed: () {
                                tabController?.animateTo(0);
                              }, // Switch tabs
                              child: Text(
                                S.of(context).Back,
                                style: TextController.SideMenuText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 35,
                            width: 140,
                            decoration: BoxDecoration(
                                color: ColorSelect.east_blue,
                                border: Border.all(
                                    color: ColorSelect.tabBorderColor)),
                            child: TextButton(
                              onPressed: () {
                                tabController?.animateTo(2);
                              }, // Switch tabs
                              child: Text(
                                S.of(context).Next,
                                style: TextController.btnText,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
