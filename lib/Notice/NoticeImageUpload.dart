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
import 'package:uuid/uuid.dart';








class NoticeImageUpload extends StatefulWidget {



  final NoticeID;





  const NoticeImageUpload({super.key,  required this.NoticeID,});

  @override
  State<NoticeImageUpload> createState() => _NoticeImageUploadState();
}

class _NoticeImageUploadState extends State<NoticeImageUpload> {


  int count = 0;

  File? _photo;

  File? _photoNIDFront;

  File? _photoNIDBack;


  String image64 = "";

  bool loading = false;

  int totalImageCount = 0;


   var uuid = Uuid();









  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery(BuildContext context, ImageID) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);

        final bytes = File(pickedFile.path).readAsBytesSync();

        setState(() {
          image64 = base64Encode(bytes);
        });

        uploadFile(context, ImageID);
      } else {
        print('No image selected.');
      }
    });
  }

























  Future imgFromCamera(BuildContext context, ImageID) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile(context, ImageID);
      } else {
        print('No image selected.');
      }
    });
  }




















  Future uploadFile(BuildContext context, ImageID) async {
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

          updateData(ImageID,serverImageUrl,context);






        })).onError((error, stackTrace) => print(error));




    } catch (e) {
      print(e);
    }
  }















 












  Future updateData(String ImageID,String NoticeImageUrl,BuildContext context) async{

    setState(() {
        loading = true;
      });



      print("__________________________________________________________${widget.NoticeID}");


         final docUser = FirebaseFirestore.instance.collection("NoticeImage");

                  final UpadateData ={

                      "NoticeImageUrl":NoticeImageUrl,
                      "NoticeID":widget.NoticeID,
                      "ImageID":ImageID

                
                };





                // user Data Update and show snackbar

                  docUser.doc(ImageID).update(UpadateData).then((value) => setState((){


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

























  




  @override
  Widget build(BuildContext context) {

      var NoticeImageID = uuid.v4();


    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        actions: [


          loading?CircularProgressIndicator(color: ColorName().appColor,):Text(""),

          totalImageCount >= 1?IconButton(onPressed: (){


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
              child: Text("নিচে আপনার নিজের Image Upload করুন", style: TextStyle(color: Colors.black),),
            )),




            
          SizedBox(height: 15,),






          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context, NoticeImageID);
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







            




            
          








         

          SizedBox(height: 15,),






              
                totalImageCount>=1?  Container(width: 150, child:TextButton(onPressed: () {




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




  void _showPicker(context, ImageID) {
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
                        imgFromGallery(context, ImageID);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera(context, ImageID);
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