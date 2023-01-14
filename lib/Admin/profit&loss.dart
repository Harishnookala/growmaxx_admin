import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adminPannel.dart';

class profit extends StatefulWidget {
  const profit({Key? key}) : super(key: key);

  @override
  _profitState createState() => _profitState();
}

class _profitState extends State<profit> {
  int count = 0;
  var plus_button = false;
  var minu_button = false;
  var pressed = false;
  bool inprogress = false;
  TextEditingController percentageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.3),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
              child: const Text(
            "Today Profits",
            style: TextStyle(color: Colors.pinkAccent, fontSize: 16),
          )),
          const Divider(
            thickness: 0.6,
            color: Colors.black,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            child: Row(
              children: [
                const Text(
                  "Today Status  : - ",
                  style: TextStyle(fontSize: 15),
                ),
                Container(
                  margin: EdgeInsets.only(left: 13.3),
                  child: build_percentage(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            child: Center(
              child: TextButton(
                style: TextButton.styleFrom(
                    minimumSize: const Size(130, 3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.3)),
                    backgroundColor: Colors.green.shade400),
                onPressed: () async {
                  if (percentageController.text.isNotEmpty) {
                    setState(() {
                      inprogress = true;
                    });
                    var dates = DateFormat('yyy-dd-MMM').format(DateTime.now());
                    Map<String, dynamic> data = {
                      "CreatedAt": DateTime.now(),
                      "Todayprofit": percentageController.text.toString()
                    };
                    await FirebaseFirestore.instance
                        .collection("Admin")
                        .doc(dates)
                        .set(data);

                    var investments = await get_data(percentageController.text);

                    setState(() {
                      pressed = true;
                      count = 0;
                      pressed = false;
                    });
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "Submit",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.5,
                              fontFamily: "Poppins-Medium",
                              fontSize: 18),
                        ),
                      ),
                      inprogress
                          ? Container(
                              margin: EdgeInsets.only(left: 15.3),
                              child: CircularProgressIndicator())
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          pressed
              ? Center(
                  child: Text("----Loading-----"),
                )
              : Container(),
        ],
      ),
    );
  }

  build_percentage() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.0,
      height: 54,
      child: TextFormField(
        textAlign: TextAlign.left,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.tealAccent, width: 1.8),
            ),
            hintText: "percentage",
            labelText: "Profit",
            labelStyle: const TextStyle(color: Color(0xff576630)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xcc9fce4c), width: 1.5),
            ),
            hintStyle: const TextStyle(color: Colors.brown)),
        controller: percentageController,
        cursorColor: Colors.orange,
        style: const TextStyle(
            letterSpacing: 0.5,
            color: Colors.deepPurpleAccent,
            fontSize: 16,
            fontFamily: "poppins-Medium"),
      ),
    );
  }

  get_data(String text) async {
    bool flag = false;
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    var values =
        await FirebaseFirestore.instance.collection("razor_investments").get();
    List get_values = [];
    var profit = await FirebaseFirestore.instance.collection("Profit").get();
    var id;
    double today_profit = double.parse(text);
    if (today_profit.isNegative) {
      var data = negative_value(values, profit);
    } else {
      var portfolio = get_profit(values, profit);
      add_data(portfolio, profit);
    }
  }

  List get_profit(QuerySnapshot<Map<String, dynamic>> values,
      QuerySnapshot<Map<String, dynamic>> profit) {
    List get_values = [];
    var id;
    for (int i = 0; i < values.docs.length; i++) {
      id = values.docs[i].id;
      List portfolio = values.docs[i].get("Portfolio");
      String phonenumber = values.docs[i].get("phonenumber");
      double total = 0.0;
      for (int j = 0; j < portfolio.length; j++) {
        total = total + portfolio[j];
      }
      var percentageAmount =
          (total * double.parse(percentageController.text)) / 100;
      String fixestwo = percentageAmount.toStringAsFixed(2);
      double profit = double.parse(fixestwo);
      get_values.add([phonenumber, profit]);
    }
    return get_values;
  }

  add_data(List get_values, QuerySnapshot<Map<String, dynamic>> profit) async {
    for(int i=0;i<get_values.length;i++){
      if(profit.docs.isNotEmpty){
        var id;
        bool? flag;
        for(int j=0;j<profit.docs.length;j++){
          if(get_values[i][0]==profit.docs[j].get("phonenumber")){
            flag = true;
            id = profit.docs[j].id;
            Map<String,dynamic>data ={
              "Profit":get_values[i][1]
            };
            await FirebaseFirestore.instance.collection("Profit")
                .doc(id)
                .update(data);
            break;
          } else {
            flag = false;
          }
        }
        if (flag == false) {
          Map<String, dynamic> data = {
            "phonenumber": get_values[i][0],
            "Profit": get_values[i][1],
          };
          await FirebaseFirestore.instance.collection("Profit").add(data);
        }
      }
      else {
        Map<String, dynamic> data = {
          "phonenumber": get_values[i][0],
          "Profit": get_values[i][1],
        };
        await FirebaseFirestore.instance.collection("Profit").add(data);
      }
    }
  }

  negative_value(QuerySnapshot<Map<String, dynamic>> values,
      QuerySnapshot<Map<String, dynamic>> profit) async {
    List negative = get_minus(values);
    for(int i=0;i<negative.length;i++){
      List portfolio = negative[i][2];
      List data = [];
      for(int j=0;j<portfolio.length;j++){
        var profit = get_today_profit(portfolio[j]);
        var minus = (portfolio[j])-profit.abs();
        data.add(minus);
      }
      List listofvalues=[];
      for(int k=0;k<data.length;k++){
        String profit = data[k].toStringAsFixed(2);
        listofvalues.add(profit);
      }
      Map<String,dynamic>updatedata={
        "Portfolio":listofvalues,
      };
      await FirebaseFirestore.instance.collection("razor_investments").doc(negative[i][0]).update(updatedata);
    }
  }

  get_minus(QuerySnapshot<Map<String, dynamic>> values) {
    var id;
    List get_values = [];
    for (int i = 0; i < values.docs.length; i++) {
      id = values.docs[i].id;
      List portfolio = values.docs[i].get("Portfolio");
      String phonenumber = values.docs[i].get("phonenumber");
      get_values.add([phonenumber, portfolio]);
    }
    List loss = [];
    for (int i = 0; i < get_values.length; i++) {
      for (int j = 0; j < values.docs.length; j++) {
        if (values.docs[j].get("phonenumber") == get_values[i][0]) {
          loss.add([values.docs[i].id, get_values[i][0], get_values[i][1]]);
        }
      }
    }
    return loss;
  }

  get_today_profit(portfolio) {
    var amount =
        (portfolio * double.parse(percentageController.text)) / 100;
    return amount;
  }
}

