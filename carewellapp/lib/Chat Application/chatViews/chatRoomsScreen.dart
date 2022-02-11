import 'package:carewellapp/Chat%20Application/chatViews/search.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String name = "Not Working Yet";

class DatabaseService {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  //get the stream
  Stream<QuerySnapshot> get userCollection {
    return collection.snapshots();
  }
}

class CollectionList extends StatefulWidget {
  const CollectionList({Key? key}) : super(key: key);

  @override
  _CollectionListState createState() => _CollectionListState();
}

class _CollectionListState extends State<CollectionList> {
  @override
  Widget build(BuildContext context) {
    //final list = Provider.of<QuerySnapshot>(context);
    // for (var doc in list.docs) {
    //   print(doc.data);
    // }
    return Container();
  }
}

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  // AuthMethods authMethods = new AuthMethods();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>.value(
      initialData: null,
      value: DatabaseService().userCollection,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search"),
        ),
        body: CollectionList(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.search),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SearchScreen()));
          },
        ),
        // body: Container(
        //   child: Column(
        //     children: [Text(name)],
        //   ),
      ),
    );
  }
}
