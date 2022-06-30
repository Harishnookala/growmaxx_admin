import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:growmaxx_admin/Admin/user_details.dart';
import 'package:growmaxx_admin/Forms/personal_details.dart';
class build_drawer extends StatefulWidget {
   build_drawer({Key? key}) : super(key: key);

  @override
  State<build_drawer> createState() => _build_draweState();
}

class _build_draweState extends State<build_drawer> {
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print("BACK BUTTON!"); // Do some stuff.
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30,),
        Container(
          margin: EdgeInsets.all(12.3),
          child: Text("Hi , Admin",style: TextStyle(color: Colors.green,fontFamily: "Poppins-Medium"),),
        ),
        Container(
          child: TextButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  user_details()),
              );
            },
            child: Text("Users"),
          ),
        ),
        Container(
          child: TextButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  personal_details()),
              );
            },
            child: Text(" +  Create Account"),
          ),
        )
      ],
    );
  }
}
