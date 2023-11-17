
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uttaron/DeveloperAccess/DeveloperAccess.dart';
import 'package:uttaron/LogIn/AdminLogIn.dart';

class NewEmailNotVerified extends StatefulWidget {

  final AdminEmail;



  const NewEmailNotVerified({super.key, required this.AdminEmail});

  @override
  State<NewEmailNotVerified> createState() => _NewEmailNotVerifiedState();
}

class _NewEmailNotVerifiedState extends State<NewEmailNotVerified> {


  bool resend = false;

  bool loading = false;

  String errorTxt = "";




late Timer _timer;
int _start = 59;

void startTimer() {
  const oneSec = const Duration(seconds: 1);
  _timer = new Timer.periodic(
    oneSec,
    (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    },
  );
}


@override
void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }




@override
void dispose() {
  _timer.cancel();
  super.dispose();
}













  


  Future ResendEmailVerification() async{


                FirebaseAuth.instance
                            .authStateChanges()
                            .listen((User? user) async{
                              if (user == null) {
                                
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AdminLogInScreen()),
                      );


                      setState(() {
                                 loading = false;
                                 resend = false;
                               });
                     





                              } else {


                                print('User is signed in!');

                              try {

                                await user.sendEmailVerification().then((value) => setState((){

                                setState(() {
                                 loading = false;
                                 resend = true;
                               });

                                  print("Done");
                               
                                })).onError((error, stackTrace) => setState((){


                                setState(() {
                                 loading = false;
                                 resend = true;
                               });



                                  setState(() {
                                    
                                    errorTxt = error.toString();
                                  });

                                  print("________________________$error");
                                }));
                                
                              } catch (e) {
                                print(e);
                                
                              }

                               setState(() {
                                 loading = false;
                                 resend = true;
                               });
                                          
                 
                              }
                            });







  }















  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorName().appColor),
        automaticallyImplyLeading: false,
        title: const Text("Verify Email",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: Center(child: Column(
        children: [


          
             errorTxt.isNotEmpty?  Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
             
                         color: Colors.red.shade400,
                         
                         
                         child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${errorTxt}", style: TextStyle(color: Colors.white),),
                         )),
             ):Text(""),




            
          SizedBox(height: 15,),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("আপনার ${widget.AdminEmail} Email এ একটি mail পাঠানো হয়েছে। আপনার ${widget.AdminEmail} Email টি Verify করুন।"),
          ),



             resend?Align( 
              alignment: Alignment.topRight,
              child: Container(
                color: Colors.green.shade300,
                child: Icon(Icons.check, color: Colors.white,))):_start==0?Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(width: 80, child:TextButton(onPressed: () async{
                     
                     
                        setState(() {
                          loading = true;
                        });
                     
                     
                       ResendEmailVerification();
                     
                  
                     
                     
                   
                     
                     
                     
                     
                     
                      }, child: Text("Resend", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                       
                         backgroundColor: MaterialStatePropertyAll<Color>(Colors.pink.shade400),
                       ),),),
                     
                     
                     
                     
                     
                     
                     
                     
                    ],
                  ),
             ):Align( 
              
              alignment: Alignment.topRight,
              child: Container(
                width: 70,
                color: Colors.green.shade300,
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${_start}s", style: TextStyle(color: Colors.white, fontSize: 16),),
              ))),


        ],
      )));

  }
}