import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gm/profile.dart';
import 'package:http/http.dart' as http;
import 'package:gm/globals.dart';
import 'dart:convert';


class MyClean extends StatefulWidget {
  
  String id;

  MyClean({Key? key, required this.id}) : super(key: key);

  @override
  State<MyClean> createState() => _MyCleanState();
}

class _MyCleanState extends State<MyClean> {
  List<Map<String,dynamic>> data=[];
  @override
  void initState()
  {
    super.initState();
    getCleaners().then((result) {
      setState(() {
        data=result;
      });
    });
  }
  Future<List<Map<String, dynamic>>> getCleaners() async {
    var url = Uri.parse('http://$ip:5000/api/V1/worker/category?category=cleaner');
    try {
      var response = await http.get(url);
          
      print(response);
      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data= jsonDecode(response.body)['workers'];
        List<Map<String,dynamic>>result=List<Map<String,dynamic>>.from(data);
        return result;
       } 
       else {
        print("First else part");
       throw Exception('Failed to load data');
        
      }
    } catch (err) {
      print("Second else part");
      throw Exception('Failed to load data');

    }
  }
  
  List<String> imageUrls = [
    'https://randomuser.me/api/portraits/med/men/41.jpg',
    'https://randomuser.me/api/portraits/med/men/55.jpg',
    'https://randomuser.me/api/portraits/med/men/41.jpg',
    'https://randomuser.me/api/portraits/med/men/25.jpg',
    'https://randomuser.me/api/portraits/med/men/55.jpg',
    'https://randomuser.me/api/portraits/med/women/44.jpg',
    'https://randomuser.me/api/portraits/med/men/75.jpg',
  ];

  //String imageUrl='https://randomuser.me/api/portraits/med/women/71.jpg''https://randomuser.me/api/portraits/med/women/26.jpg''https://randomuser.me/api/portraits/med/men/41.jpg'
  // 'https://randomuser.me/api/portraits/med/men/25.jpg''https://randomuser.me/api/portraits/med/men/55.jpg''https://randomuser.me/api/portraits/med/women/44.jpg''https://randomuser.me/api/portraits/med/men/75.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(25, 135, 84, 10),
          elevation: 0,
        ),
        body: ListView(children: <Widget>[
          //  _top(),
          const SizedBox(
            height: 20.0,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Cleaning',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('List of Cleaners Available!!',
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
          const Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Profiles",
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  )
                ],
              )),
          ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            itemBuilder: (context, int index) {
              final item=data[index];
              return Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 55.0,
                                height: 55.0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.green,
                                  backgroundImage:
                                      NetworkImage(imageUrls[index]),
                                  //Image(image: Image.asset(imageUrl).image),
                                  //Image.network(imageUrl),
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children:[
                                  Text(item['firstName'],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold)),
                                        const SizedBox(width: 5.0,),
                                  Text(item['lastName'],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold))]),
                                  Text(item['address'],
                                      style:
                                        const TextStyle(color: Colors.grey)),

                                  RatingBar.builder(
                                    initialRating: 5,
                                    minRating: 1,
                                    maxRating: 5,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 12.0,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Color.fromRGBO(25, 135, 84, 10),
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 10.0,
                            ),
                            child: IconButton(
                              onPressed: ()
                               {
                                widget.id=item['_id'];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MyProfile(
                                              id:widget.id
                                            )));
                              },
                              color: Colors.red,
                              icon: const Icon(Icons.arrow_forward),
                            ),
                            // child:const Text('Hire',style: TextStyle(color:Colors.white),),
                          ),
                        ],
                      )),
                )
              );
            }
            
          ),
        ]
      )
    );
  }
}
