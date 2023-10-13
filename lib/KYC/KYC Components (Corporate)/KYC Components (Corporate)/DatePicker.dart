import 'package:flutter/material.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:intl/intl.dart';


class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController dateController=new TextEditingController();
  void initState(){
    super.initState();
    dateController.text=" ";
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 130,
        height: 35,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: ColorSelect.textField
            )
        ),

        child: Padding(
          padding: EdgeInsets.only(left: 5),
          child: TextField(
            controller: dateController,
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.calendar_month_outlined,size: 15,),
                labelText: S.of(context).DateFormat,
                labelStyle: TextController.labelText,
                border: InputBorder.none
                
            ),
            //readOnly: true,
            onTap: ()async{
              DateTime? datepicked=await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(3000)
              );
              if(datepicked != null ){
                print(datepicked);  //get the picked date in the format => 2022-07-04 00:00:00.000
                String formattedDate = DateFormat('yyyy-MM-dd').format(datepicked);
                WidgetsBinding.instance.addPostFrameCallback((_) => setState((dateController.text = formattedDate) as VoidCallback));
                // format date in required form here we use yyyy-MM-dd that means time is remove


              }else{
                print("Date is not selected");
              }
            },
          ),
        )
    );
  }
}
