import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class investedAmount extends StatefulWidget {
  const investedAmount({Key? key}) : super(key: key);

  @override
  State<investedAmount> createState() => _investedAmountState();
}

class _investedAmountState extends State<investedAmount> {

  var invest = FirebaseFirestore.instance.collection("Investments").get();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.all(12.3),
          child: ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 20.3),
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.blue,),
                ),
              ),
              SizedBox(height: 8,),
              Divider(height: 1, thickness: 1.5, color: Colors.green.shade400),
              Container(
                  margin: EdgeInsets.all(3.3),
                  child: Container(
                      margin: const EdgeInsets.only(
                        left: 6.3, ),
                      child: const Text(
                        "Invested Amount",
                        style: TextStyle(
                            letterSpacing: 0.6,
                            color: Colors.indigoAccent,
                            fontFamily: "Poppins-Light",
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ))),
              Divider(height: 1, thickness: 1.5, color: Colors.green.shade400),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Username",style: TextStyle(color: Colors.deepOrange,fontFamily: "Poppins"),),
                  Text("Phonenumber",style: TextStyle(color: Colors.deepOrange,fontFamily: "Poppins")),
                  Text("InvestedAmount",style: TextStyle(color: Colors.deepOrange,fontFamily: "Poppins"))
                ],
              ),
                  Divider(color: Colors.grey,thickness: 1.6),
                  FutureBuilder<QuerySnapshot>(
                    future: invest,
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        var investedamount = snapshot.data;
                          return ListView.builder(
                           shrinkWrap: true,
                           padding: EdgeInsets.only(top: 12.9),
                           physics: BouncingScrollPhysics(),
                           itemCount: investedamount!.docs.length,
                           itemBuilder: (context,index){
                             var amount = investedamount.docs[index];
                             return Container(
                               margin: EdgeInsets.only(bottom: 15.3),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text(amount.get("username")),
                                   Text(amount.get("phonenumber")),
                                   Text("₹ "+amount.get("InvestAmount"))
                                 ],
                               ),
                             );
                           },
                         );

                      }return Container();
                    },
                  )

            ],
          ),
        ),
      ),
    );
  }
}
