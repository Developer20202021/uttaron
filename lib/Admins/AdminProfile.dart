import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:uttaron/AllStudent/CourseFeeHistory.dart';
import 'package:uttaron/AllStudent/ExamFeeHistory.dart';

 



class AdminProfile extends StatefulWidget {


  final String AdminEmail;
  





  const AdminProfile({super.key, required this.AdminEmail});

  @override
  State<AdminProfile> createState() => _EditCustomerInfoState();
}

class _EditCustomerInfoState extends State<AdminProfile> {


bool loading = true;







   // Firebase All Customer Data Load

List  AllData = [];


  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('Admin');

Future<void> getData(String AdminEmail) async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();


    Query query = _collectionRef.where("AdminEmail", isEqualTo: AdminEmail);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

     setState(() {
       AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

      loading = false;
     });

    print(AllData);
}






























@override
  void initState() {
    // TODO: implement initState

    
    
    getData(widget.AdminEmail);

    // getSaleData();
    super.initState();
  }



  Future refresh() async{


    setState(() {
            loading = true;
            
           getData(widget.AdminEmail);
          //  getSaleData();

    });

  }
















  @override
  Widget build(BuildContext context) {




    


 

    return  Scaffold(
      backgroundColor: Colors.white,

      


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



                   FirebaseAuth.instance
                  .authStateChanges()
                  .listen((User? user) {
                    if (user == null) {
                      print('User is currently signed out!');
                    } else {
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(userName: user.displayName, userEmail: user.email, indexNumber: "1",)));
                    }
                  });





                },
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {

    //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(indexNumber: "2",)));


                },
                icon: const Icon(
                  Icons.electric_bike_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {


                  //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllAdmin(indexNumber: "3",)));




                },
                icon: const Icon(
                  Icons.admin_panel_settings_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {


                  //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllCustomer(indexNumber: "4")));




                },
                icon: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ],
          ),),
      ),

      
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("Admin Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
      
                child: loading?Center(
          child: LoadingAnimationWidget.discreteCircle(
            color: const Color(0xFF1A1A3F),
            secondRingColor: Theme.of(context).primaryColor,
            thirdRingColor: Colors.white,
            size: 100,
          ),
        ):Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              
                      
                      Center(
                        child:  CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                            "${AllData[0]["AdminImageUrl"]}",
                          ),
                        ),
                      ),
              
               SizedBox(
                        height: 20,
                      ),
      
      
                  Table(
                       border: TableBorder(
                       horizontalInside:
                  BorderSide(color: Colors.white, width: 10.0)),
                      textBaseline: TextBaseline.ideographic,
                        children: [




                  
                  
      
                        TableRow(
                          
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          children: [
                                  Container(
                                    
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Name", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                    )),
                                  
                                  
                                  Container(
                                    
                                    
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${AllData[0]["AdminName"].toString().toUpperCase()}", style: TextStyle(fontSize: 15.0),),
                                    )),
                                
                                ]),
                          



                        
                        TableRow(
                          
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          children: [
                                  Container(
                                    
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Phone No", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                    )),
                                  
                                  
                                  Container(
                                    
                                    
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${AllData[0]["AdminPhoneNumber"].toString().toUpperCase()}", style: TextStyle(fontSize: 15.0),),
                                    )),
                                
                                ]),





                                
                                TableRow(
                          
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          children: [
                                  Container(
                                    
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Email", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                    )),
                                  
                                  
                                  Container(
                                    
                                    
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${AllData[0]["AdminEmail"].toString().toUpperCase()}", style: TextStyle(fontSize: 15.0),),
                                    )),
                                
                                ]),






                                





                                TableRow(
                          
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          children: [
                                  Container(
                                    
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Address", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                                    )),
                                  
                                  
                                  Container(
                                    
                                    
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${AllData[0]["AdminAddress"].toString().toUpperCase()}", style: TextStyle(fontSize: 15.0),),
                                    )),
                                
                                ]),


                          
      
      
                   
      
                      
      
                         
                    
                       
                        ],
                      ),


                    SizedBox(height: 15,),



                    ],
                  ),
                ),
              ),
      ),
        
        floatingActionButton: FloatingActionButton(
      onPressed: (){




          // Navigator.push(
          //               context,
          //               MaterialPageRoute(builder: (context) => EditPreviousCustomer(AdminEmail: AllData[0]["AdminEmail"] , CustomerAddress:  AllData[0]["CustomerAddress"], CustomerName: AllData[0]["CustomerName"] , CustomerPhoneNumber: AllData[0]["CustomerPhoneNumber"]  , CustomerEmail: AllData[0]["CustomerEmail"] , CustomerFatherName: AllData[0]["CustomerFatherName"] , CustomerMotherName:  AllData[0]["CustomerMotherName"], CustomerGuarantor1Name:  AllData[0]["CustomerGuarantor1Name"], CustomerGuarantor1PhoneNumber:  AllData[0]["CustomerGuarantor1PhoneNumber"], CustomerGuarantor1Address:  AllData[0]["CustomerGuarantor1Address"], CustomerGuarantor2Name:  AllData[0]["CustomerGuarantor2Name"], CustomerGuarantor2PhoneNumber:  AllData[0]["CustomerGuarantor2PhoneNumber"], CustomerGuarantor2NID:  AllData[0]["CustomerGuarantor2NID"], CustomerGuarantor2Address: AllData[0]["CustomerGuarantor2Address"] , CustomerGuarantor1NID: AllData[0]["CustomerGuarantor1NID"])),
          //             );











      },
        tooltip: 'Edit',
        child: const Icon(Icons.edit),
      ), 
      
    );
  }
}



class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.purple;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}