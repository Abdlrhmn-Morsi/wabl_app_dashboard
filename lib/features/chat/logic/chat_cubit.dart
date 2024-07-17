import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wabl_app_dashboard/core/helpers/app_helper_functions.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/helpers/app_cashed.dart';
import '../../../core/helpers/image_crop_config.dart';
import '../../../core/networking/api_result.dart';
import '../../../core/networking/error_handling/api_error_handler.dart';
import '../../auth/logic/auth_helper.dart';
import '../data/models/chat_request_body.dart';
import '../data/models/chat_response_body.dart';
import '../data/models/message_request_body.dart';
import '../data/models/message_response_body.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(const ChatState.initial());
  static ChatCubit get get => getIt();
  var chatCol = FirebaseFirestore.instance.collection('chats');
  //var chatMessagesCol =chatCol.doc().collection('messages');

  //!==================  select an image ==========================================
  //?=============================================================================

  File? messageImg;

  void clearMessageImg() {
    emit(const ChatState.initial());
    messageImg = null;
    emit(const ChatState.selectMessageImg());
  }

  Future<void> selectMessageImg() async {
    emit(const ChatState.initial());
    try {
      final pickedImg =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImg == null) return;
      File? theImg = File(pickedImg.path);
      File? newImg = await ImageCropHelper.cropImg(imageFile: theImg);
      messageImg = newImg;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    emit(const ChatState.selectMessageImg());
  }

//!===========================================================
  var messageTEC = TextEditingController();

  bool isSentActive = false;
  void getIsSentActive(bool value) {
    emit(const ChatState.initial());
    isSentActive = value;
    emit(const ChatState.sendActive());
  }

  ScrollController scrollController = ScrollController();

  //!

  String currentChatId = '';
  void getChatId({required String id}) {
    currentChatId = id;
  }

  Future<ApiResult<String>> checkIfChatExists({
    required String receiverId,
  }) async {
    try {
      var chatSnapshot = await chatCol
          .where('users', arrayContains: AuthHelper.userId())
          .get();

      String chatId = '';
      bool chatExists = false;

      for (var doc in chatSnapshot.docs) {
        List<dynamic> users = doc['users'];
        if (users.contains(receiverId)) {
          chatExists = true;
          chatId = doc.id;
          break;
        }
      }

      if (chatExists) {
        return ApiResult.success(chatId);
      } else {
        return await createNewChat(receiverId);
      }
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future<ApiResult<String>> createNewChat(String receiverId) async {
    try {
      var doc = chatCol.doc();
      var chatId = doc.id;
      var data = ChatRequestBody(
        id: chatId,
        users: [AuthHelper.userId(), receiverId],
        createdAt: FieldValue.serverTimestamp(),
      );
      await doc.set(data.toJson());
      return ApiResult.success(chatId);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  void initiateChat(String receiverId) async {
    emit(const ChatState.chatLoading());
    var result = await checkIfChatExists(receiverId: receiverId);
    result.when(
      success: (v) {
        getChatId(id: v);
        emit(ChatState.chatSuccess(v));
      },
      failure: (e) {
        emit(
          ChatState.chatError(
            message: e.apiErrorModel.message ?? "",
          ),
        );
      },
    );
  }

  Future<ApiResult> createNewMessage({
    required String receiverId,
  }) async {
    try {
      var messagesCol = chatCol.doc(currentChatId).collection('messages');
      var doc = messagesCol.doc();
      var messageId = doc.id;
      var data = MessageRequestBody(
        id: messageId,
        receiverId: receiverId,
        message: messageTEC.text,
        senderId: AuthHelper.userId(),
        createdAt: FieldValue.serverTimestamp(),
      );
      await doc.set(data.toJson());
      return const ApiResult.success('');
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Stream<List<MessageResponseBody>> getMessages(String chatId) {
    return chatCol
        .doc(chatId)
        .collection('messages')
        .orderBy('created_at', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => MessageResponseBody.fromDocument(doc))
              .toList(),
        );
  }

  Future<void> sendMessage({
    required String receiverId,
  }) async {
    if (isSentActive && currentChatId.isNotEmpty) {
      emit(const ChatState.sendLoading());
      var response = await createNewMessage(
        receiverId: receiverId,
      );
      response.when(
        success: (v) {
          messageTEC.clear();
          scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
          emit(ChatState.sendSuccess(v));
        },
        failure: (e) {
          AppHelperFunctions.unFocusKeyboard();
          emit(ChatState.sendError(message: e.apiErrorModel.message ?? ""));
        },
      );
    }
  }

//! get All Chat

  List<ChatResponseBody> chatList = [];
  bool isLoadingMore = false;
  bool isReachedEnd = false;
  DocumentSnapshot? lastDocument;
  int pageSize = 10;
  Future<ApiResult> getAllChats(bool isPagination) async {
    try {
      var data = chatCol
          .where(
            'users',
            arrayContains: AuthHelper.userId(),
          )
          .orderBy(
            'created_at',
            descending: true,
          )
          .limit(pageSize);
      if (lastDocument != null) {
        data = data.startAfterDocument(lastDocument!);
      }
      var response = await data.get();
      var docs = response.docs;
      if (response.docs.isNotEmpty) {
        lastDocument = response.docs.last;
      }
      isReachedEnd = isPagination && docs.length < pageSize;
      return ApiResult.success(docs);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future emitGetAllChats({
    bool isRefresh = false,
    bool isPagination = false,
  }) async {
    if (!isPagination && !AppCashe.isChatsCashed() || isRefresh) {
      emit(const ChatState.loading());
    }
    if (isPagination) {
      isLoadingMore = true;
      emit(const ChatState.pagination());
    }
    if (isRefresh) {
      chatList.clear();
      pageSize = 10;
      lastDocument = null;
      isLoadingMore = false;
      isReachedEnd = false;
    }
    if (!isPagination || !AppCashe.isChatsCashed() || isRefresh) {
      var response = await getAllChats(isPagination);
      response.when(
        success: (data) async {
          AppCashe.casheChats();
          //! get chats
          for (var chat in data) {
            var data = ChatResponseBody.fromDocument(chat);
            chatList.add(data);
          }

          //! get user data
          for (var chat in chatList) {
            chat.lastMessage = await getLatestMessage(chat.id);
            for (var user in chat.users) {
              if (user != AuthHelper.userId()) {
                var postOwner = await AuthHelper.currentUserData(
                  id: user,
                );
                chat.chatWith = ChatWith(
                  avatar: postOwner.avatar ?? "",
                  name: postOwner.name ?? "",
                );
              }
            }
          }

          isLoadingMore = false;
          emit(const ChatState.success(''));
        },
        failure: (error) {
          isLoadingMore = false;

          emit(
            ChatState.error(
              message: error.apiErrorModel.message ?? '',
            ),
          );
        },
      );
    }
  }

  Future<MessageResponseBody?> getLatestMessage(String chatId) async {
    var message = await chatCol
        .doc(chatId)
        .collection('messages')
        .orderBy('created_at', descending: true)
        .limit(1)
        .get();
    return message.docs.isNotEmpty
        ? MessageResponseBody.fromDocument(message.docs.first)
        : null;
  }

//! delete message
  Future<ApiResult> deleteMessage({required String messageId}) async {
    try {
      await chatCol
          .doc(currentChatId)
          .collection('messages')
          .doc(messageId)
          .update({
        'is_deleted': true,
      });
      return const ApiResult.success('');
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  Future emitDeleteMessage({required String messageId}) async {
    emit(const ChatState.deleteLoading());
    var response = await deleteMessage(messageId: messageId);
    response.when(
      success: (v) {
        emit(ChatState.deleteSuccess(v));
      },
      failure: (e) {
        emit(ChatState.deleteError(message: e.apiErrorModel.message ?? ""));
      },
    );
  }
}
