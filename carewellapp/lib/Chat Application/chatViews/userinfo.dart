import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  //BELOW STREAM CREATES A WORKING STREAM OF USERNAMES. ALL WE NEED TO DO IS PUT A TEXTFIELD UNDER IT AND
  //INSTEAD OF DISPLAYING THE CHAT DOCUMENT WE SHOULD DISPLAY THE MESSAGES IN THE CHAT.
  //BELOW THE LIST VIEW SHOULD BE A TEXTFIELD INTO WHICH THE USER CAN INPUT A TEXTEDITING CONTROLLER THAT GETS UPDATED TO THE CHATS
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['username']),
                // subtitle: Text(data['username']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
