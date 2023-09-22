// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gm/chat.dart';
import 'package:gm/cleaning.dart';
import 'package:gm/plumbing.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                backgroundColor:  const Color.fromRGBO(25, 135, 84, 10),
           ),
           body: ListView(
            
            children: <Widget>[
              Padding(
                padding:EdgeInsets.all(50.0),
                
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Text('YOU HAVE HIRED',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),),
                     SizedBox(height:30.0),
                    CircleAvatar(
                      radius: 60.0,
                      backgroundImage: AssetImage('assets/dan.jpg'),
                    ),
                    SizedBox(height: 25.0,),
                    Text('Hari Bahadur',style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold),),
                    SizedBox(height: 13.0,),
                    Text('London',style: TextStyle(fontSize: 15.0,fontWeight:FontWeight.w400),),    
                      Container(
                         width: MediaQuery.of(context).size.width,
                         padding:const EdgeInsets.symmetric(vertical:30.0),  
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                             children: <Widget>[
                                  Text('Ratings & Reviews:',
                                    style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text('4.7',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                                    SizedBox(height: 10.0,),
                                    
                                    RatingBar.builder(
                                      initialRating: 3,
                                      minRating: 1,
                                      maxRating: 5,
                                      itemSize: 20.0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemPadding: EdgeInsets.symmetric(horizontal: 5.0),
                                      itemBuilder: (context,index)=> const Icon(Icons.star,
                                      color:Color.fromRGBO(25, 135, 84, 10)),
                                      onRatingUpdate: (rating){
                                        print(rating);
                                      },
                                    ),
                                    SizedBox(height:10.0),
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
                                   SizedBox(height: 40.0,),
                                   Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child:ElevatedButton(
                                              onPressed: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyClean()));
                                              },
                                              
                                            child: const Text('Unhire'),

                                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(7))
                                            ),
                                          )
                                        ),
                                          SizedBox(height: 10.0,
                                          width: 50.0,),
                                          Expanded(
                                            child:ElevatedButton(
                                              onPressed: (){
                                                Navigator.push(context,MaterialPageRoute(builder: (context)=>const MyChat()));
                                              },
                                              
                                            child: const Text('Chat'),

                                            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(25, 135, 84, 10),
                                            shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(7))),
                                          ))
                                        ],
                                      )
                                    ],
                                   )
                               ],
                          )
                       ]),
                       )
                     ],
              ),
             
            )
            
          ],
       )
     );
  }
}