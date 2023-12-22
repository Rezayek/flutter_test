import 'package:cloud_firestore/cloud_firestore.dart';

class ChatData {
  final String id;
  final String senderId;
  final String recieverId;
  final String message;


  ChatData(
      {required this.id,
      required this.senderId,
      required this.recieverId,
      required this.message,
      });

  ChatData.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        senderId = snapshot.get('sender_id'),
        recieverId = snapshot.get('reciever_id'),
        message = snapshot.get('message');
}