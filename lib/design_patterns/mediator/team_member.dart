import 'notification_hub.dart';

abstract class TeamMember {
  final String name;

  NotificationHub? notificationHub;
  String? lastNotification;

  TeamMember({
    required this.name,
  });

  void receive(String from, String message) {
    lastNotification = '$from: "$message"';
  }

  void send(String message) {
    notificationHub?.send(this, message);
  }

  void sendTo<T extends TeamMember>(String message) {
    notificationHub?.sendTo<T>(this, message);
  }
}
