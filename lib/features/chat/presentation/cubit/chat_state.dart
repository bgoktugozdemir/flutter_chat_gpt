part of 'chat_cubit.dart';

enum ChatStatus { initial, loading, success, failure }

class ChatState extends Equatable {
  const ChatState({
    required this.messages,
    required this.status,
  });

  factory ChatState.initial() => const ChatState(
        messages: [],
        status: ChatStatus.initial,
      );

  final List<ChatMessage> messages;
  final ChatStatus status;

  @override
  List<Object> get props => [messages, status];

  ChatState copyWith({
    List<ChatMessage>? messages,
    ChatStatus? status,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
    );
  }
}
