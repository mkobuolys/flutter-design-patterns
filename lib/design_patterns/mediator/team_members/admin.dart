import '../team_member.dart';

class Admin extends TeamMember {
  Admin({
    required super.name,
  });

  @override
  String toString() {
    return "$name (Admin)";
  }
}
