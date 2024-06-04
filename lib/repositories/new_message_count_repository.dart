import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewMessageCount extends StateNotifier<int> {
  NewMessageCount(super.state);

  void resetCount() {
    state = 0;
  }
}

final newMessageCountProvider =
    StateNotifierProvider<NewMessageCount, int>((ref) {
  return NewMessageCount(4);
});
