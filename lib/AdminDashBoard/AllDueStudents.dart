import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path/path.dart';
import 'package:uttaron/AdminDashBoard/SendSmSToDueStudent.dart';
import 'package:uttaron/AllStudent/ShowAttendance.dart';
import 'package:uttaron/AllStudent/StudentProfile.dart';
import 'package:uttaron/DeveloperAccess/DeveloperAccess.dart';
import 'package:uttaron/Pay/AllPay.dart';



class AllDueStudents extends StatefulWidget {

  final indexNumber ;






  const AllDueStudents({super.key, required this.indexNumber});

  @override
  State<AllDueStudents> createState() => _AllDueStudentsState();
}

class _AllDueStudentsState extends State<AllDueStudents> {




bool loading = false;

var DataLoad = "";

 



// Firebase All Customer Data Load

List  AllData = [];













Future<void> getData() async {
    // Get docs from collection reference
      CollectionReference _CustomerOrderHistoryCollectionRef =
    FirebaseFirestore.instance.collection('StudentInfo');

  // all Due Query Count
     Query _CustomerOrderHistoryCollectionRefDueQueryCount = _CustomerOrderHistoryCollectionRef.where("StudentType", isEqualTo: "Due").where("StudentStatus", isEqualTo: "new").where("AccountStatus", isEqualTo: "open");

     QuerySnapshot queryDueSnapshot = await _CustomerOrderHistoryCollectionRefDueQueryCount.get();

      AllData = queryDueSnapshot.docs.map((doc) => doc.data()).toList();





     if (AllData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;
      });
       
     } else {

      setState(() {
     
      AllData = queryDueSnapshot.docs.map((doc) => doc.data()).toList();
      loading = false;
     });
       
     }
     

    print(AllData);
}











// Firebase All Customer Data Load








@override
  void initState() {
    // TODO: implement initState
    setState(() {
      loading = true;
    });
   
    getData();
    super.initState();
  }



  
  Future refresh() async{





      
  getData();





  }









  @override
  Widget build(BuildContext context) {

 FocusNode myFocusNode = new FocusNode();


   




    return Scaffold(

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 9),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
      
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () async{


                  // FirebaseAuth.instance
                  // .authStateChanges()
                  // .listen((User? user) {
                  //   if (user == null) {
                  //     print('User is currently signed out!');
                  //   } else {
                  // // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(userName: user.displayName, userEmail: user.email, indexNumber: "1",)));
                  // //   }
                  // });

                  
                   



                },
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),



              IconButton(
                enableFeedback: false,
                onPressed: () {

                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(indexNumber: "2")));



                },
                icon: const Icon(
                  Icons.electric_bike_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),




              IconButton(
                enableFeedback: false,
                onPressed: () {


                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllAdmin(indexNumber: "3")));



                },
                icon: const Icon(
                  Icons.admin_panel_settings_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),


              widget.indexNumber == "4"?
              IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.person_sharp,
                  color: Colors.white,
                  size: 55,
                  fill: 1.0,
                ),
              ): IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ],
          ),),
      ),




      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(92, 107, 192, 1)),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("All Due Students",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body:loading?Center(child: CircularProgressIndicator()): DataLoad == "0"? Center(child: Text("No Data Available")): RefreshIndicator(
        onRefresh: refresh,
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Container(
                       
                 decoration: BoxDecoration(
                  color: ColorName().AppBoxBackgroundColor,
     

                  border: Border.all(
                            width: 2,
                            color: ColorName().AppBoxBackgroundColor
                          ),
                  borderRadius: BorderRadius.circular(10)      
                 ),
      
                    
                    child: Column(
                      children: [



                        InkWell(

                          onDoubleTap: () {

                               Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowAttendance(StudentEmail: AllData[index]["StudentEmail"])));
                            
                          },
                        

                         onTap: () {
                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => StudentProfile(StudentEmail: AllData[index]["StudentEmail"])));

                         },

                          child: ListTile(
                            
                                           
                              
                                    title: Text("ID No:- ${AllData[index]["IDNo"]}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                        
                                    trailing: 
                               TextButton(onPressed: (){
                        
                        
                        
                        
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => SendSmSToDueStudent(DueAmount: AllData[index]["DueAmount"], StudentName: AllData[index]["StudentName"], StudentPhoneNumber: AllData[index]["StudentPhoneNumber"])));
                        
                              
                              
                              
                              
                              
                                        }, child: Text("Send SMS", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                         
                                          backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                                        ),),
                                    
                              
                              
                                    subtitle: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                       
                                        Text("Name:${AllData[index]["StudentName"].toString().toUpperCase()}"),
                                        Text("Phone Number:${AllData[index]["StudentPhoneNumber"]}"),
                        
                                        Text("Student Email: ${AllData[index]["StudentEmail"]}"),
                        
                                        Text("Father Phone No: ${AllData[index]["FatherPhoneNo"]}"),
                                          
                                        Text("Admission Date: ${AllData[index]["AdmissionDate"]}"),
                        
                                        Text("Type: ${AllData[index]["StudentType"]}"),
                        
                                        
                        
                                        Text("Department: ${AllData[index]["Department"]}"),
                                        
                                        Text("Semister: ${AllData[index]["Semister"]}"),
                                       
                                       Text("Category: ${AllData[index]["Category"]}"),
                        
                        
                                        Text("Due: ${AllData[index]["DueAmount"]}৳"),
                        
                                      ],
                                    ),
                              
                              
                              
                                  ),
                        ),





                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(onPressed: (){
      
      
                                              
      
      
                                       
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllPay(StudentDueAmount: AllData[index]["DueAmount"], StudentEmail: AllData[index]["StudentEmail"], StudentName: AllData[index]["StudentName"], StudentPhoneNumber: AllData[index]["StudentPhoneNumber"], FatherPhoneNo: AllData[index]["FatherPhoneNo"], StudentIDNo: AllData[index]["IDNo"],)));
      
      
      
      
      
                                      }, child: Text("Pay", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                  backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                ),),


                SizedBox(height: 2,),




                             TextButton(onPressed: (){




                               Navigator.of(context).push(MaterialPageRoute(builder: (context) => StudentProfile(StudentEmail: AllData[index]["StudentEmail"])));

      
      
      
      
      
                                      }, child: Text("Profile", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                  backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                ),),


                SizedBox(height: 2,),












                            TextButton(onPressed: () async{





                        


      AwesomeDialog(
            context: context,
            dialogType: DialogType.question,
            animType: AnimType.rightSlide,
            title: 'Are You Sure?',
            desc: 'আপনি কি এই Student কে পুরাতন Student এর তালিকায় দিতে চান?যদি হ্যা হয় তবে Ok button press করুন। না হলে Cancel button press করুন।',
          
            btnOkOnPress: () async{




               var updateData ={

                                "StudentStatus":"old"

                              };


   final StudentInfo =
    FirebaseFirestore.instance.collection('StudentInfo').doc(AllData[index]["StudentEmail"]);

                              
                          StudentInfo.update(updateData).then((value) => setState((){




                              final snackBar = SnackBar(
                 
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Successfull',
                      message:
                          'Hey Thank You. Good Job',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);

              


              
          



                         setState(() {
                            loading = false;
                          });





                          })).onError((error, stackTrace) => setState((){




                              final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Something Wrong!!!!',
                      message:
                          'Try again later...',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.failure,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);






                   setState(() {
                            loading = false;
                          });


                          }));
      
      
      
      
      


          
            },

            btnCancelOnPress: () {


          
            },
          ).show();




                             
      
                                      }, child: Text("old", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                  backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                ),),


                SizedBox(height: 2,),



                             AllData[index]["AdminApprove"]=="false"?            TextButton(onPressed: ()async{









                              
      AwesomeDialog(
            context: context,
            dialogType: DialogType.question,
            animType: AnimType.rightSlide,
            title: 'Are You Sure?',
            desc: 'আপনি কি এই Student কে Approve করতে চান?যদি হ্যা হয় তবে Ok button press করুন। না হলে Cancel button press করুন।',
          
            btnOkOnPress: () async{




               var updateData ={

                                "AdminApprove":"true"

                              };


   final StudentInfo =
    FirebaseFirestore.instance.collection('StudentInfo').doc(AllData[index]["StudentEmail"]);

                              
                          StudentInfo.update(updateData).then((value) => setState((){




                              final snackBar = SnackBar(
                 
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Successfull',
                      message:
                          'Hey Thank You. Good Job',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);

              


              
          



                         setState(() {
                          getData();
                            loading = false;
                          });





                          })).onError((error, stackTrace) => setState((){




                              final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Something Wrong!!!!',
                      message:
                          'Try again later...',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.failure,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);






                   setState(() {
                            loading = false;
                          });


                          }));
      
      
      
      
      


          
            },

            btnCancelOnPress: () {


          
            },
          ).show();










      
     
      
      
                                      }, child: Text("Enable", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.green.shade400),
                ),):TextButton(onPressed: ()async{






                   AwesomeDialog(
            context: context,
            dialogType: DialogType.question,
            animType: AnimType.rightSlide,
            title: 'Are You Sure?',
            desc: 'আপনি কি এই Student কে  Disable করতে চান?যদি হ্যা হয় তবে Ok button press করুন। না হলে Cancel button press করুন।',
          
            btnOkOnPress: () async{




               var updateData ={

                                "AdminApprove":"false"

                              };


   final StudentInfo =
    FirebaseFirestore.instance.collection('StudentInfo').doc(AllData[index]["StudentEmail"]);

                              
                          StudentInfo.update(updateData).then((value) => setState((){




                              final snackBar = SnackBar(
                 
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Successfull',
                      message:
                          'Hey Thank You. Good Job',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);

              


              
          



                         setState(() {
                          getData();
                            loading = false;
                          });





                          })).onError((error, stackTrace) => setState((){




                              final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Something Wrong!!!!',
                      message:
                          'Try again later...',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.failure,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);






                   setState(() {
                            loading = false;
                          });


                          }));
      
      
      
      
      


          
            },

            btnCancelOnPress: () {


          
            },
          ).show();










      



















      
     
      
      
                                      }, child: Text("Disable", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red.shade400),
                ),),


                SizedBox(height: 2,),





                                           

                                    ],
                                  ),



                          

                          SizedBox(height: 9,),




                //           Row(

                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //                 TextButton(onPressed: (){
      
      
                                              
      
      
                                       
                //   // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentAdd(SalePrice: AllData[index]["TotalFoodPrice"], CustomerPhoneNumber: AllData[index]["CustomerPhoneNumber"], OrderID: AllData[index]["OrderID"], CustomerID: getCustomerID[0]["CustomerID"])));
      
      
      
      
      
                //                       }, child: Text("Attandance", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                //   backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                // ),),


                // SizedBox(height: 2,),





                //                              TextButton(onPressed: (){
      
      
                                              
      
      
                                       
                //   // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentAdd(SalePrice: AllData[index]["TotalFoodPrice"], CustomerPhoneNumber: AllData[index]["CustomerPhoneNumber"], OrderID: AllData[index]["OrderID"], CustomerID: getCustomerID[0]["CustomerID"])));
      
      
      
      
      
                //                       }, child: Text("Old", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                //   backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                // ),),


                // SizedBox(height: 2,),





                
                //                  AllData[index]["AdminApprove"]=="false"?            TextButton(onPressed: (){
      
     
      
      
                //                       }, child: Text("Enable", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                //   backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                // ),):TextButton(onPressed: (){
      
     
      
      
                //                       }, child: Text("Disable", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                                       
                //   backgroundColor: MaterialStatePropertyAll<Color>(ColorName().appColor),
                // ),),


                // SizedBox(height: 2,),






                //             ],
                //           )












                      ],
                    ),
                  ),
                );
          },
          itemCount: AllData.length,
        ),
      ),
    );
  }
}







