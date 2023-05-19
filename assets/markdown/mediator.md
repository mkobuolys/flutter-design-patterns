## Class diagram

![Mediator Class Diagram](resource:assets/images/mediator/mediator.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Mediator** design pattern:

![Mediator Implementation Class Diagram](resource:assets/images/mediator/mediator_implementation.png)

`TeamMember` is a base class that is used by all the specific team member classes. The class contains `name`, `lastNotification` and `notificationHub` properties, provides several methods:

- `receive()` - receives the notification from the notification hub;
- `send()` - sends a notification;
- `sendTo<T>()` - sends a notification to specific team members.

`Admin`, `Developer` and `Tester` are concrete team member classes that extend the abstract class `TeamMember` as well as override the default `toString()` method.

`NotificationHub` defines an interface for all the specific notification hubs:

- `getTeamMembers()` - returns a list of team members of the hub;
- `register()` - registers a team member to the hub;
- `send()` - sends a notification to registered team members;
- `sendTo<T>()` - sends a notification to specific registered team members.

`TeamNotificationHub` is a concrete notification hub that implements the `NotificationHub` interface. Also, this class contain a list of registered team members - `teamMembers`.

`MediatorExample` initialises and contains a notification hub property to send and receive notifications, register team members to the hub.

### TeamMember

A base class implementing methods for all the specific team member classes. Method `receive()` sets the `lastNotification` value, `send()` and `sendTo<T>()` methods send notification by using the corresponding `notificationHub` methods.

```dart
base class TeamMember {
  TeamMember({
    required this.name,
  });

  final String name;

  NotificationHub? notificationHub;
  String? lastNotification;

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
```

### Concrete team member classes

All of the specific team member classes extend the `TeamMember` and override the default `toString()` method.

- `Admin` - a team member class representing the admin role.

```dart
final class Admin extends TeamMember {
  Admin({
    required super.name,
  });

  @override
  String toString() => '$name (Admin)';
}
```

- `Developer` - a team member class representing the developer role.

```dart
final class Developer extends TeamMember {
  Developer({
    required super.name,
  });

  @override
  String toString() => '$name (Developer)';
}
```

- `Tester` - a team member class representing the tester (QA) role.

```dart
final class Tester extends TeamMember {
  Tester({
    required super.name,
  });

  @override
  String toString() => '$name (QA)';
}
```

### NotificationHub

An abstract interface class that defines methods to be implemented by specific notification hub classes. Method `getTeamMembers()` returns a list of registered team members to the hub, `register()` registers a new member to the hub. Method `send()` sends the notification to all the registered team members to the hub (excluding sender) while `sendTo<T>()` sends the notification to team members of a specific type (excluding sender).

```dart
abstract interface class NotificationHub {
  List<TeamMember> getTeamMembers();
  void register(TeamMember member);
  void send(TeamMember sender, String message);
  void sendTo<T extends TeamMember>(TeamMember sender, String message);
}
```

### TeamNotificationHub

A specific notification hub implementing `NotificationHub` interface. The class also contains private `teamMembers` property - a list of registered team members to the hub.

```dart
class TeamNotificationHub implements NotificationHub {
  TeamNotificationHub({
    List<TeamMember>? members,
  }) {
    members?.forEach(register);
  }

  final _teamMembers = <TeamMember>[];

  @override
  List<TeamMember> getTeamMembers() => _teamMembers;

  @override
  void register(TeamMember member) {
    member.notificationHub = this;

    _teamMembers.add(member);
  }

  @override
  void send(TeamMember sender, String message) {
    final filteredMembers = _teamMembers.where((m) => m != sender);

    for (final member in filteredMembers) {
      member.receive(sender.toString(), message);
    }
  }

  @override
  void sendTo<T extends TeamMember>(TeamMember sender, String message) {
    final filteredMembers =
        _teamMembers.where((m) => m != sender).whereType<T>();

    for (final member in filteredMembers) {
      member.receive(sender.toString(), message);
    }
  }
}
```

### Example

The `MediatorExample` widget initialises the `TeamNotificationHub` and later uses it to send notifications between team members.

Specific team members do not contain any reference about the others, they are completely decoupled. For communication, the notification hub is used that handles all the necessary logic to send and receive notifications from the team.

```dart
class MediatorExample extends StatefulWidget {
  const MediatorExample();

  @override
  _MediatorExampleState createState() => _MediatorExampleState();
}

class _MediatorExampleState extends State<MediatorExample> {
  late final NotificationHub _notificationHub;
  final _admin = Admin(name: 'God');

  @override
  void initState() {
    super.initState();

    final members = [
      _admin,
      Developer(name: 'Sea Sharp'),
      Developer(name: 'Jan Assembler'),
      Developer(name: 'Dove Dart'),
      Tester(name: 'Cori Debugger'),
      Tester(name: 'Tania Mocha'),
    ];
    _notificationHub = TeamNotificationHub(members: members);
  }

  void _sendToAll() => setState(() => _admin.send('Hello'));

  void _sendToQa() => setState(() => _admin.sendTo<Tester>('BUG!'));

  void _sendToDevelopers() => setState(
        () => _admin.sendTo<Developer>('Hello, World!'),
      );

  void _addTeamMember() {
    final name = '${faker.person.firstName()} ${faker.person.lastName()}';
    final teamMember = faker.randomGenerator.boolean()
        ? Tester(name: name)
        : Developer(name: name);

    setState(() => _notificationHub.register(teamMember));
  }

  void _sendFromMember(TeamMember member) => setState(
        () => member.send('Hello from ${member.name}'),
      );

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingL,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            PlatformButton(
              text: "Admin: Send 'Hello' to all",
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _sendToAll,
            ),
            PlatformButton(
              text: "Admin: Send 'BUG!' to QA",
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _sendToQa,
            ),
            PlatformButton(
              text: "Admin: Send 'Hello, World!' to Developers",
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _sendToDevelopers,
            ),
            const Divider(),
            PlatformButton(
              text: "Add team member",
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _addTeamMember,
            ),
            const SizedBox(height: LayoutConstants.spaceL),
            NotificationList(
              members: _notificationHub.getTeamMembers(),
              onTap: _sendFromMember,
            ),
          ],
        ),
      ),
    );
  }
}
```
