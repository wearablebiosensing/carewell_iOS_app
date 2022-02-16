import 'package:carewellapp/Chat%20Application/chatViews/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ChatInformation extends StatefulWidget {
  @override
  _ChatInformationState createState() => _ChatInformationState();
}

class _ChatInformationState extends State<ChatInformation> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('Chats')
      .orderBy('time')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    //How to get a text field at the bottom of this

    TextEditingController messageTextEditingController =
        new TextEditingController();

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.825,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(children: [
                  messageStream(_usersStream),
                ]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: messageTextEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a message',
                    ),
                  ),
                ),
                SizedBox(
                  width: 25,
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
                      //new Timestamp.now();

                      FirebaseFirestore.instance.collection('Chats').add(
                          {'message': message, 'time': new Timestamp.now()});
                      messageTextEditingController.clear();
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

StreamBuilder<QuerySnapshot> messageStream(
    Stream<QuerySnapshot<Object?>> _usersStream) {
  return StreamBuilder<QuerySnapshot>(
    stream: _usersStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text("Loading");
      }

      return ListView(
        // padding: EdgeInsets.all(8.0),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          return ListTile(
            title: Text(data['message']),

            //  subtitle: Text(DateTime.parse(data['time'].toDate().toString())),

            subtitle: Text(data['time'].toDate().toString()),
          );
        }).toList(),
      );
    },
  );
}
