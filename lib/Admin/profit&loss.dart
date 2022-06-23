import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class profit extends StatefulWidget {
  const profit({Key? key}) : super(key: key);

  @override
  _profitState createState() => _profitState();
}

class _profitState extends State<profit> {
  int count = 0;
  var plus_button = false;
  var minu_button = false;
  var pressed =false;
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(12.3),
      child: Column(
        children:  [
          Text("Today Profits",style: TextStyle(color: Colors.pinkAccent),),
          Divider(thickness: 0.6,color: Colors.black,),
          Container(
            child: Row(
              children: [
                SizedBox(height: 60,),
                Text("Today Status :"),
                Container(
                  margin: EdgeInsets.only(left: 20.3),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 35,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xfff4deac),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Color(0xfff4deac)),
                                    borderRadius:
                                    BorderRadius.circular(25.0),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    plus_button = true;
                                    if(plus_button){
                                      get_increment();
                                    }
                                  });
                                },
                                child: Text(" + ", style: TextStyle(
                                    color: Colors.black),
                                )),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  left: 5.3,
                                  right: 5.3),
                              child: Text(
                                count.toString(),
                                style: TextStyle(fontSize: 16),
                              )),
                          SizedBox(
                            height: 35,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                  Color(0xfff4deac),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Color(0xfff4deac)),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    get_decrement();
                                  });
                                },
                                child: Container(
                                    alignment: Alignment.topLeft,
                                    child: const Text("-", style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16),
                                    ))),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
          SizedBox(
            child: Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(120, 30),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.3)),
                    backgroundColor: Colors.green.shade400),
                onPressed: ()async{
                  var dates = DateFormat('yyy-dd-MMM').format(DateTime.now());
                  Map<String,dynamic>data ={
                    "CreatedAt":DateTime.now(),
                    "Todayprofit":count.toString()
                  };
                  await FirebaseFirestore.instance.collection("Admin").doc(dates).set(data);

                  var investments = await get_data();

                  setState(() {
                    pressed =true;
                    count=0;
                    pressed =false;
                   });

                },
                child: Text("Submit",
                style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
          pressed?Center(child: Text("----Loading-----"),):Container(),
        ],
      ),
    );
  }

   get_increment() {
      if(plus_button){
        count++;
      }
  }

   get_decrement() {
    count--;
   }

  get_data() async{
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    var amount;
    var collection = await FirebaseFirestore.instance.collection("Investments").get();
    for(int i=0;i<collection.docs.length;i++){
      var investAmount = collection.docs[i].get("InvestAmount");
      var percentageAmount = (double.parse(investAmount)*count)/100;
      String fixestwo = percentageAmount.toStringAsFixed(2);
      double profit = double.parse(fixestwo);
      if(count.isNegative){
         amount = double.parse(investAmount) - profit.abs();
       }
        else{
           amount = double.parse(investAmount) + profit;
        }
      print(amount);
      print(investAmount);
      print(profit);
       Map<String,dynamic>data = {
          "InvestAmount":amount.toString(),
          "beforepercentage":investAmount.toString(),
        };
        Map<String,dynamic> gains = {
          "CurrentGains":profit.toString()
        };

      await FirebaseFirestore.instance.collection("Investments").doc(collection.docs[i].id.toString()).update(data);
      await FirebaseFirestore.instance.collection("currentgains").doc(collection.docs[i].id.toString()).update(gains);
    }
  }
}
