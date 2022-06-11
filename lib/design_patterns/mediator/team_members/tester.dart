import '../team_member.dart';

class Tester extends TeamMember {
  Tester({
    required super.name,
  });

  @override
  String toString() {
    return "$name (QA)";
  }
}
