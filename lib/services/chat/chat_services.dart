import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_application/models/message.dart';

import '../../lib.dart';

class ChatService {
  // get the instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user stream
  /*
  List<Map<String,dynamic>> = 
  [
    {
      'email': test@gmail.com,
      'id': ..
    },  
    {
     'email': mitch@gmail.com,
     'id': ..
    },
  ]
  */
  // get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // go through each individual user
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  // send message
  Future<void> sendMessage(String receiverID, message) async {
    // get the current user
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    // create a new message
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );
    // construct chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); // this will sort the ids in alphabetical order and ensure that they are unique for two users
    String chatRoomID = ids.join('_'); // creating unique id for both users

    // add new message to chat room database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // get messages
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    List<String> id = [userID, otherUserID];
    id.sort();
    String chatRoomID = id.join('_');
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  //
  Future<void> getChatRoom() async {
    CollectionReference<Map<String, dynamic>> collectionReference =
        _firestore.collection('chat_rooms');
    QuerySnapshot<Map<String, dynamic>>? querySnapshot =
        await collectionReference.get();
    List<dynamic> id = [];
    List<String> docId = [];
    querySnapshot.docs.forEach((element) {
      debugPrint("Data: ${element.data()['member']}");
      List<dynamic> member = element.data()['member'];
      // debugPrint('Member: $member');
      id = member
          .where((element) => element.toString() == _auth.currentUser!.uid)
          .toList();
      if (id.isEmpty) {
        docId.add(element.data()['id']);
      }
    });
    debugPrint('id: $docId');
    QuerySnapshot<Map<String, dynamic>> messages = await _firestore
        .collection('chat_rooms')
        .doc(docId[0])
        .collection('messages')
        .get();
    for (var element in messages.docs) {
      debugPrint('message: ${element.data()}');
    }
  }
}
