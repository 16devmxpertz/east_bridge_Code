import 'package:flutter/material.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:hijri_picker/hijri_picker.dart';
import 'package:hijri/hijri_calendar.dart';

class HijriDatePicker extends StatefulWidget {
  const HijriDatePicker({Key? key}) : super(key: key);

  @override
  State<HijriDatePicker> createState() => _HijriDatePickerState();
}

class _HijriDatePickerState extends State<HijriDatePicker> {
  TextEditingController dateController = new TextEditingController();
  void initState() {
    super.initState();
    dateController.text = " ";
  }

  var selectedDate = new HijriCalendar.now();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 130,
        height: 48,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: ColorSelect.textField)),
        child: Padding(
          padding: EdgeInsets.only(left: 5, top: 0),
          child: TextField(
            controller: dateController,
            decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.calendar_month_outlined,
                  size: 15,
                ),
                labelText: S.of(context).DateFormat,
                labelStyle: TextController.labelText,
                border: InputBorder.none),
            //readOnly: true,
            onTap: () async {
              final HijriCalendar? picked = await showHijriDatePicker(
                context: context,
                initialDate: selectedDate,
                lastDate: new HijriCalendar()
                  ..hYear = 1445
                  ..hMonth = 9
                  ..hDay = 25,
                firstDate: new HijriCalendar()
                  ..hYear = 1438
                  ..hMonth = 12
                  ..hDay = 25,
                initialDatePickerMode: DatePickerMode.day,
              );
              if (picked != null) {
                //print(picked);
                WidgetsBinding.instance.addPostFrameCallback((_) => setState(
                    (dateController.text = picked.toString()) as VoidCallback));
              }
            },
          ),
        ));
  }
}
