import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_gpt/features/chat/presentation/chat_bottom_bar.dart';
import 'package:flutter_chat_gpt/features/chat/presentation/chat_messages_area.dart';
import 'package:flutter_chat_gpt/features/chat/presentation/cubit/chat_cubit.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ChatCubit chatCubit;

  @override
  void initState() {
    super.initState();
    chatCubit = ChatCubit();
  }

  @override
  void dispose() {
    chatCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: BlocProvider(
        create: (context) => ChatCubit(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Flutter ChatGPT'),
          ),
          body: SafeArea(
            child: Column(
              children: const [
                Expanded(
                  child: ChatMessagesArea(),
                ),
                ChatBottomBar()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
