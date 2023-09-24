import 'package:flutter/material.dart';
import 'package:gm/cleaning.dart';
import 'package:gm/electricity.dart';
import 'package:gm/plumbing.dart';
//import 'package:gm/plumbing.dart';
import 'package:gm/globals.dart';
import 'package:pinput/pinput.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;


class MyOtp extends StatefulWidget {
  final String firstName;
  final String lastName;

  
  final String contactNo;
  final String address;
  final String password;
  final bool isLoading;
  
  const MyOtp({super.key , required this.firstName, required this.lastName, required this.contactNo, required this.address, required this.password,required this.isLoading});

/*  Widget _selectedCleaning({
required Color color,
required String title,
required String subtitle}){
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 10.0),
      padding:const  EdgeInsets.only(left: 20),
      height: 120,
      width: 240,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.0),
),
child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      title,style: const TextStyle( 
        fontSize: 22,
         color: Colors.white),
    ),
    const SizedBox(
      height: 5,
),
Text(subtitle, style: const TextStyle( 
        fontSize: 22,
         color: Colors.white)),

  ],
),
);
}*/

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  String phoneOtp="";

  void triggerUserRegistered(){
    setState(() {
      userRegistered=true;
    });
  }
  bool userRegistered=false;
  Future<void> validateOtp() async {
    var url = Uri.parse('http://$ip:5000/api/V1/system/validateOtp');
    var registerBody = {
      "phoneNumber":widget.contactNo,
      "userOtp":phoneOtp
    };   
    try {
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(registerBody));
      print(response); 
      if (response.statusCode == 200) { 
        print('POST request succeesful');
        registerUser();
      } else {
        print("Else part");
        print(response.body);
      }
    } catch (err) {
      print("Inside catch part");
      print(err);
    }
  }

  Future<void> registerUser() async {
    var url = Uri.parse('http://$ip:5000/api/V1/users/register');
    var registerBody = {
      "firstName":widget.firstName,
      "lastName":widget.lastName,
      "phoneNumber":widget.contactNo,
      "address":widget.address,
      "password":widget.password
    };   
    try {
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(registerBody));
      print(response); 
      if (response.statusCode == 201) { 
        print('POST request succeesful');
        print(response);
        triggerUserRegistered();
      } else {
        print("Else part");
        print(response.body);
      }
    } catch (err) {
      print("Inside catch part");
      print(err);
    }
  }

 // List<TextEditingController> otpContollers=[];
  @override

  Widget build(BuildContext context) {
 return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color.fromRGBO(25, 135, 84, 10),
        title:const Text(''),
      ),
      backgroundColor: const Color.fromRGBO(223,223,223, 10),
      body: Center(
        child:widget.isLoading?
        Text('is loading') : Container(
        margin: const EdgeInsets.only(left: 25,right: 25),
        alignment: Alignment.center,
        
        child: SingleChildScrollView(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const Text('OTP Verification',
               style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
              
              const  SizedBox(
                  height: 10,
                ),
              const Text('We need to register your phone before getting started!',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center),

              const SizedBox(
                height: 30,
              ),
              Pinput(
                onChanged: (value){
                  phoneOtp=value;
                },
                length: 6,
                 pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
              ),

             const SizedBox(
                height: 30,
                width: double.infinity,
              ),
              ElevatedButton(onPressed:(){
                validateOtp();
                if(userRegistered){
                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MyDash()),
                              );
                }
              },
              child: const Text('Confirm'),
              style: ElevatedButton.styleFrom(primary:const Color.fromRGBO(25, 135, 84, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7)
              )),
              )
              
              
            ],
          
          ),
        ),
      ),
      )
    );
  }
}

//DASHBOARD

class MyDash extends StatefulWidget {
  const MyDash({Key? key}) : super(key: key);

  @override
  State<MyDash> createState() => _MyDashState();
}

class _MyDashState extends State<MyDash> {
  get children => int;



/*Widget _selectedCleaning({0
required Color color,
required String title,
required String subtitle}){
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 10.0),
      padding:const  EdgeInsets.only(left: 20),
      height: 120,
      width: 240,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.0),
),
child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      title,style: const TextStyle( 
        fontSize: 22,
         color: Colors.white),
    ),
    const SizedBox(
      height: 5,
),
Text(subtitle, style: const TextStyle( 
        fontSize: 22,
         color: Colors.white)),

  ],
),
);
}*/
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
     
      
     body:ListView(
      
        children: <Widget>[
          _top(),
          const SizedBox(
            height: 20.0,
          ),
          const Padding(padding: EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Category",
              style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 22.0
              ),)

            ],
          ),),
         
          const SizedBox(
            height: 20.0,
               ),
          Container(
            height: 200.0,
            
            child: GridView(gridDelegate:
             const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3/2),
            children: <Widget>[
              IconButton( icon: _gridItem(Icons.plumbing,"Plumbing"),
                        onPressed: (){
                     Navigator.push(
                    context,MaterialPageRoute(builder: (context)=>const MyPlumber())
                  );
                }),
                IconButton( icon: _gridItem(Icons.cleaning_services,"Cleaning"),
                        onPressed: (){
                     Navigator.push(
                    context,MaterialPageRoute(builder: (context)=>const MyClean())
                  );
                }),
                IconButton( icon: _gridItem(Icons.electrical_services,"Electricity"),
                        onPressed: (){
                     Navigator.push(
                    context,MaterialPageRoute(builder: (context)=>const MyElectricity())
                  );
                }),
                IconButton( icon: _gridItem(Icons.brush_sharp,"Parlor"),
                        onPressed: (){
                     Navigator.push(
                    context,MaterialPageRoute(builder: (context)=>const MyPlumber())
                  );
                }),
                IconButton( icon: _gridItem(Icons.car_repair,"Mechanic"),
                        onPressed: (){
                     Navigator.push(
                    context,MaterialPageRoute(builder: (context)=>const MyPlumber())
                  );
                }),
                IconButton( icon: _gridItem(Icons.format_paint_rounded,"Paint"),
                        onPressed: (){
                     Navigator.push(
                    context,MaterialPageRoute(builder: (context)=>const MyPlumber())
                  );
                })
                ],)
          ),
         
            
          //..
          

          
          
         const Padding(padding: EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Text(
                "Latest",
                style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),
              )
            ],
          ),),
         _cardItem(1),
        // _cardItem(2),
        // _cardItem(3),


        ],
    ),
    );
  }
  //bottom
  _cardItem(image)
  {
    return Padding(padding:const EdgeInsets.all(16.0),
    child: Row(children: <Widget>[
      Container(
        width: 100.0,
        height: 100.0,
        decoration:const  BoxDecoration(
          image: DecorationImage(image:NetworkImage('assets/carp.jpg',))
        ),
        
      ),
     const SizedBox(
        height: 20.0,
      ),
     const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Electricity fix',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),),
          SizedBox(
            height:10.0 ,
          ),
         Text(
          'get 15% off',
          style: TextStyle(
            color:Colors.red,
            fontWeight: FontWeight.bold,
          ),
         ),
        ],
    
      ),
    ]),);
  }
  _gridItem(icon,text)
  {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: const Color.fromRGBO(25, 135, 84, 10),
          child: Icon(
            icon,size: 25.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(height:10.0),
         Text(
          text,
          style:const TextStyle(
            fontSize: 16.0,

          ),
        )
      ],
    );
  }
//top
  _top(){
    
    return Container(
      
      padding: const EdgeInsets.all(20.0),
      decoration:const  BoxDecoration(
        color: const Color.fromRGBO(25, 135, 84, 10),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
               )
     ),
child:  Column(children: <Widget>[
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
 const  Row(children: <Widget>[
  
    CircleAvatar(
      backgroundImage: AssetImage("assets/profile.jpg"),
    
    ),
    SizedBox(
    width: 20.0,
    ),
    
    
    Text("HI!! WELCOME ",style: TextStyle(color: Colors.white),),
  ],),

  IconButton(onPressed: (){},
   icon:const  Icon(
    Icons.notifications, color:Colors.white,
  ),),],),
 const SizedBox(height: 30.0),
  TextField(
    decoration: InputDecoration(
      hintText: "Search",
      fillColor: Colors.white,
      filled:true,
      suffixIcon: const Icon(Icons.filter_list),
      enabledBorder: OutlineInputBorder(
       borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(color:Colors.transparent),
      ),
      contentPadding:const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0)

    ),
  )
],
),
);
}
}


