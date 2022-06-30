import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:growmaxx_admin/Admin/requestInvestments.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List search = ["All", "Credit", "Debit"];
  String?selectedValue;
  String? dates;
  DateTime? end_date;
  DateTime ?start;
  String? end;
  DateTimeRange? dateTimeRange;
  var diff;
  var investments = FirebaseFirestore.instance.collection("Investments")
      .snapshots();
  bool pressed = false;
  var requestinvestments =
  FirebaseFirestore.instance.collection("requestInvestments").snapshots();
  var requestWithdrawls =
  FirebaseFirestore.instance.collection("requestwithdrawls").snapshots();
 List transactions =[];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12.3),
      child: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Container(
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.brown),
                  borderRadius: BorderRadius.circular(12.6),),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(),
                      margin: EdgeInsets.only(left: 12.3),
                      alignment: Alignment.topLeft,
                      child: Text("Available Funds",
                          style: TextStyle(color: Colors.orange, fontSize: 15)),
                    ),
                    SizedBox(height: 10,),
                    StreamBuilder<QuerySnapshot>(
                      stream: investments,
                      builder: (context, snap) {
                        double total = 0.0;
                        if (snap.hasData && snap.requireData.docs.length > 0) {
                          var investments = snap.data;
                          total = get_total(investments);
                          return Container(
                            child: Text(total.toString(),
                              style: TextStyle(color: Colors.blue),),
                          );
                        }
                        return Container();
                      },
                    ),
                    SizedBox(height: 10,),

                  ],
                ),
              ),
              SizedBox(height: 15,),
              selected_type(),
              SizedBox(height: 20,),
              display_buttons(),
              SizedBox(height: 10,),

            ],
          ),
        ],
      ),
    );
  }

  get_total(QuerySnapshot<Object?>? investments) {
    var total = 0.0;
    for (int i = 0; i < investments!.docs.length; i++) {
      total = total + double.parse(investments.docs[i].get("InvestAmount"));
    }
    return total;
  }

  display_buttons() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1.25,
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(right: 3.3),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(1.3)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Container(
                        child: TextButton(
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero),
                          onPressed: () async {
                            dateTimeRange =
                            await showDateRangePicker(
                              context: context,
                              firstDate: DateTime(2022),
                              lastDate: DateTime.now().add(const Duration(days: 1)),
                            );
                            setState(() {
                              start = dateTimeRange!.start;
                              end_date = dateTimeRange!.end;
                              dates = DateFormat('yyyy-MM-dd')
                                  .format(dateTimeRange!.start);
                              end = DateFormat("yyyy-MM-dd").format(
                                  dateTimeRange!.end);
                            });
                          },
                          child: Icon(
                            Icons.date_range_outlined,
                            size: 25,
                          ),
                        )),
                  ),
                  Text(dateTimeRange != null
                      ? dates.toString() + "  -  " + end.toString()
                      : "Select date"),
                ],
              ),
            ),

          ],
        ),
        Center(
          child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                elevation: 0.6,
                minimumSize: Size(120, 30),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.3)),),
              onPressed: () {
                setState(() {
                  pressed = true;
                });
              },
              child: Text("Submit", style: TextStyle(color: Colors
                  .white),)),
        ),
        pressed == true ? Column(
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Date"),
                Text("Phonenumber"),
                Text("Transactions"),
              ],
            ),
            Divider(color: Colors.grey,),
            ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                get_alltransactions(),
              ],
            ),
            start!=null?Container(
              child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.deepOrange.shade400,
                    elevation: 0.6,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.3)),
                    minimumSize: Size(120, 30)
                  ),
                onPressed: () async{
                   get_data(transactions);
                },
                child: Text("Download",style: TextStyle(color: Colors.white),),
              ),
            ):Container(),
          ],
        ) : Container(),
      ],
    );
  }

  selected_type() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(right: 12.3),
            child: Text("Transaction  : - ")),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Row(
              children: const [

                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    'Select Transaction',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: search
                .map((item) =>
                DropdownMenuItem<String>(
                  value: item,
                  child: Center(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as String;
              });
            },
            icon: const Icon(
              Icons.arrow_drop_down,
            ),
            iconSize: 14,
            iconEnabledColor: Colors.yellow,
            iconDisabledColor: Colors.grey,
            buttonHeight: 40,
            buttonWidth: 150,
            buttonPadding: const EdgeInsets.only(
                left: 14, right: 14, bottom: 1.3),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
              color: Colors.blue,
            ),
            buttonElevation: 2,
            alignment: Alignment.center,
            itemHeight: 40,
            dropdownPadding: null,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.blue.shade500,
            ),
            dropdownElevation: 5,
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
          ),
        ),
      ],
    );
  }

  get_alltransactions() {
    return StreamBuilder<QuerySnapshot>(
      stream: requestinvestments,
      builder: (context, snap) {
        if (snap.hasData) {
          List<QueryDocumentSnapshot> userinvestments = snap.data!.docs;

          return start!=null? StreamBuilder<QuerySnapshot>(
            stream: requestWithdrawls,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<QueryDocumentSnapshot> userwithdrawls = snapshot.data!.docs;
                userinvestments.addAll(userwithdrawls);
                List selected_dates = getDaysInBetween(start!, end_date!);
                List dates = get_dates(userinvestments, selectedValue);
                transactions = get_transactions(dates, selectedValue, selected_dates, userinvestments);
                return Container(
                  child: ListView.builder(
                    physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: transactions.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 14.3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(transactions[index][0]),
                              Text(transactions[index][1].toString()),
                              transactions[index][2][0]=="+"?Container(child: Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(right: 3.3),
                                      child: Text(transactions[index][2][0].toString(),style: TextStyle(color: Colors.green),)),
                                  Text(transactions[index][3],style: TextStyle(color: Colors.green),),
                                ],
                              ),):Container(
                                child: Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(right: 3.3),
                                        child: Text(transactions[index][2][0].toString(),style: TextStyle(color: Colors.red),)),
                                      Text(transactions[index][3],style: TextStyle(color: Colors.red),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                );
              }
              return Container();
            },
          ): Container();
        }
        return CircularProgressIndicator();
      },
    );
  }

  get_dates(List<QueryDocumentSnapshot<Object?>> userinvestments,
      String? selectedValue,) {
    DateTime? date;
    List all_dates = [];
    List dates = [];
    if (selectedValue != null) {
      for (int i = 0; i < userinvestments.length; i++) {
        if (selectedValue == "All") {
          if (userinvestments[i].get("status") == "Accept") {
            date = DateTime.fromMicrosecondsSinceEpoch(userinvestments[i]
                .get("CreatedAt")
                .microsecondsSinceEpoch);
            dates.add(date);
            all_dates = get_sort(dates);
          }
        }

        if (selectedValue == userinvestments[i].get("Type")) {
          if (userinvestments[i].get("status") == "Accept") {
            date = DateTime.fromMicrosecondsSinceEpoch(userinvestments[i]
                .get("CreatedAt")
                .microsecondsSinceEpoch);
            dates.add(date);
            all_dates = get_sort(dates);
          }
          else {
            if (userinvestments[i].get("status") == "Accept") {
              var date = DateTime.fromMicrosecondsSinceEpoch(userinvestments[i]
                  .get("CreatedAt")
                  .microsecondsSinceEpoch);
              dates.add(date);
              all_dates = get_sort(dates);
            }
          }
        }
      }
    }
    return all_dates;
  }

  get_sort(List dates) {
    List format_dates = [];
    for (int i = 0; i < dates.length; i++) {
      dates.sort((a, b) {
        return a.compareTo(b);
      },);
    }

    return dates;
  }

  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate
        .difference(startDate)
        .inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  get_transactions(dates, String? selectedValue, List selected_dates,
      List<QueryDocumentSnapshot> userinvestments) {
    List format_dates = [];
    List all_transactions = [];
    List all_dates = [];
    String symbol;
    List afterSort = [];
    String? dateformat;

    for (int i = 0; i < selected_dates.length; i++) {
      format_dates.add(DateFormat('dd/MM/yyyy').format(selected_dates[i]));
    }

    for(int j=0;j<dates.length;j++){
       dateformat = DateFormat('dd/MM/yyyy').format(dates[j]);
       for(int k=0;k<format_dates.length;k++){
          if(dateformat==format_dates[k]){
            for(int l =0;l<userinvestments.length;l++){
            DateTime dateTime = userinvestments[l].get("CreatedAt").toDate();
              if(userinvestments[l].get("status")=="Accept"&&dates[j]==dateTime){
                var datetime = DateFormat('dd/MM/yyyy').format(dateTime);
                if(userinvestments[l].get("Type")=="Credit"){
                  symbol ="+";
                }
                else{
                  symbol= " - ";
                }
               all_transactions.add([dateformat,userinvestments[l].get("phonenumber"),[symbol],userinvestments[l].get("InvestAmount")]);
              }
            }
          }
       }
    }
     return all_transactions;
  }

get_data(List transactions) async {

  Map<Permission, PermissionStatus> statuses = await [
  Permission.storage,
  ].request();
  List<List<dynamic>> rows = [];
  List<dynamic> row  =[];
   row.add("Date");
   row.add("phonenumber");
   row.add("Amount");
  rows.add(row);
   for(int i=0;i<transactions.length;i++){
     List<dynamic> row  =[];
    row.add(transactions[i][0]);
    row.add(transactions[i][1]);
    row.add(transactions[i][2][0] + transactions[i][3]);
    rows.add(row);
   }
  String? csv =  ListToCsvConverter().convert(rows);
  String dir;

  dir = await ExternalPath.getExternalStoragePublicDirectory(
      ExternalPath.DIRECTORY_DOWNLOADS);
  print("dir $dir");
  String file = "$dir";
   print(file);
  File f = File(file + "/transactions.csv");

  f.writeAsString(csv);

}

}