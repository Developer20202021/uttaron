import 'package:flutter/material.dart';

class DeveloperInfo extends StatefulWidget {
  const DeveloperInfo({super.key});

  @override
  State<DeveloperInfo> createState() => _DeveloperInfoState();
}

class _DeveloperInfoState extends State<DeveloperInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        
        title: const Text("Developer Information",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: SingleChildScrollView(

        child:      Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                height: 420,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      children: [

                        Text("InanSoft", style: TextStyle(
                  
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),),

                          Text("Email: inansoft.official@gmail.com", style: TextStyle(
                  
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),),

                           Text("Phone: +8801822237022, +8801521719638", style: TextStyle(
                  
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),),

                           SizedBox(
                              height: 17,
                            ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                        
                        
                        
                        
                        
                              Row(
                        
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                        
                        
                                children: [
                        
                                   Center(
                                              child:  CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(
                            "https://w7.pngwing.com/pngs/81/570/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo-thumbnail.png",
                          ),
                                              ),
                                            ),
                        
                                            SizedBox(
                                width: 4,
                              ),
                        
                        
                        
                                        Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text("Fahadul Islam", style: TextStyle(
                                            
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),),
                                        ),
                        
                        
                        
                        
                        
                        
                        
                                ],
                              ),
                        
                        
                        
                          Text("Co-Founder & CEO InanSoft", style: TextStyle(
                                          
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),),
                        
                          Text("EEE BUET", style: TextStyle(
                                          
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),),
                        
                        
                        
                        
                            ],
                        
                        
                        
                          ),
                        ),







                      SizedBox(
                              height: 17,
                            ),





                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                        
                        
                        
                        
                        
                              Row(
                        
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                        
                        
                                children: [
                        
                                   Center(
                                              child:  CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(
                            "https://w7.pngwing.com/pngs/81/570/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo-thumbnail.png",
                          ),
                                              ),
                                            ),
                        
                                            SizedBox(
                                width: 4,
                              ),
                        
                        
                        
                                        Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text("Mahadi Hasan", style: TextStyle(
                                            
                                                                    fontSize: 16,
                                                                    color: Colors.white,
                                                                    fontWeight: FontWeight.bold
                                                                  ),),
                                        ),
                        
                        
                        
                        
                        
                        
                        
                                ],
                              ),
                        
                        
                        
                          Text("Co-Founder InanSoft", style: TextStyle(
                                          
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),),

                            Text("Software Developer", style: TextStyle(
                                          
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),),
                        
                                              
                            ],
                        
                        
                        
                          ),
                        ),








                  
                  


                        
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




      ));

  }
}