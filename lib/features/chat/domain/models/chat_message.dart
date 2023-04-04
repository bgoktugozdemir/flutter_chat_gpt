import 'package:equatable/equatable.dart';

enum ChatMessageType { ai, user }

enum ChatMessageStatus { completed, inProgress, failed }

class ChatMessage extends Equatable {
  const ChatMessage({
    required this.text,
    required this.type,
    this.status = ChatMessageStatus.completed,
  });

  final String text;
  final ChatMessageType type;
  final ChatMessageStatus status;

  @override
  List<Object> get props => [text, type, status];

  ChatMessage copyWith({
    String? text,
    ChatMessageType? type,
    ChatMessageStatus? status,
  }) {
    return ChatMessage(
      text: text ?? this.text,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }
}
