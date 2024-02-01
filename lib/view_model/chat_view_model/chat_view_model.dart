import 'package:chat_app/model/message_model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatViewModel {
  // get instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance.currentUser!;

  // get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();

        // return user
        return user;
      }).toList();
    });
  }

  // send message
  Future<void> sendMessage(String reciverID, message) async {
    try {
      // get currrent user info
      final String currentUserId = _auth.uid.toString();
      final String currentUserEmail = _auth.email.toString();
      final Timestamp timestamp = Timestamp.now();

      // create a new message
      MessageModel newMessage = MessageModel(
          senderID: currentUserId,
          senderEmail: currentUserEmail,
          reciverID: reciverID,
          message: message,
          timestamp: timestamp);

      // construct chat room ID for the two users (sorted to ensure)
      List<String> ids = [currentUserId, reciverID];
      ids.sort();
      String chatRoomId = ids.join('_');

      // add new message to database
      await _firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .add(newMessage.toMap());
    } catch (error) {
      print(">>>>> error from adding new message");
    }
  }

  //get message
  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    // construct a chatroom ID for the two users
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
