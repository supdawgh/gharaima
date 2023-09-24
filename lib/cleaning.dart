import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gm/profile.dart';

class MyClean extends StatefulWidget {
  const MyClean({Key? key}) : super(key: key);

  @override
  State<MyClean> createState() => _MyCleanState();
}

class _MyCleanState extends State<MyClean> {
  List<String> names = [
    'Hari Bahadur',
    'Jad Talyor',
    'Kasi Shrestha',
    'Futle Singh',
    'Hero Lal',
    'Landon Mcbroom',
    'Cole Spouse'
  ];
  List<String> locations = [
    'Pokhara',
    'Sankhamul',
    'Premiun',
    'Kohalpur',
    'Humla',
    'Jumla',
    'Hngk'
  ];
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
            itemCount: 7,
            shrinkWrap: true,
            itemBuilder: (context, int index) => Container(
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
                                  Text(names[index],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold)),
                                  Text(locations[index],
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
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyProfile()));
                              },
                              color: Colors.red,
                              icon: const Icon(Icons.arrow_forward),
                            ),
                            // child:const Text('Hire',style: TextStyle(color:Colors.white),),
                          ),
                        ],
                      )),
                )),
          ),
        ]));
  }
}
/*body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context,index){
          final user = users[index];
          final name=user ['name']['first']['last'];
          final address =user ['address'];
        // final imageUrl =user ['picture']['thumbnail'];

          return ListTile(
            leading:CircleAvatar(child: Text('${index+1}'),),
           
            title:Text(name),
            subtitle: Text(address),
          );
         },*/
            /*
           Container(
             padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                    right: 50,
                    left: 50),
                    child: Column(children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                            onChanged: (value) {
                            },
                          decoration: InputDecoration(
                              fillColor: Colors.grey[217],
                              filled: true,
                              hintText: "Full Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      ),]
           ) 
          
        ],
      )),
       Container(
             padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    right: 50,
                    left: 50),
                    child: Column(children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                            onChanged: (value) {
                            },
                          decoration: InputDecoration(
                              fillColor: Colors.grey[217],
                              filled: true,
                              hintText: "Address",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      ),]
                      
           ) 
          
        ],
      )),*/