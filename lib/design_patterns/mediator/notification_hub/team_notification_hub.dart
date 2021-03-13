import '../notification_hub.dart';
import '../team_member.dart';

class TeamNotificationHub extends NotificationHub {
  final _teamMembers = <TeamMember>[];

  TeamNotificationHub({
    List<TeamMember>? members,
  }) {
    members?.forEach(register);
  }

  @override
  void register(TeamMember member) {
    member.notificationHub = this;

    _teamMembers.add(member);
  }

  @override
  void send(TeamMember sender, String message) {
    for (final member in _teamMembers) {
      member.receive(sender.toString(), message);
    }
  }

  @override
  void sendTo<T extends TeamMember>(TeamMember sender, String message) {
    for (final member in _teamMembers.whereType<T>()) {
      member.receive(sender.toString(), message);
    }
  }
}
