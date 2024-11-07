


import 'package:cloud_firestore/cloud_firestore.dart';

class Messages{
  String message;
  String sender;
  String type;
  Timestamp timestamp;



  Messages({required this.message,required this.timestamp,required this.sender, required this.type});

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
    message: json["message"],
    timestamp: json["timestamp"],
    sender: json["sender"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "timestamp": timestamp,
    "sender": sender,
    "type": type,
  };
}