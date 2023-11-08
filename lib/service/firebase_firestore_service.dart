import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../model/message.dart';
import '../model/user.dart';
import 'firebase_storage_service.dart';

class FirebaseFirestoreService {
  static final firestore = FirebaseFirestore.instance;

  static Future<void> addTextMessage({
    required String content,
    required String receiverId,
    required UserModel receiver,
  }) async {
    // final auth = ref.read(firebaseAuthProvider)
    final message = Message(
      content: content,
      sentTime: DateTime.now(),
      receiverId: receiverId,
      messageType: MessageType.text,
      senderId: FirebaseAuth.instance.currentUser!.uid,
    );
    await _addMessageToChat(receiverId, receiver, message);
  }

  static Future<String> saveUserImage({
    required Uint8List file,
  }) async {
    var user = FirebaseAuth.instance.currentUser!.uid;
    final image = await FirebaseStorageService.uploadImage(
        file, 'image/user/${user}');
    return image;
  }


  static Future<void> addImageMessage({
    required String receiverId,
    required UserModel receiver,
    required Uint8List file,
  }) async {
    final image = await FirebaseStorageService.uploadImage(
        file, 'image/chat/${DateTime.now()}');
    final message = Message(
      senderId: FirebaseAuth.instance.currentUser!.uid,
      receiverId: receiverId,
      content: image,
      sentTime: DateTime.now(),
      messageType: MessageType.image,
    );
    await _addMessageToChat(receiverId, receiver, message);
  }

  static Future<void> _addMessageToChat(
      String receiverId,
      UserModel receiver,
      Message message,
      ) async {
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
        .set(receiver.toJson());

    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .add(message.toJson());

    await firestore
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .add(message.toJson());
  }
}
