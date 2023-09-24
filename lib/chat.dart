// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyChat extends StatefulWidget {
  const MyChat({super.key});

  @override
  State<MyChat> createState() => _MyChatState();
}

class _MyChatState extends State<MyChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
       body: const Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor:  const Color.fromRGBO(25, 135, 84, 10),
      title:const Row(
        children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/dan.jpg'),
        ),
        SizedBox(width: 15.0,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Daniel Ceaser',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16.0),),
            Text('active 3m ago',style: TextStyle(fontSize: 10.0),),
          ],
        )
       ]
     ), 
     actions: 
     [ 
      IconButton(onPressed: (){
        //get call
      }, icon: const Icon(Icons.local_phone),),
     const SizedBox(width: 17.0,),
     ],
    );
    
    
    
  }
}

/*enum ChatMessageType{text,video,audio}
// ignore: constant_identifier_names
enum MessageStatus{not_seen,not_viewed,viewed}

class ChatMessage{
  late final String text;
  late final ChatMessageType messageType;
  late final MessageStatus messageStatus;
  late final bool isSender;

  ChatMessage({
     required this.text,
     required this.messageType,
     required this.messageStatus,
     required this.isSender,
  });

  List demoChatMessage =[
      ChatMessage(text: 'heyyy', messageType: ChatMessageType.text, messageStatus: MessageStatus.viewed, isSender: false),
      ChatMessage(text: 'sup g', messageType: ChatMessageType.text, messageStatus: MessageStatus.viewed, isSender: true),
  ];
}*/
class Body extends StatelessWidget {
  const Body({super.key});
 //final List<ChatMessage> demoChatMessage;
 //const Body({required this.demoChatMessage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Expanded(child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child:
             Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),              
              child: Container(
                padding: EdgeInsets.all(12.0),
                margin: EdgeInsets.all(12.0),
                decoration:BoxDecoration(
                  color: const Color.fromRGBO(25, 135, 84, 10) ,
                  borderRadius:BorderRadius.circular(17.0),),
                child: Text('Left message',style: TextStyle(color: Colors.white),),
              ),
            )
            ),
           ],
         )
        ),  
         Expanded(child: Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.all(12.0),
                margin: EdgeInsets.all(12.0),

                decoration:BoxDecoration(
                  color: const Color.fromRGBO(25, 135, 84, 10) ,
                  borderRadius:BorderRadius.circular(17.0),),
                child: Text('Right message',style: TextStyle(color: Colors.white),),
              ),
            )),
       const ChatInputField(),
     ],  
    );
  }
}

/*class Message extends StatelessWidget {
  final ChatMessage message;

  const Message({
     required this.message,Key?key
  }): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Row(
     mainAxisAlignment: message.isSender?MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
        Container(
          padding:const  EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
          child: Text(message.text,style: const TextStyle(color: Colors.black),)),
      ],
    );
  }
}*/

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7.0,vertical: 7.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 226, 218, 218),
      ),
      child: SafeArea(
        child: Row(children: [
         const  Icon(Icons.mic,color: Colors.grey,),
          const SizedBox(width: 10.0,),
          Expanded(child:
           Container(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            height: 50,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),),
            child: const Row(
              children: [
              SizedBox(width:10.0),
              Expanded(child: 
               TextField(
                decoration: InputDecoration(
                  hintText: 'Type Message',
                  border:InputBorder.none,
                ),
              ),
            ),
             Icon(
                Icons.camera_alt_outlined,
                color: Colors.grey,),

          ]
        ),
      ),
    )
       ]),
    ),
   );
  }
}


