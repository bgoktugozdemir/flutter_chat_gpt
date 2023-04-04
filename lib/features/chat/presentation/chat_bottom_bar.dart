import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_gpt/core/presentation/app_colors.dart';
import 'package:flutter_chat_gpt/features/chat/presentation/cubit/chat_cubit.dart';

class ChatBottomBar extends StatefulWidget {
  const ChatBottomBar({super.key});

  @override
  State<ChatBottomBar> createState() => _ChatBottomBarState();
}

class _ChatBottomBarState extends State<ChatBottomBar> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          _InputBar(
            onSubmitted: submit,
            controller: textController,
          ),
          _SendButton(
            onSubmitted: submit,
          ),
        ],
      ),
    );
  }

  void submit() {
    if (textController.text.isEmpty) {
      return;
    }

    context.read<ChatCubit>().sendMessage(textController.text);
    textController.clear();
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar({
    required this.controller,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.send,
        onSubmitted: (_) => onSubmitted(),
        autofocus: true,
        minLines: 1,
        maxLines: 2,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Bir şey sor...',
          hintStyle: const TextStyle(
            color: Colors.black87,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.inputBorderColor),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({
    required this.onSubmitted,
  });

  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(10),
        ),
        onPressed: state.status != ChatStatus.loading ? onSubmitted : null,
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(
            Icons.send,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
