import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List search = ["All","Credit","Debit"];
  String?selectedValue;
  String? dates;

  var start;

  var end;
  DateTimeRange? dateTimeRange;
  var diff;
  var investments = FirebaseFirestore.instance.collection("Investments").snapshots();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12.3),
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Container(
                width: 150,
                decoration: BoxDecoration(border: Border.all(color: Colors.brown),borderRadius: BorderRadius.circular(12.6),),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(),
                      margin: EdgeInsets.only(left: 12.3),
                      alignment: Alignment.topLeft,
                      child: Text("Available Funds",style: TextStyle(color: Colors.orange,fontSize: 15)),
                    ),
                    SizedBox(height: 10,),
                    StreamBuilder<QuerySnapshot>(
                      stream: investments,
                      builder: (context, snap) {
                        double total = 0.0;
                        if (snap.hasData&&snap.requireData.docs.length>0) {
                          var investments = snap.data;
                           total = get_total(investments,total);
                          return Container(
                            child: Text(total.toString(),style: TextStyle(color: Colors.blue),),
                          );
                        }
                        return Container();
                      },
                    ),
                    SizedBox(height: 10,),

                  ],
                ),
              ),
              SizedBox(height: 40,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Container(
                     margin: EdgeInsets.only(right: 12.3),
                     child: Text("Transaction :")),
          DropdownButtonHideUnderline(
            child: DropdownButton2(

              isExpanded: true,
              hint: Row(
                children: const [
                  Icon(
                    Icons.list,
                    size: 16,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      'Select Transaction',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              items: search
                  .map((item) => DropdownMenuItem<String>(
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
              buttonPadding: const EdgeInsets.only(left: 14, right: 14,bottom: 1.3),
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
                color: Colors.pinkAccent,
              ),
              dropdownElevation: 5,
              scrollbarRadius: const Radius.circular(40),
              scrollbarThickness: 6,
              scrollbarAlwaysShow: true,
            ),
          ),

               ],
             ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 12.3),
                      child: Text("Selected Date :")),
                  Container(
                    height: 45.0,
                    width: 140,
                     decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(11.3)),
                    child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Select Date"),
                            Container(
                              alignment: Alignment.center,
                              child: InkWell(
                                  onTap: ()async{
                                dateTimeRange = await showDateRangePicker(
                                  context: context,
                                  firstDate:
                                  DateTime.now().add(Duration(days: 1)),
                                  lastDate:
                                  DateTime.now().add(Duration(days: 360)),
                                );
                                setState(() {
                                  dates = DateFormat('EEE  d MMM')
                                      .format(dateTimeRange!.start);
                                  start = dateTimeRange!.start;
                                  end = dateTimeRange!.end;
                                  diff = end.difference(start).inDays;

                                });
                              }, child: Icon(Icons.date_range,color: Colors.blue,)),
                            )
                          ],
                        )),
                  ),

                ],
              ),
              SizedBox(height: 10,),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    elevation: 0.6,
                    minimumSize: Size(120,30),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.3)),

                  ),
                  onPressed: (){

                  },
                  child: Text("Submit",style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  get_total(QuerySnapshot<Object?>? investments, double total) {
    var amount;
    for(int i =0;i<investments!.docs.length;i++){
      total = total + double.parse(investments.docs[i].get("InvestAmount"));
    }
    return total;
  }




}
