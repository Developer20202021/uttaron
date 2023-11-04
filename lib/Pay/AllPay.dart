import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:uttaron/AllStudent/AllSemister.dart';
import 'package:uttaron/DeveloperAccess/DeveloperAccess.dart';
import 'package:uttaron/Pay/CourseFee.dart';
import 'package:uttaron/Pay/ExamFeePay.dart';
import 'package:uttaron/Registration/AdminReg.dart';
import 'package:uttaron/Registration/StudentReg.dart';





class AllPay extends StatefulWidget {

  final StudentEmail;
  final StudentPhoneNumber;
  final StudentName;
  final StudentDueAmount;
  final FatherPhoneNo;
  final StudentIDNo;



  const AllPay({super.key, required this.StudentDueAmount, required this.StudentEmail, required this.StudentName, required this.StudentPhoneNumber, required this.FatherPhoneNo, required this.StudentIDNo});

  @override
  State<AllPay> createState() => _AllPayState();
}

class _AllPayState extends State<AllPay> {

  bool loading = false;














  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
       
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("All Pay",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
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



      







  SizedBox(height: 30,),




                       Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  
                  height: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Text("Exam Fee", style: TextStyle(
                    // ${moneyAdd.toString()}
                            fontSize: 20,
                            color:Colors.white,
                            overflow: TextOverflow.clip
                           
                          ),),
                    

                             SizedBox(
                                    height: 17,
                                   ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                              
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                
                                
                                children: [
                                              
                                              
                                            Container(width: 170, child:TextButton(onPressed: (){
                
                
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ExamFeePay(StudentDueAmount: widget.StudentDueAmount, StudentEmail: widget.StudentEmail, StudentName: widget.StudentName, StudentPhoneNumber: widget.StudentPhoneNumber, FatherPhoneNo: widget.FatherPhoneNo,)));
                
                
                
                
                
                
                
                                            }, child: Text("Exam Fee", style: TextStyle(color: ColorName().appColor),), style: ButtonStyle(
                                 
                                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                          ),),),

                                ],),
                            )
                    

                        ],
                      ),
                    ),
                
                
                  ),
                       
                 decoration: BoxDecoration(

                     boxShadow: [
                      BoxShadow(
                        color: Colors.white70,
                        blurRadius: 20.0,
                      ),
                    ],
                  color: ColorName().appColor,
                
                  border: Border.all(
                            width: 2,
                            color: ColorName().appColor
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)),







            


            
  SizedBox(height: 30,),




              int.parse(widget.StudentDueAmount)>0? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  
                  height: 200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Text("Course Fee", style: TextStyle(
                    // ${moneyAdd.toString()}
                            fontSize: 20,
                            color:Colors.white,
                            overflow: TextOverflow.clip
                           
                          ),),
                    

                             SizedBox(
                                    height: 17,
                                   ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                              
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                
                                
                                children: [
                                              
                                              
                                            Container(width: 170, child:TextButton(onPressed: (){
                
                
                
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>CourseFee(StudentDueAmount: widget.StudentDueAmount, StudentEmail: widget.StudentEmail, StudentName: widget.StudentName, StudentPhoneNumber: widget.StudentPhoneNumber, FatherPhoneNo: widget.FatherPhoneNo, StudentIDNo: widget.StudentIDNo,)));
                
                
                
                
                
                
                
                                            }, child: Text("Course Fee", style: TextStyle(color: const Color.fromARGB(255,12, 53, 106)),), style: ButtonStyle(
                                 
                                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                          ),),),

                                ],),
                            )
                    

                        ],
                      ),
                    ),
                
                
                  ),
                       
                 decoration: BoxDecoration(

                     boxShadow: [
                      BoxShadow(
                        color: Colors.white70,
                        blurRadius: 20.0,
                      ),
                    ],
                  color: Color.fromARGB(255,12, 53, 106),
                
                  border: Border.all(
                            width: 2,
                            color:Color.fromARGB(255,12, 53, 106)
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),)):Text(""),
      

      

      SizedBox(height: 30,),




                      





      
      
          ],
      
      
      
      
      
      
        ),
      )));

  }
}