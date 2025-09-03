import 'enums.dart';

class Player {
  Player({required this.name});
  final String name;
  Role? role;
  String? word;
  bool eliminated = false;
}
