import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:uttaron/DeveloperAccess/DeveloperAccess.dart';
import 'package:uttaron/Registration/AdminImageUpload.dart';
import 'package:uttaron/Registration/AllRegistration.dart';
import 'package:uttaron/Registration/EmailNotVerified.dart';
import 'package:path/path.dart';
import 'package:uttaron/Teachers/AllTeachers.dart';






class EditTeacher extends StatefulWidget {


  final TeacherEmail;
  final TeacherAddress;
  final TeacherPhoneNumber;
  final TeacherName;
  final SubjectName;
  final DepartmentName;




  const EditTeacher({super.key, required this.TeacherEmail, required this.DepartmentName, required this.SubjectName, required this.TeacherAddress,required this.TeacherName, required this.TeacherPhoneNumber});

  @override
  State<EditTeacher> createState() => _EditTeacherState();
}

class _EditTeacherState extends State<EditTeacher> {

  TextEditingController myAddressController = TextEditingController();
  TextEditingController myPhoneNumberController = TextEditingController();
  TextEditingController myAdminNameController = TextEditingController();
  TextEditingController SubjectController = TextEditingController();




  String SelectedValue = ""; 

 var createUserErrorCode = "";

 bool loading = false;

  File? _photo;

  String image64 = "";


 
  String errorTxt = "";





  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);

        final bytes = File(pickedFile.path).readAsBytesSync();

        setState(() {
          image64 = base64Encode(bytes);
        });

        uploadFile(context);
      } else {
        print('No image selected.');
      }
    });
  }






  
  Future imgFromCamera(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile(context);
      } else {
        print('No image selected.');
      }
    });
  }





  
  Future uploadFile(BuildContext context) async {
    if (_photo == null) return;
    
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    print(_photo!.path);

    try {


      setState(() {
        loading = true;
      });



   var request = await http.post(Uri.parse("https://api.imgbb.com/1/upload?key=9a7a4a69d9a602061819c9ee2740be89"),  body: {
          'image':'$image64',
        } ).then((value) => setState(() {


          print(jsonDecode(value.body));



          var serverData = jsonDecode(value.body);

          var serverImageUrl = serverData["data"]["url"];

          print(serverImageUrl);

          updateData(serverImageUrl,context);






        })).onError((error, stackTrace) => print(error));




    } catch (e) {
      print(e);
    }
  }






  
  Future updateData(String AdminImageUrl,BuildContext context) async{

    setState(() {
        loading = true;
      });



      print("__________________________________________________________${widget.TeacherEmail}");


         final docUser = FirebaseFirestore.instance.collection("TeacherInfo").doc(widget.TeacherEmail);

                  final UpadateData ={

                    "TeacherImageUrl":AdminImageUrl

                
                };





                // user Data Update and show snackbar

                  docUser.update(UpadateData).then((value) => setState((){


                      setState(() {
                            loading = false;
                       
                          });


                    print("Done");




                
                       final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Your Image Upload Successfull',
                      message:
                          'Your Image Upload Successfull',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);



                  })).onError((error, stackTrace) => setState((){

                    loading = false;




                    
                       final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Image Upload Failed',
                      message:
                          'Image Upload Failed',
        
                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.failure,
                    ),
                  );
        
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);










                    print(error);

                  }));



  }




























  void setDepartment(){

    setState(() {
      SelectedValue = widget.DepartmentName;
    });




  }













  
  @override
  void initState() {
  
    super.initState();
    // FlutterNativeSplash.remove();
    setDepartment();
    
  }


  @override
  Widget build(BuildContext context) {

    FocusNode myFocusNode = new FocusNode();

    myAddressController.text = widget.TeacherAddress;
    myAdminNameController.text = widget.TeacherName;
    myPhoneNumberController.text = widget.TeacherPhoneNumber;
    SubjectController.text = widget.SubjectName;





   







    


 

    return  Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
       automaticallyImplyLeading: false,
        title: const Text("Teacher Registration", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: SingleChildScrollView(

              child:  loading?Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: const Color(0xFF1A1A3F),
                        secondRingColor: Theme.of(context).primaryColor,
                        thirdRingColor: Colors.white,
                        size: 100,
                      ),
                    ),
              ):Padding(
                padding: const EdgeInsets.all(8.0),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [




                          errorTxt.isNotEmpty?  Center(
                            child: Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Container(
                                       
                                                   color: Colors.red.shade400,
                                                   
                                                   
                                                   child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${errorTxt}", style: TextStyle(color: Colors.white),),
                                                   )),
                                       ),
                          ):Text(""),




            
          SizedBox(height: 15,),





                        
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Theme.of(context).primaryColor,
                child: _photo != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.file(
                          _photo!,
                          width: 200,
                          height: 200,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5)),
                        width: 200,
                        height: 200,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
            ),
          ),

          SizedBox(height: 75,),



                    
                    // Center(
                    //   child: Lottie.asset(
                    //   'lib/images/animation_lk8g4ixk.json',
                    //     fit: BoxFit.cover,
                    //     width: 300,
                    //     height: 200
                    //   ),
                    // ),
            
            // SizedBox(
            //           height: 20,
            //         ),
            
            
            
                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Name',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Enter Your Name',
            
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
                      controller: myAdminNameController,
                    ),
            
            
            
            
                 
            
            
            
            
                   
                    SizedBox(
                      height: 15,
                    ),



            
  
            
            
         
                    TextField(
                      keyboardType: TextInputType.streetAddress,
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Address',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Enter Address',
            
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
                      controller: myAddressController,
                    ),
            
            

                   
                    SizedBox(
                      height: 15,
                    ),



                    
                    TextField(
                      keyboardType: TextInputType.phone,
                      focusNode: myFocusNode,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Phone Number',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Enter Your Phone Number',
            
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
                      controller: myPhoneNumberController,
                    ),
            
            
            
            
                    SizedBox(
                      height: 15,
                    ),


                    
                    TextField(
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Subject',
                           labelStyle: TextStyle(
              color: myFocusNode.hasFocus ? Theme.of(context).primaryColor: Colors.black
                  ),
                          hintText: 'Enter Subject',
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
                      controller: SubjectController,
                    ),
            

            SizedBox(
                      height: 15,
                    ),




                  
                      Container(
                        height: 70,
                        child: DropdownButton(
                         
                                           
                         
                          hint:  SelectedValue == ""
                              ? Text('Department')
                              : Text(
                                 SelectedValue,
                                  style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: ColorName().appColor, fontWeight: FontWeight.bold, fontSize: 16),
                          items: ['EEE', 'CSE', 'Civil', "ME"].map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                 SelectedValue = val!;
                              },
                            );
                          },
                        ),
                      ),





            SizedBox(
                      height: 15,
                    ),




             











            
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 150, child:TextButton(onPressed: () async{

                   


                          setState(() {
                            loading = true;
                          });





                      try {





                     final docUser =  FirebaseFirestore.instance.collection("TeacherInfo");

                      final jsonData ={

                        "TeacherName":myAdminNameController.text.trim().toLowerCase(),
                        "TeacherPhoneNumber":myPhoneNumberController.text.trim(),
                        "TeacherAddress":myAddressController.text.trim(),
                        "SubjectName":SubjectController.text.trim(),
                        "Department":SelectedValue,


                     
                      };




                    await docUser.doc(widget.TeacherEmail).update(jsonData).then((value) =>  setState(()async{



                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllTeachers(indexNumber: "")));

                    


                       final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Update Successfull',
                      message:
                          'Update Successfull',
        
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




                    })).onError((error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                              content: const Text('Something Wrong!'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            )));




                setState(() {
                    loading = false;
                  });


                        

                        // print(credential.user!.email.toString());
                      } on FirebaseAuthException catch (e) {


                        setState(() {

                          errorTxt = e.code.toString();

                          loading = false;
                          


                        });




                        
                        // if (e.code == 'weak-password') {

                        //   setState(() {
                        //     loading = false;
                        //     createUserErrorCode = "weak-password";
                        //   });
                        //   print('The password provided is too weak.');
                        // } else if (e.code == 'email-already-in-use') {

                        //   setState(() {
                        //     loading = false;
                        //     createUserErrorCode = "email-already-in-use";
                        //   });
                        //   print('The account already exists for that email.');
                        // }



                      } catch (e) {
                        loading = false;
                        print(e);
                      }












                      
                        }, child: Text("Edit", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                         
                backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
              ),),),










               





                      ],
                    )
            
            
            
                  ],
                ),
              ),
            ),
        
      
      
    );
  }



  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery(context);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera(context);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
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