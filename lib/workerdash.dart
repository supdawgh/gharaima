// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//http://192.168.1.75:5000/api/V1/worker/number/9808185333

import 'package:flutter/material.dart';
import 'package:gm/globals.dart';
import 'package:gm/login.dart';
import 'package:http/http.dart' as http;


class MyWorkerDash extends StatefulWidget {
  String contactNo;
   MyWorkerDash({super.key,required this.contactNo});

  @override
  State<MyWorkerDash> createState() => _MyWorkerDashState();
}

class _MyWorkerDashState extends State<MyWorkerDash> {
  Future<void> sendOtp() async {

    var contactNo=widget.contactNo;
    print(contactNo);
    var url = Uri.parse('http://$ip:5000/api/V1/worker/number/$contactNo');
    
    try {
      var response = await http.get(url);
     if (response.statusCode == 200) {
        print('POST request succeesful');
        print(response.body);
      } else {
        print("Else part");
        print(response.body);
      }
    } catch (err) {
      print("Inside catch part");
      print(err);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView(
         children: <Widget>[
          _top(),
          const  SizedBox(
            height: 20.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding:const EdgeInsets.symmetric(vertical:10.0,horizontal: 20.0), 
            //padding: EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Updates:",
              style: TextStyle(
                fontWeight: FontWeight.bold,fontSize: 22.0
              ),),

            ],
          ),
        ),
        const SizedBox(height: 10.0,
        ),
        Container(
           width: MediaQuery.of(context).size.width,
           padding:const EdgeInsets.symmetric(vertical:20.0,horizontal: 30.0),  
          child:
          Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: 
             Container(
            padding:const EdgeInsets.all(20.0),
            height: 130.0,
            decoration: BoxDecoration(
            color:  Colors.white,
              boxShadow: [
               BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0,3),
              )
            ]
          ),            child:const Column(
              children: [
                Text('Requests',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                SizedBox(height: 15.0,),
                Text('3',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),

              ]
            ),
            
          )
        ),
       const SizedBox(width: 30.0,),
       Expanded(
        child: 
         Container(
          padding: const EdgeInsets.all(20.0),
          height: 130.0,
          decoration: BoxDecoration(
            color:  Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0,3),
              )
            ]
          ),
          child: const Column(
            children: [
              Text('Work Done',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
              SizedBox(height: 15.0,),
              Text('1',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),

            ],
          ),
        )
      )

      ],
    ),),

              Container(
                         width: MediaQuery.of(context).size.width,
                         padding:const EdgeInsets.symmetric(vertical:30.0),  
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget>[
                                  Text('Reviews:',
                                    style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold)),
                                    
                                   const SizedBox(height:10.0),
                                    Container(
                                      width: 400.0,
                                      height: 100.0,
                                      color: const Color.fromARGB(255, 214, 213, 213),
                                      child: Container(
                                        margin: EdgeInsets.all(10.0),
                                        padding: EdgeInsets.all(10.0),
                                         child: Column(
                                          crossAxisAlignment:CrossAxisAlignment.center,
                                          mainAxisAlignment:MainAxisAlignment.start,
                                            children:const <Widget>[
                                            Text('so far so good'),
                                          ]
                                        ),
                                      ),
                                ),
                                ]
                                )
                              ]
                           )
              )
         ]
      )
    );
     
           
  }
  _top()
  {
    return Container(
      
      padding: const EdgeInsets.all(20.0),
      decoration:const  BoxDecoration(
        color: const Color.fromRGBO(25, 135, 84, 10),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
               )
     ),
child:  Column(
  children: <Widget>[
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
   Row(children: <Widget>[
  
     PopupMenuButton<String>(
                    offset: Offset(0, 40),
                    icon:  Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    onSelected: (value) {
                      if (value == 'logout') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => MyLogin2(
                                    firstName: 'firstName',
                                    lastName: '',
                                    contactNo: '',
                                    address: '',
                                    password: password))));
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'logout',
                        child: Text(
                          'Logout',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
    SizedBox(
    width: 20.0,
    ),
     Text("HI!! WELCOME BACK",style: TextStyle(color: Colors.white),),
  ],),

  IconButton(onPressed: (){
    //notification aune banaune
  },
   icon:const  Icon(
    Icons.notifications, 
    color:Colors.white,
  ),),],),
 const SizedBox(
  height: 30.0),
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
     // contentPadding:const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0)

    ),
  )
  
],
),
);
}
}
//REVIEW AND COST
class MyCost extends StatefulWidget {
  const MyCost({super.key});

  @override
  State<MyCost> createState() => _MyCostState();
}

class _MyCostState extends State<MyCost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  const Color.fromRGBO(25, 135, 84, 10),
      ),
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical:75.0,horizontal: 50.0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start ,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Offer Your Fare : NPR',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 20.0,),
                      TextFormField(
                        maxLines: 2,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:Color.fromARGB(255, 214, 213, 213),
                          hintText: "Enter Cost!",
                          contentPadding: EdgeInsets.all(20.0),
                          
                        ),
                      )
                      
                    ],
                
                  ),
                ),
                 const SizedBox(width: 15.0,),
                Positioned(
                  right: 10,
                  top: 50,
                    child: ElevatedButton(
                      onPressed: (){},
                       child: Text('Bid the price'),
                    style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(25, 135, 84, 10)),
               
              ) )
               
              ],
           ),
          )
        ],
      ),
    );
  }
}