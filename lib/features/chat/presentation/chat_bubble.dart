import 'package:flutter/material.dart';
import 'package:flutter_chat_gpt/core/presentation/app_colors.dart';
import 'package:flutter_chat_gpt/features/chat/domain/models/chat_message.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8).add(margin),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          if (message.status == ChatMessageStatus.failed)
            const Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
          Flexible(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: backgroundColor.withOpacity(opacity),
                borderRadius: borderRadius,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  message.text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: textColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BorderRadiusGeometry get borderRadius => message.type == ChatMessageType.ai
      ? const BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(12),
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        )
      : const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(0),
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        );

  MainAxisAlignment get mainAxisAlignment => message.type == ChatMessageType.ai
      ? MainAxisAlignment.start
      : MainAxisAlignment.end;

  EdgeInsetsGeometry get margin => message.type == ChatMessageType.ai
      ? const EdgeInsets.only(right: 48)
      : const EdgeInsets.only(left: 48);

  Color get backgroundColor => message.type == ChatMessageType.ai
      ? AppColors.aiBubble
      : AppColors.userBubble;

  Color get textColor =>
      message.type == ChatMessageType.ai ? Colors.black : Colors.white;

  double get opacity => message.status == ChatMessageStatus.completed
      ? 1
      : message.status == ChatMessageStatus.inProgress
          ? 0.4
          : 0.6;
}
