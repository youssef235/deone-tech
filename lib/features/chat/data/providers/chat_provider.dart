import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../repositories/chat_repository.dart';
import '../states/chat_state.dart';


class ChatNotifierProvider extends StateNotifier<ChatState> {
  ChatNotifierProvider(this.notificationsRepository) : super(const ChatState());

  final ChatRepository notificationsRepository;
  Stream <QuerySnapshot> getMessages (int uId,int tId,int pId) {
    try {
      var messages =  notificationsRepository.getMessages(uId, tId, pId);
      print("messages $messages");
      return messages;
    } catch (e) {
      state = state.copyWith(loading: false, errorMessage: e.toString());
      return const Stream.empty();

    }
  }

  Future<void>sendMessage(String message,String type,int uId,int tId,int pId) async {
    try {
      await notificationsRepository.sendMessage(message,type, uId, tId, pId);

    } catch (e) {
      state = state.copyWith(loading: false, errorMessage: e.toString());
    }
  }

  sendNotification(String? fcmToken,String? sender,String message ) async {
    try {
      await notificationsRepository.sendNotification(fcmToken, sender, message);
    } catch (e) {
    }
  }

  Future<void> uploadImage(int uId,int tId,int pId,XFile pickedImg) async {
    try {
      await notificationsRepository.uploadImage(uId, tId, pId, pickedImg);
    } catch (e) {
      state = state.copyWith(loading: false, errorMessage: e.toString());
    }
  }

}

final chatNotifierProvider =
    StateNotifierProvider<ChatNotifierProvider, ChatState>((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);

  return ChatNotifierProvider(chatRepository);
});
