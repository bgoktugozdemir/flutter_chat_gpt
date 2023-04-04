import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_chat_gpt/constants.dart';
import 'package:flutter_chat_gpt/features/chat/domain/models/chat_message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState.initial());

  final ChatGPT _chatGPT = ChatGPT.instance.builder(
    Constants.apiToken,
    baseOption: HttpSetup(receiveTimeout: 10000),
  );

  Future<void> sendMessage(String text) async {
    final formattedText = text.trim();
    final currentMessages = state.messages;

    final userMessage = ChatMessage(
      text: formattedText,
      type: ChatMessageType.user,
      status: ChatMessageStatus.inProgress,
    );

    emit(
      state.copyWith(
        messages: [
          userMessage,
          ...currentMessages,
        ],
        status: ChatStatus.loading,
      ),
    );

    CompleteRes? response;

    try {
      response = await _chatGPT.onCompleteText(
        request: CompleteReq(
          prompt: formattedText,
          model: kTranslateModelV3,
          // temperature: 0.64,
          // max_tokens: 256,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }

    if (response != null) {
      final aiMessage = ChatMessage(
        text: response.choices.last.text.trim(),
        type: ChatMessageType.ai,
      );

      emit(
        state.copyWith(
          messages: [
            aiMessage,
            userMessage.copyWith(status: ChatMessageStatus.completed),
            ...currentMessages,
          ],
          status: ChatStatus.success,
        ),
      );
    } else {
      emit(
        state.copyWith(
          messages: [
            userMessage.copyWith(status: ChatMessageStatus.failed),
            ...currentMessages,
          ],
          status: ChatStatus.failure,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    _chatGPT.close();
    await super.close();
  }
}
