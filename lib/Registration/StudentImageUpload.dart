import 'dart:convert';
import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:uttaron/DeveloperAccess/DeveloperAccess.dart';








class StudentImageUpload extends StatefulWidget {



  final AdminEmail;





  const StudentImageUpload({super.key,  required this.AdminEmail,});

  @override
  State<StudentImageUpload> createState() => _StudentImageUploadState();
}

class _StudentImageUploadState extends State<StudentImageUpload> {


  int count = 0;

  File? _photo;

  File? _photoNIDFront;

  File? _photoNIDBack;


  String image64 = "";

  bool loading = false;

  int totalImageCount = 0;









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










    Future NIDFrontImageFromGallery(BuildContext context) async {

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photoNIDFront = File(pickedFile.path);

        final bytes = File(pickedFile.path).readAsBytesSync();

        setState(() {
          image64 = base64Encode(bytes);
        });

        uploadNIDFrontImageFile(context);
      } else {
        print('No image selected.');
      }
    });
  }






    Future NIDBackImageGallery(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photoNIDBack = File(pickedFile.path);

        final bytes = File(pickedFile.path).readAsBytesSync();

        setState(() {
          image64 = base64Encode(bytes);
        });

        uploadNIDBackImageFile(context);
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





  Future NIDFrontImageCamera(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photoNIDFront = File(pickedFile.path);
        uploadNIDFrontImageFile(context);
      } else {
        print('No image selected.');
      }
    });
  }






Future NIDBackImageCamera(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photoNIDBack = File(pickedFile.path);
        uploadNIDBackImageFile(context);
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

          int imageCount = count + 1;

          count = imageCount;


          var serverData = jsonDecode(value.body);

          var serverImageUrl = serverData["data"]["url"];

          print(serverImageUrl);

          updateData(serverImageUrl,context);






        })).onError((error, stackTrace) => print(error));




    } catch (e) {
      print(e);
    }
  }








  Future uploadNIDFrontImageFile(BuildContext context) async {
    if (_photoNIDFront == null) return;
    
    final fileName = basename(_photoNIDFront!.path);
    final destination = 'files/$fileName';

    print(_photoNIDFront!.path);

    try {


      setState(() {
        loading = true;
      });



   var request = await http.post(Uri.parse("https://api.imgbb.com/1/upload?key=9a7a4a69d9a602061819c9ee2740be89"),  body: {
          'image':'$image64',
        } ).then((value) => setState(() {


          print(jsonDecode(value.body));

          int imageCount = count + 1;

          count = imageCount;


          var serverData = jsonDecode(value.body);

          var serverImageUrl = serverData["data"]["url"];

          print(serverImageUrl);

          updateNIDFrontImageData(serverImageUrl,context);






        })).onError((error, stackTrace) => print(error));




    } catch (e) {
      print(e);
    }
  }









  
  Future uploadNIDBackImageFile(BuildContext context) async {
    if (_photoNIDBack == null) return;
    
    final fileName = basename(_photoNIDBack!.path);
    final destination = 'files/$fileName';

    print(_photoNIDBack!.path);

    try {

  setState(() {
        loading = true;
      });

   var request = await http.post(Uri.parse("https://api.imgbb.com/1/upload?key=9a7a4a69d9a602061819c9ee2740be89"),  body: {
          'image':'$image64',
        } ).then((value) => setState(() {


          print(jsonDecode(value.body));

          int imageCount = count + 1;

          count = imageCount;


          var serverData = jsonDecode(value.body);

          var serverImageUrl = serverData["data"]["url"];

          print(serverImageUrl);

          updateNIDBackImageData(serverImageUrl,context);






        })).onError((error, stackTrace) => print(error));




    } catch (e) {
      print(e);
    }
  }












  Future updateData(String AdminImageUrl,BuildContext context) async{

    setState(() {
        loading = true;
      });



      print("__________________________________________________________${widget.AdminEmail}");


         final docUser = FirebaseFirestore.instance.collection("StudentInfo").doc(widget.AdminEmail);

                  final UpadateData ={

                    "StudentImageUrl":AdminImageUrl

                
                };





                // user Data Update and show snackbar

                  docUser.update(UpadateData).then((value) => setState((){


                      setState(() {
                            loading = false;
                            totalImageCount = totalImageCount + 1;
                          });


                    print("Done");

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AllFood()),
                // );


                   print("______________________________________________________________________________${totalImageCount}");



                
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

                    print(error);

                  }));



  }











    Future updateNIDFrontImageData(String AdminNIDFrontImageUrl,BuildContext context)
    
     async{


      setState(() {
        loading = true;
      });




         final docUser = FirebaseFirestore.instance.collection("StudentInfo").doc(widget.AdminEmail);

                  final UpadateData ={

                    "RegistrationCardImageUrl":AdminNIDFrontImageUrl

                
                };





                // user Data Update and show snackbar

                  docUser.update(UpadateData).then((value) => setState((){


                    print("Done");



                      setState(() {
                          loading = false;
                          totalImageCount = totalImageCount + 1;
                        });

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AllFood()),
                // );


                   print("______________________________________________________________________________${totalImageCount}");



                     final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'RegistrationCard Image Upload Successfull',
                      message:
                          'RegistrationCard Image Upload Successfull',
        
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



  }











  
    Future updateNIDBackImageData(String AdminNIDBackImageUrl,BuildContext context)
    
     async{



       setState(() {
        loading = true;
      });




         final docUser = FirebaseFirestore.instance.collection("StudentInfo").doc(widget.AdminEmail);

                  final UpadateData ={

                    "CertificateImageUrl":AdminNIDBackImageUrl

                
                };





                // user Data Update and show snackbar

                  docUser.update(UpadateData).then((value) => setState((){




                     setState(() {
                        loading = false;
                        totalImageCount = totalImageCount + 1;
                      });


                    print("______________________________________________________________________________${totalImageCount}");

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AllFood()),
                // );




                     final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'NID Back Image Upload Successfull',
                      message:
                          'NID Back Image Upload Successfull',
        
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



  }





@override
  void initState() {
    // TODO: implement initState

        
 
  print("_____________________________________${widget.AdminEmail}");
    super.initState();
  }






  




  @override
  Widget build(BuildContext context) {

    


    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        actions: [


          loading?CircularProgressIndicator(color: ColorName().appColor,):Text(""),

          totalImageCount == 3?IconButton(onPressed: (){


          }, icon: Icon(Icons.keyboard_double_arrow_right_sharp)):Text("")



        ],

        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        automaticallyImplyLeading: false,
        title:  Text("Upload Image", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: SingleChildScrollView(

              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child:  Column(
        children: <Widget>[
          SizedBox(
            height: 12,
          ),



          // Container(

          //   color: Theme.of(context).primaryColor,
            
            
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Text("আপনি ${count} টি Image Upload করেছেন।", style: TextStyle(color: Colors.white),),
          //   )),



        Container(

            color: Color.fromARGB(255, 245, 201, 42),
            
            
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("নিচে Student Image Upload করুন", style: TextStyle(color: Colors.black),),
            )),




            
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







               Container(

            color: Color.fromARGB(255, 245, 201, 42),
            
            
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("নিচে Registration Card Image Upload করুন", style: TextStyle(color: Colors.black),),
            )),




            
          SizedBox(height: 15,),






          Center(
            child: GestureDetector(
              onTap: () {
                _showNIDFrontImagePicker(context);
              },
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Theme.of(context).primaryColor,
                child: _photoNIDFront != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.file(
                          _photoNIDFront!,
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








          
               Container(

            color: Color.fromARGB(255, 245, 201, 42),
            
            
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("নিচে Certificate Image Upload করুন", style: TextStyle(color: Colors.black),),
            )),




            
          SizedBox(height: 15,),






          Center(
            child: GestureDetector(
              onTap: () {
                _showNIDBackImagePicker(context);
              },
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Theme.of(context).primaryColor,
                child: _photoNIDBack != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.file(
                          _photoNIDBack!,
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

          SizedBox(height: 15,),






              
                totalImageCount ==3?  Container(width: 150, child:TextButton(onPressed: () {




     AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Thank You',
            desc: 'Your Registration Successfull. Now Lets go',
       
            btnOkOnPress: () {


                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AdminLogInScreen()),
                // );
            },
            )..show();

                  











                  }, child: Text("Next", style: TextStyle(color: Colors.white),), style: ButtonStyle(
                   
          backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
        ),),):Text(""),






        

       





            
        



    


        



          
        ],
      ),)),
                 
                  
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





  
  void _showNIDFrontImagePicker(context) {
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
                        NIDFrontImageFromGallery(context);
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






    void _showNIDBackImagePicker(context) {
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
                        NIDBackImageGallery(context);
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