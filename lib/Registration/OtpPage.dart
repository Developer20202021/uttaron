
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:uttaron/LogIn/AdminLogIn.dart';
import 'package:uttaron/Registration/AllRegistration.dart';






class OtpPage extends StatefulWidget {


  final StudentPhoneNumber;
  final StudentEmail;





  const OtpPage({super.key, required this.StudentPhoneNumber, required this.StudentEmail});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController StudentOTPController = TextEditingController();
 

bool loading = false;


bool resend = false;







List  AllData = [];
var DataLoad = "";

// bool loading = true;


  CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('StudentInfo');

Future<void> StudentVerification() async {
    // Get docs from collection reference
    // QuerySnapshot querySnapshot = await _collectionRef.get();

    setState(() {
      loading = true;
    });


    Query query = _collectionRef.where("StudentEmail", isEqualTo: widget.StudentEmail);
    QuerySnapshot querySnapshot = await query.get();

    // Get data from docs and convert map to List
     AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

       if (AllData.length == 0) {
      setState(() {
        DataLoad = "0";
        loading = false;
      });
       
     } else {

      setState(() {
      
       AllData = querySnapshot.docs.map((doc) => doc.data()).toList();

       for (var i = 0; i < AllData.length; i++) {

       var otpCode = AllData[i]["OtpCode"];


       print(otpCode);


       if (otpCode =="${StudentOTPController.text.trim()}") {




           final docUser = FirebaseFirestore.instance.collection("StudentInfo").doc(widget.StudentEmail);

                  final UpadateData ={

                    "PhoneVerify":"true"

                
                };





                // user Data Update and show snackbar

                  docUser.update(UpadateData).then((value) => setState((){


                    setState(() {
                      loading = false;
                    });



                    print("Done");

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllRegistration()),
                );


                       final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Phone Verification Successfull',
                      message:
                          'Phone Verification Successfull',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);



                  })).onError((error, stackTrace) => setState((){

                    print(error);

                  }));













         
       } else {

             setState(() {
                      loading = false;
                    });

            

              final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Wrong OTP',
                      message:
                          'Wrong OTP',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.failure,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);



         
       }




         
       }




       loading = false;
     });
       
     }

    print(AllData);
}




var rng = new Random();
var code = Random().nextInt(900000) + 100000;






Future ResendOTPSend() async{


                setState(() {

                  loading = true;
                  
                });



      var OtpMsg ="Your OTP ${code} Uttaron InanSoft";

                  final response = await http
                      .get(Uri.parse('https://api.greenweb.com.bd/api.php?token=1024519252916991043295858a1b3ac3cb09ae52385b1489dff95&to=${widget.StudentPhoneNumber}&message=${OtpMsg}'));

                  if (response.statusCode == 200) {




                    final docUser = FirebaseFirestore.instance.collection("StudentInfo").doc(widget.StudentEmail);

                  final UpadateData ={

                    "OtpCode":code.toString()

                
                };





                // user Data Update and show snackbar

                  docUser.update(UpadateData).then((value) => setState((){


                    setState(() {
                      loading = false;
                      resend = true;
                    });



                    print("Done");

                   

               


                       final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'OTP sent',
                      message:
                          'OTP sent',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);



                  })).onError((error, stackTrace) => setState((){

                    print(error);

                  }));






                    print("");
                    
                  } else {

                    setState(() {
                      loading = false;
                    });
                    // If the server did not return a 200 OK response,
                    // then throw an exception.
                    throw Exception('Failed to load album');
                  }





}



















  



@override
  void initState() {
    // TODO: implement initState
    // getData(widget.CustomerNID);
    super.initState();
  }

















  @override
  Widget build(BuildContext context) {

    
 

    return Scaffold(
      
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("OTP",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: loading?Center(
        child: LoadingAnimationWidget.discreteCircle(
          color: const Color(0xFF1A1A3F),
          secondRingColor: Theme.of(context).primaryColor,
          thirdRingColor: Colors.white,
          size: 100,
        ),
      ):Container(

        child: loading?CircularProgressIndicator():SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
        
        
        
                
           Container(
        
              color: Color.fromARGB(255, 245, 201, 42),
              
              
              child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("আপনার ${widget.StudentPhoneNumber} এ OTP পাঠানো হয়েছে", style: TextStyle(color: Colors.black),),
              )),
        
        
        
        
              
            SizedBox(height: 15,),
        
        
              
              SizedBox(
                  height: 5,
                ),
              
              
              
                TextField(
                  
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter OTP',
            
                      hintText: 'Enter OTP',
              
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
                  controller: StudentOTPController,
                ),
              
              
              
              
                SizedBox(
                  height: 5,
                ),



              resend?Icon(Icons.check):Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(width: 80, child:TextButton(onPressed: () async{
        
        
                      setState(() {
                        loading = true;
                      });
        
        
                      ResendOTPSend();
        
                
        
        
                 
        
        
        
        
        
                    }, child: Text("Resend", style: TextStyle(color: Colors.white, fontSize: 12),), style: ButtonStyle(
                     
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.pink.shade400),
          ),),),
        
        
        
        
        
        
        
        
                  ],
                ),



                SizedBox(
                  height: 5,
                ),
              
              
              
              
              
                
              
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(width: 150, child:TextButton(onPressed: () async{
        
        
                      setState(() {
                        loading = true;
                      });
        
        
                      StudentVerification();
        
                
        
        
                 
        
        
        
        
        
                    }, child: Text("Verify", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                     
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
    paint.color = Color(0xf08f00ff);
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
