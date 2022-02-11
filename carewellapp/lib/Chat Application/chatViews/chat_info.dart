import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatInformation extends StatefulWidget {
  @override
  _ChatInformationState createState() => _ChatInformationState();
}

class _ChatInformationState extends State<ChatInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Chats').snapshots();

  @override
  Widget build(BuildContext context) {
    //How to get a text field at the bottom of this

    TextEditingController messageTextEditingController =
        new TextEditingController();

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView(
                  shrinkWrap: true,
                  // physics: ScrollPhysics(),
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['message']),
                      // subtitle: Text(data['username']),
                    );
                  }).toList(),
                );
              },
            ),
            TextField(
              controller: messageTextEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a message',
              ),
            ),
            FloatingActionButton(
              child: const Icon(
                Icons.arrow_right_rounded,
                size: 50,
              ),
              onPressed: () {
                String message = messageTextEditingController.text.trim();

                if (message.isEmpty) {
                  print("Message is empty");
                } else {
                  FirebaseFirestore.instance
                      .collection('Chats')
                      .add({'message': message});
                  messageTextEditingController.clear();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}


/*
 FloatingActionButton(
                child: const Icon(Icons.search),
                onPressed: () {
                  final String message =
                      messageTextEditingController.text.trim();

                  if (message.isEmpty) {
                    print("Message is empty");
                  } else {
                    FirebaseFirestore.instance
                        .collection('Chats')
                        .add({'message': message});
                  }
                },
              ),
*/