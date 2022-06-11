import '../team_member.dart';

class Developer extends TeamMember {
  Developer({
    required super.name,
  });

  @override
  String toString() {
    return "$name (Developer)";
  }
}
