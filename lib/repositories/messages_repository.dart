import '../models/message.dart';

class MessagesRepository {
  final List<Message> messages = [
    Message(
      message: "Hi!",
      sender: "John",
      time: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    Message(
      message: "Hey there!",
      sender: "Kate",
      time: DateTime.now().subtract(const Duration(minutes: 4)),
    ),
    Message(
      message: "How you doing ?",
      sender: "John",
      time: DateTime.now().subtract(const Duration(minutes: 3)),
    ),
    Message(
      message: "I'm fine how about you ?",
      sender: "Kate",
      time: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
    Message(
      message: "I am doing well, wanna go for a walk ?",
      sender: "John",
      time: DateTime.now().subtract(const Duration(minutes: 1)),
    ),
    Message(
        message: "Sure, why not John.", sender: "Kate", time: DateTime.now()),
    Message(
        message: "I'll be ready in 15 mins.",
        sender: "Kate",
        time: DateTime.now()),
  ];

  int newMessageCount = 4;
}
