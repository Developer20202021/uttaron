import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';




class SingleCustomerFileView extends StatefulWidget {


  final FileUrl;



  const SingleCustomerFileView({super.key, required this.FileUrl});

  @override
  State<SingleCustomerFileView> createState() => _SingleCustomerFileViewState();
}

class _SingleCustomerFileViewState extends State<SingleCustomerFileView> {









  @override
  Widget build(BuildContext context) {


 

    return Scaffold(
      backgroundColor: Colors.white,
      
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.purple),
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.chevron_left)),
        title: const Text("File",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        
      ),
      body: SingleChildScrollView(

        child:  Container(
          child:
           Image.network("${widget.FileUrl}")
              ),
        ),
      
      
    );
  }
}


