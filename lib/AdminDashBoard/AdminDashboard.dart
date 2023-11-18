
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:popover/popover.dart';
import 'package:uttaron/AdminDashBoard/AllDueStudents.dart';
import 'package:uttaron/AdminDashBoard/AllStudentSetDue.dart';
import 'package:uttaron/AdminDashBoard/MonthlyCourseFeeCollection.dart';
import 'package:uttaron/AdminDashBoard/MonthlyExamFeeCollection.dart';
import 'package:uttaron/AdminDashBoard/SendSMSToAllStudents.dart';
import 'package:uttaron/Admins/AdminProfile.dart';
import 'package:uttaron/Admins/AllAdmins.dart';
import 'package:uttaron/AllStudent/AllDepartment.dart';
import 'package:uttaron/DeveloperAccess/DeveloperAccess.dart';
import 'package:uttaron/DeveloperAccess/DeveloperInfo.dart';
import 'package:uttaron/GiveAttendance/AllDepartment.dart';
import 'package:uttaron/LogIn/AdminLogIn.dart';
import 'package:uttaron/Notice/AllNotice.dart';
import 'package:uttaron/Notice/NoticeUpload.dart';
import 'package:uttaron/SMSInfo/smsinfo.dart';
import 'package:uttaron/Settings/ChangePassword.dart';
import 'package:uttaron/Teachers/AllTeachers.dart';
import 'package:uttaron/Teachers/GiveAttendanceTeacher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';




class AdminDashboard extends StatefulWidget {


  final indexNumber;

  



  const AdminDashboard({super.key, required this.indexNumber, });

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {


  

// hive database

  final _mybox = Hive.box("uttaronBox");









   // Firebase All Customer Data Load

List  AllStudent = [];




Future<void> getAllStudent() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

  CollectionReference _collectionDueCustomerRef =
    FirebaseFirestore.instance.collection('StudentInfo');
    Query DueCustomerquery = _collectionDueCustomerRef.where("StudentStatus", isEqualTo: "new");
    QuerySnapshot DueCustomerquerySnapshot = await DueCustomerquery.get();

    // Get data from docs and convert map to List
     AllStudent = DueCustomerquerySnapshot.docs.map((doc) => doc.data()).toList();

     setState(() {
       AllStudent = DueCustomerquerySnapshot.docs.map((doc) => doc.data()).toList();
     });

    // print(AllData);
}





 // Firebase All Customer Data Load

List  AllPaidStudentData = [];




Future<void> getPaidStudentData() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

  CollectionReference _collectionPaidCustomerRef =
    FirebaseFirestore.instance.collection('StudentInfo');
    Query PaidCustomerquery = _collectionPaidCustomerRef.where("StudentType", isEqualTo: "Paid").where("AccountStatus", isEqualTo: "open");
    QuerySnapshot PaidCustomerquerySnapshot = await PaidCustomerquery.get();

    // Get data from docs and convert map to List
     AllPaidStudentData = PaidCustomerquerySnapshot.docs.map((doc) => doc.data()).toList();

     setState(() {
       AllPaidStudentData = PaidCustomerquerySnapshot.docs.map((doc) => doc.data()).toList();
     });

    // print(AllData);
}








List  AllDueStudentData = [];




Future<void> getAllDueStudent() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

  CollectionReference _collectionPaidCustomerRef =
    FirebaseFirestore.instance.collection('StudentInfo');
    Query PaidCustomerquery = _collectionPaidCustomerRef.where("StudentType", isEqualTo: "Due");
    QuerySnapshot PaidCustomerquerySnapshot = await PaidCustomerquery.get();

    // Get data from docs and convert map to List
     AllDueStudentData = PaidCustomerquerySnapshot.docs.map((doc) => doc.data()).toList();

     setState(() {
       AllDueStudentData = PaidCustomerquerySnapshot.docs.map((doc) => doc.data()).toList();
     });

    // print(AllData);
}





















var photoUrl ="";
var AdminName ="";
var AdminEmail = "";











@override
  void initState() {
    // TODO: implement initState
    getPaidStudentData();
    getAllStudent();
    getAllDueStudent();
    super.initState();



      setState(() {
        photoUrl = _mybox.get("AdminPhotoUrl");
        AdminName = _mybox.get("AdminName");
        AdminEmail = _mybox.get("AdminEmail");
      });


  
    

  // FlutterNativeSplash.remove();
  
  
  }











  
  Future refresh() async{


    setState(() {
      
    getPaidStudentData();
    getAllStudent();
    getAllDueStudent();


    });




  }




















  @override
  Widget build(BuildContext context) {


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


           widget.indexNumber == "1"?
              IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.home_sharp,
                  color: Colors.white,
                  size: 55,
                  fill: 1.0,
                ),
              ): IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.home_sharp,
                  color: Colors.white,
                  size: 25,
                ),
              ),




              IconButton(
                enableFeedback: false,
                onPressed: () {


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllNotice(indexNumber: "2")));


                },
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 25,
                ),
              ),




              IconButton(
                enableFeedback: false,
                onPressed: () {


                   Navigator.of(context).push(MaterialPageRoute(builder: (context) =>MonthlyCourseFeeCollection()));



                },
                icon: const Icon(
                  Icons.account_balance,
                  color: Colors.white,
                  size: 25,
                ),
              ),



              IconButton(
                enableFeedback: false,
                onPressed: () {

                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllDepartment()));




                },
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



      systemOverlayStyle: SystemUiOverlayStyle(
            // Navigation bar
            statusBarColor: ColorName().appColor, // Status bar
          ),
       
        leading:Center(
                      child:  Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            "${photoUrl}",
                          ),
                        ),
                      ),
                    ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
       automaticallyImplyLeading: false,
        title: const Text("Your Dashboard", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
        backgroundColor: ColorName().appColor,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        actions: [



          PopupMenuButton(
          onSelected: (value) {
            // your logic
          },
          itemBuilder: (BuildContext context) {
            return  [


               PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminProfile(AdminEmail: AdminEmail)));




                },
                child: Center(
                  child: Column(
                    children: [
                    Center(
                      child:  CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          "${photoUrl}",
                        ),
                      ),
                    ),


                    Text("NAME: ${AdminName.toUpperCase().toString()}", style: TextStyle(overflow: TextOverflow.ellipsis),),
                    Text("${AdminEmail.toLowerCase()}"),




                    ],
                  ),
                ),
                
                padding: EdgeInsets.all(18.0),
              ),





              PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllDepartmentAttendance()));




                },
                child: Row(
                  children: [
                    Icon(Icons.fingerprint),
                    SizedBox(width: 5,),
                    Text("Student Attendance"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),





               PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllDepartment()));




                },
                child: Row(
                  children: [
                    Icon(Icons.person_4),
                    SizedBox(width: 5,),
                    Text("All Students"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),





               PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllDueStudents(indexNumber: "")));




                },
                child: Row(
                  children: [
                    Icon(Icons.payment),
                    SizedBox(width: 5,),
                    Text("Due Students"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),








              
              //  PopupMenuItem(
              //   onTap: (){


              //       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDayDuePaymentAddHistory()));


              //   },
              //   child: Row(
              //     children: [
              //       Icon(Icons.payment),
              //       SizedBox(width: 5,),
              //       Text("Today Due Add"),
              //       SizedBox(width: 5,),
              //       Icon(Icons.arrow_right_alt),
              //     ],
              //   ),
                
              //   padding: EdgeInsets.all(18.0),
              // ),






              // PopupMenuItem(
              //   onTap: (){


              //       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerMonthDuePaymentAddHistory()));




              //   },
              //   child: Row(
              //     children: [
              //       Icon(Icons.payments_rounded),
              //       SizedBox(width: 5,),
              //       Text("Monthly Due Add"),
              //       SizedBox(width: 5,),
              //       Icon(Icons.arrow_right_alt),
              //     ],
              //   ),
                
              //   padding: EdgeInsets.all(18.0),
              // ),











              
              //  PopupMenuItem(
              //   onTap: (){


              //       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerDayDueCustomer()));




              //   },
              //   child: Row(
              //     children: [
              //       Icon(Icons.person_4),
              //       SizedBox(width: 5,),
              //       Text("Today Due Customers"),
              //       SizedBox(width: 5,),
              //       Icon(Icons.arrow_right_alt),
              //     ],
              //   ),
                
              //   padding: EdgeInsets.all(18.0),
              // ),




              
       
              PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MonthlyCourseFeeCollection()));




                },
                child: Row(
                  children: [
                    Icon(Icons.account_balance),
                    SizedBox(width: 5,),
                    Text("Monthly Course Fee"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),







              PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllAdmins(indexNumber: "")));




                },
                child: Row(
                  children: [
                    Icon(Icons.admin_panel_settings),
                    SizedBox(width: 5,),
                    Text("All Admins"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),





               



              
                 PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MonthlyExamFeeCollection()));




                },
                child: Row(
                  children: [
                    Icon(Icons.account_balance),
                    SizedBox(width: 5,),
                    Text("Exam Fee History"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),



               PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoticeUpload()));




                },
                child: Row(
                  children: [
                    Icon(Icons.notification_add),
                    SizedBox(width: 5,),
                    Text("Notice Upload"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),



              PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>AllNotice(indexNumber: "")));




                },
                child: Row(
                  children: [
                    Icon(Icons.notifications),
                    SizedBox(width: 5,),
                    Text("All Notice"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),










               PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>AllTeachers(indexNumber: "")));




                },
                child: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 5,),
                    Text("All Teachers"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),














                  PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllTeacherGiveAttendance(indexNumber: "")));




                },
                child: Row(
                  children: [
                    Icon(Icons.fingerprint),
                    SizedBox(width: 5,),
                    Text("teacher Attendance"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),




               PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePassword()));




                },
                child: Row(
                  children: [
                    Icon(Icons.password),
                    SizedBox(width: 5,),
                    Text("Change Password"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),
              




              PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SMSInfo()));




                },
                child: Row(
                  children: [
                    Icon(Icons.sms),
                    SizedBox(width: 5,),
                    Text("SMS Info"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),
              



              

              


              

              


              



                PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SendSMSToAllStudents()));




                },
                child: Row(
                  children: [
                    Icon(Icons.sms),
                    SizedBox(width: 5,),
                    Text("Student Msg Send"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),
              



          PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllStudentSetDue()));




                },
                child: Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 5,),
                    Text("Set All Due"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),
              



               PopupMenuItem(
                onTap: (){


                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeveloperInfo()));




                },
                child: Row(
                  children: [
                    Icon(Icons.developer_board),
                    SizedBox(width: 5,),
                    Text("Developer Info"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),















              





           PopupMenuItem(
                onTap: () async{

                          FirebaseAuth.instance
                            .authStateChanges()
                            .listen((User? user) async{
                              if (user == null) {
                                
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AdminLogInScreen()),
                      );
                                print('User is currently signed out!');
                              } else {
                                print('User is signed in!');
                                await FirebaseAuth.instance.signOut();
                                          
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AdminLogInScreen()),
                      );
                              }
                            });
                  




                },
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 5,),
                    Text("LogOut"),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_right_alt),
                  ],
                ),
                
                padding: EdgeInsets.all(18.0),
              ),
              



              






              

              






              
             
            ];
          },
        )
                ],
        
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
      
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                
                  ClipPath(
            clipper: BackgroundWaveClipper(),
            child: Container(
              child:         Center(
                child: Container(
                transform: Matrix4.translationValues(0.0, -30.0, 0.0),

                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  
                  child: DefaultTextStyle(
                    style:  TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
                      fontWeight: FontWeight.bold
                    ),
                    child: AnimatedTextKit(
                      
                      repeatForever: true,
                      animatedTexts: [
                        TypewriterAnimatedText('Hi...'),
                        TypewriterAnimatedText('${AdminName.toUpperCase()}'),
                        TypewriterAnimatedText('Welcome to Uttaron Polytechnic Institute'),
                        
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                ),
                ),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: 180,
              decoration: BoxDecoration(
                
                color: ColorName().appColor
                ),
            ),
          ),





          Center(

                child: Container(

                  
                  transform: Matrix4.translationValues(0.0, -100.0, 0.0),

                  child: CircleAvatar(
                radius: 60,

                backgroundImage:
                    NetworkImage("${photoUrl}"),
                backgroundColor: Colors.transparent,
                
              
              ),
                         
                         
                         
                
                ),
                ),



                
                
                   Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                height: 200,
                child: Center(
                  child: Text("Total Student: ${AllStudent.length.toString()}", style: TextStyle(
                  
                          fontSize: 20,
                          color: Colors.white,
                          overflow: TextOverflow.clip
                        ),),
                
                
                ),
                     
                 decoration: BoxDecoration(
                color: Colors.pink.shade300,
                
                border: Border.all(
                          width: 2,
                          color: Colors.pink.shade300
                        ),
                borderRadius: BorderRadius.circular(10)      
                 ),)),
                
                
                 SizedBox(
                height: 10,
                 ),
                
                
                
                
                
                
                 
                   Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                height: 200,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        Text("Total Due Student: ${AllDueStudentData.length.toString()}", style: TextStyle(
                  
                          fontSize: 20,
                          color: Colors.white,
                          overflow: TextOverflow.clip
                        ),).animate(autoPlay: true) .fade(duration: 1000.ms)
  .scale(delay: 1000.ms).move(delay: 300.ms, duration: 600.ms),
                  
                  
                              
                              
                  SizedBox(
                height: 17,
                               ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                                          
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            
                            
                            children: [
                                          
                                          
                                        Container(width: 100, child:TextButton(onPressed: (){
                              
                              
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllDueStudents(indexNumber: "")));
                              
                              
                              
                              
                              
                                        }, child: Text("View", style: TextStyle(color: Theme.of(context).primaryColor),), style: ButtonStyle(
                             
                                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                      ),),),
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                            ],),
                        )
                      ],
                    ),
                  ),
                              
                              
                ),
                     
                               decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                              
                border: Border.all(
                          width: 2,
                          color: Theme.of(context).primaryColor
                        ),
                borderRadius: BorderRadius.circular(10)      
                               ),)),
                
                
                 SizedBox(
                height: 10,
                 ),
                
                
                
                
                
                 
                   Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                height: 200,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        Text("Total Paid Student: ${AllPaidStudentData.length.toString()}", style: TextStyle(
                  // ${moneyAdd.toString()}
                          fontSize: 20,
                          color:Colors.white,
                          overflow: TextOverflow.clip
                         
                        ),).animate(autoPlay: true) .fade(duration: 1000.ms)
  .scale(delay: 1000.ms).move(delay: 300.ms, duration: 600.ms),
                  
                  
                  
                  
                  
                  
                  
                  
                  
                           SizedBox(
                                  height: 17,
                                 ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                                            
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              
                              
                              children: [
                                            
                                            
                                          Container(width: 100, child:TextButton(onPressed: (){
                
                
                
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllDepartment()));
                
                
                
                
                
                
                
                                          }, child: Text("View", style: TextStyle(color: Color.fromARGB(255, 242,133,0)),), style: ButtonStyle(
                               
                                          backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                                        ),),),
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                                            
                              ],),
                          )
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                      ],
                    ),
                  ),
                
                
                ),
                     
                 decoration: BoxDecoration(
                color: Color.fromARGB(255, 242,133,0),
                
                border: Border.all(
                          width: 2,
                          color: Color.fromARGB(255, 242,133,0)
                        ),
                borderRadius: BorderRadius.circular(10)      
                 ),)),
                
                
                 SizedBox(
                height: 10,
                 ),
                
                
      
              
                  ])),
      ));
  }
}













class BackgroundWaveClipper extends CustomClipper<Path> {
  @override
Path getClip(Size size) {
    var path = Path();

    final p0 = size.height * 0.95;
    path.lineTo(0.0, p0);

    final controlPoint = Offset(size.width * 0.4, size.height);
    final endPoint = Offset(size.width, size.height / 4);
    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(BackgroundWaveClipper oldClipper) =>
      oldClipper != this;
}
