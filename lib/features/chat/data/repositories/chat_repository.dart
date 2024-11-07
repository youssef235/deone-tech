import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasq_tech/web_services/web_services.dart';

import '../model/chat_response.dart';

abstract class ChatRepository {
  Stream <QuerySnapshot> getMessages (int uId,int tId,int pId);
  Future<void>sendMessage(String message,String type,int uId,int tId,int pId);
  Future<void> uploadImage(int uId,int tId,int pId,XFile pickedImg);
  Future<void> sendNotification(String? fcmToken,String? sender,String message );

}

class ChatRepositoryImpl implements ChatRepository {

  Future<void>sendMessage(String message,String type,int uId,int tId,int pId) async
  {
    final Timestamp timestamp = Timestamp.now();
    Messages newMessage =Messages(message: message,type:  type,timestamp: timestamp,sender:"tech");
    List<int> ids = [uId, tId,pId];
    ids.sort();
    String chatRoomId = ids.join("_");

      print("chatRoom id from send $chatRoomId");
      await FirebaseFirestore.instance
      .collection('chat rooms')
      .doc (chatRoomId)
      .collection('messages')
      .add(newMessage.toJson());

  }

  @override
  Stream <QuerySnapshot> getMessages (int uId,int tId,int pId) {
    List<int> ids = [uId, tId,pId];
    ids.sort();
    
    String chatRoomId = ids.join("_");
    print("chatRoom id $chatRoomId");

     return FirebaseFirestore.instance
        .collection('chat rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true).snapshots();
  }




  @override
  Future<void> sendNotification(String? fcmToken,String? sender,String message ) async {
    try {
      // Define the FCM API URL
      final apiUrl = 'https://fcm.googleapis.com/fcm/send';

      // Define your FCM server key (You should replace 'YOUR_SERVER_KEY' with your actual server key)
      final serverKey = 'AAAAAOa6i7U:APA91bEHsZkDGXaT_33p7sBisHM4k1Y_gwje_QT0zNJUMKUuCoFnU9M4koJM1E9m7SINbuM2cJW8YbtUnrJe5F-NYhnHZQGjPgJBc-P3O9UJZfw9gebYr5YKOee1RPjk1xa9h1bltsbK';

      // Create a Dio instance with the necessary headers
      final dio = Dio(BaseOptions(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey', // Add the server key here
        },
      ));

      // Create the FCM message payload
      final data = {
        'registration_ids': [fcmToken],
        'notification': {
          'title': 'ارسل اليك ${sender} رسالة جديدة',
          'body': message,
        },
      };

      // Send the POST request to the FCM API
      final response = await dio.post(apiUrl, data: data);

      if (response.statusCode == 200) {
        print('FCM message sent successfully');
      } else {
        print('Failed to send FCM message. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> uploadImage(int uId,int tId,int pId,XFile pickedImg)async {
    File img = File(pickedImg.path);
    List<int> ids = [uId, tId,pId];
    ids.sort();
    String chatRoomId = ids.join("_");
    await FirebaseStorage.instance
        .ref()
        .child('chats/$chatRoomId/${DateTime.now().toString()}${Uri
        .file(img.path)
        .pathSegments
        .last}')
        .putFile(img).then((p0) {
          p0.ref.getDownloadURL().then((value) {
            sendMessage(value, "image", uId, tId, pId);
          });
    });
  }

}

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepositoryImpl();
});
