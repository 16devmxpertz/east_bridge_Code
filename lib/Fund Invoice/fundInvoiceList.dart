import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/Global.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:syncfusion_flutter_core/theme.dart';
import 'package:http/http.dart' as http;

import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:url_launcher/url_launcher.dart';

class FundInvoiceList extends StatefulWidget {
  const FundInvoiceList({super.key});

  @override
  State<FundInvoiceList> createState() => _FundInvoiceListState();
}

class _FundInvoiceListState extends State<FundInvoiceList> {
  double yOffset = 0;
  double xOffset = 0;
  bool sidBarOpen = false;
  bool _sidebarVisible = false;
  String pages = "";
  int counting = 1;
  TextEditingController tcc = new TextEditingController();
  TextEditingController nav = new TextEditingController();
  TextEditingController aum = new TextEditingController();
  final GlobalKey<SfDataGridState> _dataGridKey = GlobalKey<SfDataGridState>();
  bool get sidebarVisible => _sidebarVisible;

  void toggleSidebar() {
    _sidebarVisible = !_sidebarVisible;
  }

  void setSideBarState() {
    setState(() {
      xOffset = sidBarOpen ? 250 : 0;
    });
  }

  var pageCount = [""];

  late InvoiceFundListData _InvoiceFundListData;
  late SfDataGrid _dataGrid;

  List<InvoiceData> invoices = <InvoiceData>[];

  @override
  void initState() {
    super.initState();

    getInvoiceData(1, 100);
  }

  int transaction = 0;
  int clientId = 0;

  void sendData(int tid, double tcc, double nav, double aum) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/GenerateFundInvoice/generateInvoiceForFund?transcationId=${tid}&totalCapitalCommitment=${tcc}&NetAssetValue=${nav}&AUM=${aum}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "transcationId": tid,
        "totalCapitalCommitment": tcc,
        "NetAssetValue": nav,
        "AUM": aum,
      };
      print(body);
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Invoice created Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // _launchURLApp();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => new FundInvoiceList()));
        // print(jsonDecode(response.body));
      } else {
        var errorMessage = response.reasonPhrase;
        print(response.statusCode);
        print(response.body);
        print("error");
        print(errorMessage);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getInvoiceData(int pn, int ps) async {
    List<InvoiceData> li = [];
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/GetFundInvoices/getFundInvoices?pageNo=${pn}&pageSize=${ps}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        setState(() {
          for (var i in data) {
            li.add(InvoiceData(
                i['transaction'],
                i['clientId'],
                i['clintName'],
                i['fundName'],
                i['type'],
                i['date'].split(" ")[0],
                i['invoiceCreated'] == true ? "View" : "Generate",
                i['Status'] == false ? "Unpaid" : "Paid"));
          }

          invoices = li;
        });
        print(invoices);
        print("______________");
        _InvoiceFundListData = InvoiceFundListData(invoicesx: invoices);
        print(invoices);
      } else {
        var errorMessage = response.reasonPhrase;
        print(response.statusCode);
        print(response.body);
        print("error");
        print(errorMessage);
      }
    } catch (e) {
      print(e.toString());
    }
    // return li;
  }

  static launchFundInvoice(int Tid, String formname, int cid) async {
    // formname = formname.split('~')[1];

    // Replace 'your_username' and 'your_password' with your actual credentials
    var username = 'Administrator';
    var password = 'hX9b7aBd\$2Z';
    var url = Uri.parse(
        "https://${username}:${password}@eastbridge.online/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2f${formname}&rs:Command=Render&TID=${Tid}&CID=${cid}");

    //   if (await canLaunchUrl(url)) {
    //     await launchUrl(url);
    //   } else {
    //     print("error can' ssrs launch");
    //   }
    await launchUrl(url);
  }

  late Map<String, double> columnWidths = {
    'TRid': double.nan,
    'Cid': double.nan,
    'clientName': double.nan,
    'fundName': double.nan,
    'type': double.nan,
    'date': double.nan,
    'invvoiceCreated': double.nan,
    'status': double.nan,
  };

  void AddNew() {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            title: Text(
              "Enter below details",
              style: TextController.BodyHeadingText,
            ),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  height: 200,
                  child: Column(
                    children: [
                      Container(
                        width: 500,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Total Capital Commitment",
                                      style: TextController.BodyText),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 250,
                                    height: 35,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ColorSelect.textField)),
                                    child: TextFormField(
                                      inputFormatters: <TextInputFormatter>[
                                        ThousandsSeparatorInputFormatter(),
                                      ],
                                      controller: tcc,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: TextController.BodyText,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          hintText: S.of(context).TypeHere,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 500,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Net Asset Value (NAV)",
                                      style: TextController.BodyText),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 250,
                                    height: 35,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.textField),
                                    ),
                                    child: TextFormField(
                                      inputFormatters: <TextInputFormatter>[
                                        ThousandsSeparatorInputFormatter(),
                                      ],
                                      controller: nav,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: TextController.BodyText,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          hintText: S.of(context).TypeHere,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Asset Under Management (AUM)",
                                      style: TextController.BodyText),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 250,
                                    height: 35,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ColorSelect.textField)),
                                    child: TextFormField(
                                      controller: aum,
                                      inputFormatters: <TextInputFormatter>[
                                        ThousandsSeparatorInputFormatter(),
                                      ],
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: TextController.BodyText,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          hintText: S.of(context).TypeHere,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  S.of(context).Cancel,
                ),
              ),
              TextButton(
                onPressed: () {
                  sendData(
                      transaction,
                      double.parse(tcc.text.replaceAll(",", "")),
                      double.parse(nav.text.replaceAll(",", "")),
                      double.parse(aum.text.replaceAll(",", "")));
                },
                child: Text(
                  S.of(context).Save,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  int findColumnIndexByName(String columnName, SfDataGrid grid) {
    for (int i = 0; i < grid.columns.length; i++) {
      if (grid.columns[i].columnName == columnName) {
        return i;
      }
    }
    return -1; // Return -1 if the column is not found.
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Header start
                      Column(
                        children: [
                          HeaderTop(),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 17, 0, 0),
                            width: double.infinity,
                            height: 40,
                            color: ColorSelect.east_blue,
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 40,
                                  child: Container(
                                    height: 40,
                                    child: Center(
                                      child: IconButton(
                                        color: Colors.white,
                                        icon: Icon(Icons.menu),
                                        onPressed: () {
                                          sidBarOpen = !sidBarOpen;
                                          setSideBarState();
                                          toggleSidebar();
                                        },
                                        // onPressed: () {

                                        // _globalKey.currentState?.openDrawer();
                                        // },
                                      ),
                                    ),
                                  ),
                                ),

                                // new
                                Container(
                                  // width: 100,
                                  height: 44,
                                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      //color: ColorSelect.east_blue,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.add_card_rounded,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Center(
                                            child: Text(
                                              S.of(context).New,
                                              style:
                                                  TextController.ControllerText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // EDIT
                                Container(
                                  // width: 100,
                                  height: 44,
                                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      //color: ColorSelect.east_blue,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.edit_calendar_outlined,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Center(
                                            child: Text(
                                              S.of(context).Edit,
                                              style:
                                                  TextController.ControllerText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // view
                                Container(
                                  // width: 100,
                                  height: 44,
                                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      //color: ColorSelect.east_blue,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.content_paste_search,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Center(
                                            child: Text(
                                              S.of(context).View,
                                              style:
                                                  TextController.ControllerText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // cancel
                                Container(
                                  // width: 100,
                                  height: 44,
                                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      //color: ColorSelect.east_blue,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.free_cancellation_outlined,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Center(
                                            child: Text(
                                              S.of(context).Cancel,
                                              style:
                                                  TextController.ControllerText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // print
                                Container(
                                  // width: 100,
                                  height: 44,
                                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      //color: ColorSelect.east_blue,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.print,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Center(
                                            child: Text(
                                              S.of(context).Print,
                                              style:
                                                  TextController.ControllerText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // download
                                Container(
                                  // width: 100,
                                  height: 44,
                                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      //color: ColorSelect.east_blue,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.download,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Center(
                                            child: Text(
                                              S.of(context).Download,
                                              style:
                                                  TextController.ControllerText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // saveDraft
                                Container(
                                  // width: 100,
                                  height: 44,
                                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      //color: ColorSelect.east_blue,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.save_as_outlined,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Center(
                                            child: Text(
                                              S.of(context).SaveDraft,
                                              style:
                                                  TextController.ControllerText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Header end

                      Stack(
                        children: [
                          AnimatedContainer(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            transform: Matrix4.translationValues(
                                xOffset, yOffset, 1.0),
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            color: Colors.white,
                            child: SingleChildScrollView(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 40,
                                ),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFFFFF),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3,
                                      color: Color.fromRGBO(0, 0, 0, 0.363),
                                    ),
                                  ],
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        margin: EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
                                          border: Border(
                                            bottom: BorderSide(
                                              color: ColorSelect.east_grey,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                S.of(context).FundInvoiceList,
                                                style: TextController
                                                    .MainHeadingText,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: SfDataGridTheme(
                                          data: SfDataGridThemeData(
                                              headerHoverColor:
                                                  ColorSelect.east_grey),
                                          child: _dataGrid = SfDataGrid(
                                            key: _dataGridKey,
                                            rowsPerPage: 10,
                                            // Pass column names or an identifier to the function
                                            onCellTap: (details) {
                                              final rowIndex = details
                                                      .rowColumnIndex.rowIndex -
                                                  1;
                                              final columnIndex = details
                                                  .rowColumnIndex.columnIndex;

                                              // Ensure the selected cell is not out of bounds and contains "Generate"
                                              if (rowIndex >= 0 &&
                                                  columnIndex >= 0) {
                                                final cellValue =
                                                    _InvoiceFundListData
                                                        .effectiveRows[rowIndex]
                                                        .getCells()[columnIndex]
                                                        .value
                                                        .toString();

                                                if (cellValue == "Generate") {
                                                  // Identify the "transaction id" column by name or identifier
                                                  final columnNameOrIdentifier =
                                                      "TRid"; // Replace with your actual column name or identifier

                                                  // Access the "transaction id" value associated with this row
                                                  final transactionIdColumnIndex =
                                                      findColumnIndexByName(
                                                          columnNameOrIdentifier,
                                                          _dataGrid);

                                                  if (transactionIdColumnIndex !=
                                                      -1) {
                                                    final transactionId =
                                                        _InvoiceFundListData
                                                            .effectiveRows[
                                                                rowIndex]
                                                            .getCells()[
                                                                transactionIdColumnIndex]
                                                            .value;
                                                    setState(() {
                                                      transaction =
                                                          transactionId;
                                                    });
                                                    // Now you can use the 'transactionId' as needed
                                                    print(
                                                        "Transaction ID: $transactionId");

                                                    // Call your 'AddNew' function here if needed
                                                    AddNew();
                                                  }
                                                } else if (cellValue ==
                                                    "View") {
                                                  // Identify the "transaction id" column by name or identifier
                                                  final columnNameOrIdentifier =
                                                      "TRid"; // Replace with your actual column name or identifier
                                                  final columnNameOrIdentifier2 =
                                                      "Cid";
                                                  // Access the "transaction id" value associated with this row
                                                  final transactionIdColumnIndex =
                                                      findColumnIndexByName(
                                                          columnNameOrIdentifier,
                                                          _dataGrid);
                                                  final clientIdColumnIndex =
                                                      findColumnIndexByName(
                                                          columnNameOrIdentifier2,
                                                          _dataGrid);

                                                  if (transactionIdColumnIndex !=
                                                      -1) {
                                                    final transactionId =
                                                        _InvoiceFundListData
                                                            .effectiveRows[
                                                                rowIndex]
                                                            .getCells()[
                                                                transactionIdColumnIndex]
                                                            .value;
                                                    final Client =
                                                        _InvoiceFundListData
                                                            .effectiveRows[
                                                                rowIndex]
                                                            .getCells()[
                                                                clientIdColumnIndex]
                                                            .value;

                                                    // Now you can use the 'transactionId' as needed
                                                    print(
                                                        "Transaction ID: $transactionId");
                                                    print(
                                                        "Transaction ID: $Client");
                                                    setState(() {
                                                      transaction =
                                                          transactionId;
                                                      clientId = Client;
                                                    });

                                                    // Call your 'AddNew' function here if needed
                                                    launchFundInvoice(
                                                        transaction,
                                                        "FundInvoice",
                                                        clientId);
                                                  }
                                                }
                                              }

                                              print(details.toString());
                                            },

                                            selectionMode: SelectionMode.single,
                                            // allowSorting : true,
                                            allowColumnsResizing: true,
                                            onColumnResizeUpdate:
                                                (ColumnResizeUpdateDetails
                                                    details) {
                                              setState(() {
                                                columnWidths[details
                                                        .column.columnName] =
                                                    details.width;
                                              });
                                              return true;
                                            },
                                            shrinkWrapRows: true,
                                            columnWidthMode:
                                                ColumnWidthMode.fill,
                                            source: _InvoiceFundListData,
                                            columns: [
                                              GridColumn(
                                                width: columnWidths['TRid']!,
                                                columnName: 'TRid',
                                                // visible: false,
                                                label: Container(
                                                  color: ColorSelect.east_grey,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    S.of(context).Transaction,
                                                    style: TextController
                                                        .BodyHeadingText1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              GridColumn(
                                                width: columnWidths['Cid']!,
                                                columnName: 'Cid',
                                                visible: false,
                                                label: Container(
                                                  color: ColorSelect.east_grey,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    S.of(context).ClientId,
                                                    style: TextController
                                                        .BodyHeadingText1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              GridColumn(
                                                width:
                                                    columnWidths['clientName']!,
                                                columnName: 'clientName',
                                                label: Container(
                                                  color: ColorSelect.east_grey,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    S.of(context).ClientName,
                                                    style: TextController
                                                        .BodyHeadingText1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              GridColumn(
                                                width:
                                                    columnWidths['fundName']!,
                                                columnName: 'fundName',
                                                label: Container(
                                                  color: ColorSelect.east_grey,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    S.of(context).FundName,
                                                    style: TextController
                                                        .BodyHeadingText1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              GridColumn(
                                                width: columnWidths['type']!,
                                                columnName: 'type',
                                                label: Container(
                                                  color: ColorSelect.east_grey,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    S.of(context).Type,
                                                    style: TextController
                                                        .BodyHeadingText1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              GridColumn(
                                                width: columnWidths['date']!,
                                                columnName: 'date',
                                                label: Container(
                                                  color: ColorSelect.east_grey,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    S.of(context).Date,
                                                    style: TextController
                                                        .BodyHeadingText1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              GridColumn(
                                                width: columnWidths[
                                                    'invvoiceCreated']!,
                                                columnName: 'invvoiceCreated',
                                                label: Container(
                                                  color: ColorSelect.east_grey,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Invoice Created",
                                                    style: TextController
                                                        .BodyHeadingText1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              GridColumn(
                                                width: columnWidths['status']!,
                                                columnName: 'status',
                                                label: Container(
                                                  color: ColorSelect.east_grey,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    S.of(context).Status,
                                                    style: TextController
                                                        .BodyHeadingText1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // paging buttons==================
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 20),
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons
                                                      .arrow_circle_left_outlined,
                                                  color: ColorSelect.bodytext,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "${counting}",
                                                style: TextController
                                                    .BodyHeadingText,
                                              ),
                                            ),
                                            Container(
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons
                                                      .arrow_circle_right_outlined,
                                                  color: ColorSelect.bodytext,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                            Container(
                                              width: 100,
                                              height: 35,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 0.5,
                                                  color: ColorSelect
                                                      .tabBorderColor,
                                                ),
                                              ),
                                              child: DropdownButton(
                                                hint: Text("Jump to",
                                                    style: TextController
                                                        .labelText),
                                                value: pages.isNotEmpty
                                                    ? pages
                                                    : null,
                                                isExpanded: true,
                                                underline: Container(),
                                                iconEnabledColor:
                                                    ColorSelect.east_dark_blue,
                                                items: pageCount.map(
                                                  (String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Text(
                                                        items,
                                                        style: TextController
                                                            .BodyText,
                                                      ),
                                                    );
                                                  },
                                                ).toList(),
                                                onChanged: (newValue) {
                                                  setState(
                                                    () {
                                                      pages = newValue!;
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (sidebarVisible) SideBar() else Container(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Navigation(),
            ],
          ),
        ),
      ),
    );
  }
}

class InvoiceFundListData extends DataGridSource {
  InvoiceFundListData({required List<InvoiceData> invoicesx}) {
    dataGridRows = invoicesx
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int>(
                columnName: 'TRid',
                value: dataGridRow.transaction,
              ),
              DataGridCell<int>(
                columnName: 'Cid',
                value: dataGridRow.clientId,
              ),
              DataGridCell<String>(
                columnName: 'clientName',
                value: dataGridRow.clintName,
              ),
              DataGridCell<String>(
                columnName: 'fundName',
                value: dataGridRow.fundName,
              ),
              DataGridCell<String>(
                columnName: 'type',
                value: dataGridRow.type,
              ),
              DataGridCell<String>(
                columnName: 'date',
                value: dataGridRow.date,
              ),
              DataGridCell<String>(
                columnName: 'invvoiceCreated',
                value: dataGridRow.invoiceCreated.toString(),
              ),
              DataGridCell<String>(
                columnName: 'status',
                value: dataGridRow.status.toString(),
              ),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>(
        (dataGridCell) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              dataGridCell.value.toString(),
              overflow: TextOverflow.ellipsis,
              style: TextController.BodyHeadingText,
            ),
          );
        },
      ).toList(),
    );
  }
}

class InvoiceData {
  InvoiceData(this.transaction, this.clientId, this.clintName, this.fundName,
      this.type, this.date, this.invoiceCreated, this.status);
  final int transaction;
  final int clientId;

  final String clintName;
  final String fundName;
  final String type;
  final String date;
  final String invoiceCreated;
  final String status;
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final String cleanedText = newValue.text.replaceAll(',', '');
    final parts = cleanedText.split('.');
    String formattedValue = _formatWithCommas(parts[0]);

    if (parts.length > 1) {
      formattedValue += '.' + parts[1];
    }

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }

  String _formatWithCommas(String text) {
    final int length = text.length;
    if (length <= 3) {
      return text;
    }
    String temp = "";
    int count = 3;
    int j = 0;
    for (int i = length - 1; i >= 0; i--) {
      j++;
      temp += text[i];
      if (j == count) {
        j = 0;
        temp += ",";
      }
    }

    temp = temp.split('').reversed.join('');
    if (temp[0] == ",") {
      temp = temp.substring(1);
    }
    return temp;
  }
}
