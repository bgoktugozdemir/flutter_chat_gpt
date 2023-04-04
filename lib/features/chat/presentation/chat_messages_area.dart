import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_gpt/features/chat/presentation/chat_bubble.dart';
import 'package:flutter_chat_gpt/features/chat/presentation/cubit/chat_cubit.dart';

class ChatMessagesArea extends StatefulWidget {
  const ChatMessagesArea({Key? key}) : super(key: key);

  @override
  State<ChatMessagesArea> createState() => _ChatMessagesAreaState();
}

class _ChatMessagesAreaState extends State<ChatMessagesArea> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (previous, current) =>
          !previous.messages.equals(current.messages),
      builder: (context, state) {
        final messages = state.messages;

        return ListView.builder(
          reverse: true,
          controller: scrollController,
          padding: const EdgeInsets.all(8),
          itemCount: messages.length,
          itemBuilder: (context, index) => ChatBubble(
            message: messages[index],
          ),
        );
      },
    );
  }
}
