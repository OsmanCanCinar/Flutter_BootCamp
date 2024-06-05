import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/messages_repository.dart';
import '../repositories/new_message_count_repository.dart';
import '../repositories/students_repository.dart';
import '../repositories/teachers_repository.dart';
import '../services/network_service.dart';

final studentsProvider = ChangeNotifierProvider((ref) {
  return StudentsRepository();
});

final teachersProvider = ChangeNotifierProvider((ref) {
  return TeachersRepository();
});

final messagesProvider = ChangeNotifierProvider((ref) {
  return MessagesRepository();
});

final newMessageCountProvider =
    StateNotifierProvider<NewMessageCount, int>((ref) {
  return NewMessageCount(4);
});

final networkServiceProvider = Provider<NetworkService>((ref) {
  return NetworkService();
});
