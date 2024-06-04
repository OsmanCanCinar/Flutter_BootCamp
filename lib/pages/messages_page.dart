import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skeleton/models/message.dart';
import 'package:flutter_skeleton/repositories/new_message_count_repository.dart';

import '../repositories/messages_repository.dart';

class MessagesPage extends ConsumerStatefulWidget {
  final String title;

  const MessagesPage({super.key, required this.title});

  @override
  ConsumerState<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends ConsumerState<MessagesPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then(
        (value) => ref.read(newMessageCountProvider.notifier).resetCount());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(messagesProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: repository.messages.length,
              itemBuilder: (context, index) {
                // bool isCurrentUser = Random().nextBool();
                // return MessagesWidget(isCurrentUser: isCurrentUser);
                if (index > repository.messages.length) {
                  return null;
                }
                return MessagesWidget(repository
                    .messages[repository.messages.length - index - 1]);
              },
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(border: Border.all()),
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      )),
                )),
                Padding(
                  padding: const EdgeInsets.only(right: 1.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.send),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessagesWidget extends StatelessWidget {
  final Message message;

  // final bool isCurrentUser;

  const MessagesWidget(
    this.message, {
    super.key,
    // required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      // alignment: isCurrentUser
      alignment: message.sender == 'John'
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.orange.shade300,
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: false ? const Text('dummy text') : Text(message.message),
          ),
        ),
      ),
    );
  }
}
