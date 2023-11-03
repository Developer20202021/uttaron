
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:uttaron/LogIn/AdminNotApprove.dart';
import 'package:uttaron/LogIn/EmailNotVerified.dart';
import 'package:uttaron/Registration/AllRegistration.dart';




class AdminLogInScreen extends StatefulWidget {
  const AdminLogInScreen({super.key});

  @override
  State<AdminLogInScreen> createState() => _AdminLogInScreenState();
}

class _AdminLogInScreenState extends State<AdminLogInScreen> {
  TextEditingController myEmailController = TextEditingController();
  TextEditingController myPassController = TextEditingController();



   var createUserErrorCode = "";

   bool loading = false;

   // hive database

  final _mybox = Hive.box("mybox");







   @override
  void initState() {
    // TODO: implement initState
    FlutterNativeSplash.remove();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    FocusNode myFocusNode = new FocusNode();
 

    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        automaticallyImplyLeading: false,
        title: const Text("Admin Log In",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: SingleChildScrollView(

        child: loading?Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: const Color(0xFF1A1A3F),
                        secondRingColor: Theme.of(context).primaryColor,
                        thirdRingColor: Colors.white,
                        size: 100,
                      ),
                    ),
              ): AutofillGroup(
                child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [



                      
              
              
              
              
              
                 createUserErrorCode=="wrong-password"? Center(
                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                
                
                                  child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.close, color: Colors.red,),
                      Text("Wrong password provided for that user."),
                    ],
                  ),
                                  ),
                   
                               decoration: BoxDecoration(
                                color: Colors.red[100],
                
                                border: Border.all(
                        width: 2,
                        color: Colors.white
              
                        
                      ),
                                borderRadius: BorderRadius.circular(10)      
                               ),)),
                ):Text(""),
              
              
              
              
              
              
              
                createUserErrorCode=="user-not-found"? Center(
                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                
                
                                  child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Icon(Icons.close, color: Colors.red,),
                      Text("No user found for that email.", overflow: TextOverflow.clip,),
                    ],
                  ),
                                  ),
                   
                               decoration: BoxDecoration(
                                color: Colors.red[100],
                
                                border: Border.all(
                        width: 2,
                        color: Colors.white
              
                        
                      ),
                                borderRadius: BorderRadius.circular(10)      
                               ),)),
                ):Text(""),
              
              
              
              
              
              
              
              
                
              
              
              
              
                          
                
                // Center(
                //   child: Lottie.asset(
                //   'lib/images/animation_lk8fkoa8.json',
                //     fit: BoxFit.cover,
                //     width: 200,
                //     height: 200
                //   ),
                // ),
                          
                          // SizedBox(
                          //           height: 20,
                          //         ),


                           
                    Center(
                      child: Lottie.asset(
                      'lib/images/animation_lk8fkoa8.json',
                        fit: BoxFit.cover,
                        width: 200,
                        height: 200
                      ),
                    ),
            
            SizedBox(
                      height: 20,
                    ),
                          
                          
                          
                TextField(
                  autofillHints: [AutofillHints.email],
                  
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Email',
                       labelStyle: TextStyle(
                      color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                          ),
                      hintText: 'Enter Your Email',
                          
                      //  enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                      //     ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                          ),
                      
                      
                      ),
                  controller: myEmailController,
                ),
                          
                          
                          
                          
                SizedBox(
                  height: 20,
                ),
                          
                          
                          
                          
                          
                TextField(
                   autofillHints: [AutofillHints.password],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Password',
                       labelStyle: TextStyle(
                      color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                          ),
                      hintText: 'Enter Your Password',
                      //  enabledBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(width: 3, color: Colors.greenAccent),
                      //   ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Color.fromARGB(255, 66, 125, 145)),
                        ),
                      
                      
                      ),
                  controller: myPassController,
                ),
                          
                SizedBox(
                  height: 10,
                ),
                          
                          
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: 150, child:TextButton(onPressed: () async{
              
              
                      setState(() {
                        loading = true;
                      });
              
                      try {
                        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: myEmailController.text.trim(),
                          password: myPassController.text.trim()
                        );
              
                        var userName = credential.user!.displayName;
                        var userEmail = credential.user!.email;
                        var userVerified = credential.user!.emailVerified;
              
              
                        if (userVerified) {
              
              
                          List  AllData = [];
              
              
                      CollectionReference _collectionRef =
                        FirebaseFirestore.instance.collection('Admin');
              
                        Query query = _collectionRef.where("AdminEmail", isEqualTo: myEmailController.text.trim());
                      QuerySnapshot querySnapshot = await query.get();
              
                  
                        // Get docs from collection reference
                       
              
                        // Get data from docs and convert map to List
                        AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
                        setState(() {
                          
                          AllData = querySnapshot.docs.map((doc) => doc.data()).toList();
                        });
              
              
              
              
              
                        print(AllData);
                          
              
              
                 
              
              
              
                    if (AllData[0]["AdminApprove"] == "true") {

                        _mybox.delete("AdminPhotoUrl");
                        _mybox.delete("AdminName");
                         _mybox.delete("AdminEmail");


                      _mybox.put("AdminPhotoUrl",AllData[0]["AdminImageUrl"]);
                      _mybox.put("AdminName", AllData[0]["AdminName"]);
                      _mybox.put("AdminEmail", AllData[0]["AdminEmail"]);
              
                      
              
              
                            //  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDashboard(indexNumber: "1",)),);
              
                             setState(() {
                            loading=false;
                          });
              
                      
                    }
              
                    else{
              
                      setState(() {
                            loading=false;
                          });
              
              
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminNotApprove()),);
              
              
                    }
              
              
              
                          
              
              
              
              
              
              
              
              
              
              
              
                         
              
              
              
              
              
              
              
              
              
                          
              
                          
                        }
                        else{
              
              
                            await credential.user?.delete();
              
                               CollectionReference _collectionRef =
                        FirebaseFirestore.instance.collection('Admin');
                            _collectionRef.doc(userEmail).delete().then(
                    (doc) => print("Document deleted"),
                    onError: (e) => print("Error updating document $e"),
                  );
              
                              setState(() {
                            loading=false;
                          });
                          
                             Navigator.push(context, MaterialPageRoute(builder: (context) => EmailNotVerified()),);
              
              
                        }
              
              
              
              
                  
              
              
              
                        
                    
              
              
              
              
              
              
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
              
                          setState(() {
                            loading=false;
                            createUserErrorCode = "user-not-found";
                            
                          });
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
              
              
                          setState(() {
                            loading=false;
                            createUserErrorCode = "wrong-password";
                            
                          });
                          print('Wrong password provided for that user.');
                        }
                      }
              
              
              
              
              
              
              
                    }, child: Text("Log in", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                     
                        backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
                      ),),),
              
              
              
                Container(width: 150, child:TextButton(onPressed: (){
              
                       Navigator.push(
                    context,
              
                           MaterialPageRoute(builder: (context) => const AllRegistration()),
                  );
              
              
              
              
                }, child: Text("Create Account", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                     
                        backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
                      ),),),
              
              
              
              
              
                  ],
                )
                          
                          
                          
                          ],
                        ),
                      ),
              ),
        ),
      
      
    );
  }
}



class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xff8f00ff);
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