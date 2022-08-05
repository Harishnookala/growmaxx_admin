import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'adminPannel.dart';

class detailInvestments extends StatefulWidget {
  String?id;
   detailInvestments({Key? key, this.id}) : super(key: key);

  @override
  detailInvestmentsState createState() => detailInvestmentsState();
}

class detailInvestmentsState extends State<detailInvestments> {
  bool? accepted =false;

  bool ?rejected =false;
  var formatter = NumberFormat('#,##0.${"#" * 5}');

  @override
  Widget build(BuildContext context) {
    var details = FirebaseFirestore.instance.collection("requestInvestments").doc(widget.id.toString()).get();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Container(
          margin: const EdgeInsets.all(12.3),
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 30,
              ),
          Card(
            elevation: 1.5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.3)),
           child: FutureBuilder<DocumentSnapshot>(
                future: details,
              builder: (context,snapshot){
                if(snapshot.hasData){
                  var investment = snapshot.data;
                  return Container(
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("Username"),
                            Text(investment!.get("username"))
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("InvestAmount"),
                            Text(formatter.format(double.parse(investment.get("InvestAmount"))))
                          ],
                        ),
                        const SizedBox(height: 20,),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(
                                child: Text("Screenshot Image"),
                             width: 220,
                            ),
                            const SizedBox(height: 20,),
                            Center(
                              child: Image.network(
                                investment.get("image"),
                                width: 220,
                                loadingBuilder: (BuildContext context, Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20,),                          ],
                        ),
                       Container(
                         child: build_buttons(investment),
                       ),
                       const SizedBox(height: 50,)
                      ],
                    ),
                  );
                }return const Center(child: CircularProgressIndicator());
              }
           ),
          ),
            ],
          ),
        ),
      ),
    );
  }
  get_invests( String?username) async {
    var collectionRef = await FirebaseFirestore.instance
        .collection('Investments')
        .doc(username)
        .get();
    if (collectionRef.exists) {
      if (collectionRef.get("username") == username) {
        return collectionRef.get("InvestAmount");
      }
    }
    return null;
  }

  get_data(investid, phonenumber,String?username) async {
    var Investamount = await FirebaseFirestore.instance
        .collection("Investments")
        .doc(username)
        .get();
    if (username == Investamount.get("username")) {
      var amount = Investamount.get("InvestAmount");
      return amount;
    }
  }

  build_buttons(DocumentSnapshot<Object?> investment) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 12.3),
          child: TextButton(style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.5)),
            minimumSize: Size(120, 40)
          ),
              onPressed: () async {
                setState(() {
                  accepted = true;
                });
                if (accepted == true) {
                  Map<String, dynamic> data = {"status": "Accept"};
                  var id = widget.id;
                  await FirebaseFirestore.instance.
                  collection("requestInvestments").doc(id).update(data);
                  var amount = investment.get("InvestAmount");
                  var investid = await get_invests(investment.get("username"));
                  if (investid == null) {
                    Map<String, dynamic> investments = {
                      "InvestAmount": amount.toString(),
                      "phonenumber": investment.get("phonenumber"),
                      "username": investment.get("username"),
                      "CreatedAt" : DateTime.now(),
                    };
                    await FirebaseFirestore.instance
                        .collection("Investments").doc(investment.get("username"))
                        .set(investments);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => adminPannel(
                          selectedPage: 1,
                        )));
                  }

                  else {
                    var InvestAmount = await get_data(
                        investid, investment.get("phonenumber"),investment.get("username"));
                    var savingAmount =
                        double.parse(InvestAmount) + double.parse(amount);
                    var investAmount = savingAmount.toString();
                    Map<String, dynamic> investedAmount = {
                      "InvestAmount": investAmount.toString(),
                      "CreatedAt" : DateTime.now(),
                    };
                    await FirebaseFirestore.instance
                        .collection("Investments")
                        .doc(investment.get('username'))
                        .update(investedAmount);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => adminPannel(
                          selectedPage: 1,
                        )));
                  }
                }
              },
              child:  accepted==true
                  ? const Text("Accepted",style: TextStyle(color: Colors.white,fontFamily: "Poppins-Medium",fontWeight: FontWeight.w900),) :
              const Text("Accept",style: TextStyle(color: Colors.white,fontFamily: "Poppins-Medium",fontWeight: FontWeight.w900),)),
        ),
        TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.5)),
                minimumSize: Size(120, 40)
            ),
            onPressed: () async {
              setState(() {

                rejected = true;
              });
              Map<String, dynamic> statusupdate = {"status": "Reject"};
              var id = widget.id;
              await FirebaseFirestore.instance
                  .collection("requestInvestments")
                  .doc(id)
                  .update(statusupdate);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => adminPannel(
                    selectedPage: 1,
                  )));
            },
            child: rejected == true
                ? const Text("Rejected",style: TextStyle(color: Colors.white,fontFamily: "Poppins-Medium",fontWeight: FontWeight.w900),)
                : const Text("Reject",style: TextStyle(color: Colors.white,fontFamily: "Poppins-Medium",fontWeight: FontWeight.w900),)),
      ],
    );
  }
}
