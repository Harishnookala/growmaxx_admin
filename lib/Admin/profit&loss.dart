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
  var pressed =false;
  bool inprogress = false;
  TextEditingController percentageController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(12.3),
      child: Column(
        children:  [
          SizedBox(height: 10,),
          Text("Today Profits",style: TextStyle(color: Colors.pinkAccent),),
          Divider(thickness: 0.6,color: Colors.black,),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                Text("Today Status :"),
                Container(
                  margin: EdgeInsets.only(left: 18.3),
                  child: build_percentage(),
                ),

              ],
            ),
          ),
          SizedBox(
            child: Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(130, 3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.3)),
                    backgroundColor: Colors.green.shade400),
                onPressed: ()async{
                   if(percentageController.text!=null){
                     setState(() {
                       inprogress =true;
                     });
                     var dates = DateFormat('yyy-dd-MMM').format(DateTime.now());
                     Map<String,dynamic>data ={
                       "CreatedAt":DateTime.now(),
                       "Todayprofit":percentageController.text.toString()
                     };
                     await FirebaseFirestore.instance.collection("Admin").doc(dates).set(data);

                     var investments = await get_data();

                     setState(() {
                       pressed =true;
                       count=0;
                       pressed =false;
                     });

                   }
                },
                child: Container(
                  width:MediaQuery.of(context).size.width/2.87,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10,),
                      Center(
                        child: Text("Submit",textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,fontSize: 16),),
                      ),
                      inprogress?CircularProgressIndicator():Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          pressed?Center(child: Text("----Loading-----"),):Container(),
        ],
      ),
    );
  }


  get_data() async{
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    var amount;
    var collection = await FirebaseFirestore.instance.collection("Investments").get();
    for(int i=0;i<collection.docs.length;i++){
      var investAmount = collection.docs[i].get("InvestAmount");
      var percentageAmount = (double.parse(investAmount)*double.parse(percentageController.text))/100;
      String fixestwo = percentageAmount.toStringAsFixed(2);
      double profit = double.parse(fixestwo);
      if(double.parse(percentageController.text).isNegative){
         amount = double.parse(investAmount) - profit.abs();
       }
        else{
           amount = double.parse(investAmount) + profit;
        }
        print(amount);
        print(percentageAmount);
        String afterprofit = amount.toStringAsFixed(2);
        String beforeprofit =  double.parse(investAmount).toStringAsFixed(2);
       Map<String,dynamic>data = {
          "InvestAmount":afterprofit.toString(),
       };
      var dates = DateFormat('yyy-dd-MMM').format(DateTime.now());
      Map<String,dynamic>gains ={
        "CreatedAt":DateTime.now(),
        "CurrentGains":profit.toString()
      };

     await FirebaseFirestore.instance.collection("Current_gains").doc(collection.docs[i].id.toString()).set(gains);
       FirebaseFirestore.instance.collection("Investments").doc(collection.docs[i].id.toString()).update(data);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => adminPannel(selectedPage: 0)));
    }
  }

  build_percentage() {
    return SizedBox(
      width: MediaQuery.of(context).size.width/2.0,
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
        controller:percentageController,
        cursorColor: Colors.orange,
        style: const TextStyle(
           letterSpacing: 0.5,
            color: Colors.deepPurpleAccent,fontSize: 16,fontFamily: "poppins-Medium"),
      ),
    );
  }
}
