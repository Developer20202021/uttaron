import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';





class SMSInfo extends StatefulWidget {
  const SMSInfo({super.key});

  @override
  State<SMSInfo> createState() => _SMSInfoState();
}

class _SMSInfoState extends State<SMSInfo> {


  var smsBalance = [];
  var smsexpireDate = "";
  bool loading = true;




 Future getSmsInfo() async{


      final response = await http
                                .get(Uri.parse('https://api.greenweb.com.bd/g_api.php?token=100651104321696050272e74e099c1bc81798bc3aa4ed57a8d030&balance&json'));


          print(response.body);
          setState(() {
            smsBalance = jsonDecode(response.body);

          });



    
      final responseDate = await http
                                .get(Uri.parse('https://api.greenweb.com.bd/g_api.php?token=100651104321696050272e74e099c1bc81798bc3aa4ed57a8d030&expiry'));


              setState(() {
                smsexpireDate = responseDate.body;
                loading = false;
              });

                print(responseDate.body);



  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSmsInfo();
  }










  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
       
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("SMS Info",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: loading?Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: const Color(0xFF1A1A3F),
                        secondRingColor:  Theme.of(context).primaryColor,
                        thirdRingColor: Colors.white,
                        size: 100,
                      ),
                    ),
              ):SingleChildScrollView(child: Center(
        child: Column(
      
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
      
      
          children: [
      
      
            Text("Balance: ${smsBalance[0]["response"]}৳", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,),),

            Text("Expire Date: ${smsexpireDate}", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,),),
      
      
      
      
      
          ],
      
      
      
      
      
      
        ),
      )));

  }
}