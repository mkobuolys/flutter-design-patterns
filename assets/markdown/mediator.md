## Class diagram

![Mediator Class Diagram](resource:assets/images/mediator/mediator.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Mediator** design pattern:

![Mediator Implementation Class Diagram](resource:assets/images/mediator/mediator_implementation.png)

_TeamMember_ is an abstract class that is used as a base class for all the specific team member classes. The class contains _name_, _lastNotification_ and _notificationHub_ properties, provides several methods:

- _receive()_ - receives the notification from the notification hub;
- _send()_ - sends a notification;
- _sendTo\<T\>()_ - sends a notification to specific team members.

_Admin_, _Developer_ and _Tester_ are concrete team member classes that extend the abstract class _TeamMember_ as well as override the default _toString()_ method.

_NotificationHub_ is an abstract class that is used as a base class for all the specific notification hubs and defines several abstract methods:

- _getTeamMembers()_ - returns a list of team members of the hub;
- _register()_ - registers a team member to the hub;
- _send()_ - sends a notification to registered team members;
- _sendTo\<T\>()_ - sends a notification to specific registered team members.

_TeamNotificationHub_ is a concrete notification hub that extends the abstract class _NotificationHub_ and implements its abstract methods. Also, this class contain a list of registered team members - _teamMembers_.

_MediatorExample_ initialises and contains a notification hub property to send and receive notifications, register team members to the hub.

### TeamMember

An abstract class implementing base methods for all the specific team member classes. Method _receive()_ sets the _lastNotification_ value, _send()_ and _sendTo\<T\>()_ methods send notification by using the corresponding _notificationHub_ methods.

```
abstract class TeamMember {
  final String name;

  NotificationHub? notificationHub;
  String? lastNotification;

  TeamMember(this.name);

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

All of the specific team member classes extend the _TeamMember_ and override the default _toString()_ method.

- _Admin_ - a team member class representing the admin role.

```
class Admin extends TeamMember {
  Admin({
    required String name,
  }) : super(name);

  @override
  String toString() {
    return "$name (Admin)";
  }
}
```

- _Developer_ - a team member class representing the developer role.

```
class Developer extends TeamMember {
  Developer({
    required String name,
  }) : super(name);

  @override
  String toString() {
    return "$name (Developer)";
  }
}
```

- _Tester_ - a team member class representing the tester (QA) role.

```
class Tester extends TeamMember {
  Tester({
    required String name,
  }) : super(name);

  @override
  String toString() {
    return "$name (QA)";
  }
}
```

### NotificationHub

An abstract class that defines abstract methods to be implemented by specific notification hub classes. Method _getTeamMembers()_ returns a list of registered team members to the hub, _register()_ registers a new member to the hub. Method _send()_ sends the notification to all the registered team members to the hub (excluding sender) while _sendTo\<T\>()_ sends the notification to team members of a specific type (excluding sender).

```
abstract class NotificationHub {
  List<TeamMember> getTeamMembers();
  void register(TeamMember member);
  void send(TeamMember sender, String message);
  void sendTo<T extends TeamMember>(TeamMember sender, String message);
}
```

### TeamNotificationHub

A specific notification hub implementing abstract _NotificationHub_ methods. The class also contains private _teamMembers_ property - a list of registered team members to the hub.

```
class TeamNotificationHub extends NotificationHub {
  final _teamMembers = <TeamMember>[];

  TeamNotificationHub({
    List<TeamMember>? members,
  }) {
    members?.forEach(register);
  }

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

The _MediatorExample_ widget initialises the _TeamNotificationHub_ and later uses it to send notifications between team members.

Specific team members do not contain any reference about the others, they are completely decoupled. For communication, the notification hub is used that handles all the necessary logic to send and receive notifications from the team.

```
class MediatorExample extends StatefulWidget {
  @override
  _MediatorExampleState createState() => _MediatorExampleState();
}

class _MediatorExampleState extends State<MediatorExample> {
  late final NotificationHub _notificationHub;
  final _admin = Admin(name: 'God');

  @override
  void initState() {
    super.initState();

    final _members = [
      _admin,
      Developer(name: 'Sea Sharp'),
      Developer(name: 'Jan Assembler'),
      Developer(name: 'Dove Dart'),
      Tester(name: 'Cori Debugger'),
      Tester(name: 'Tania Mocha'),
    ];
    _notificationHub = TeamNotificationHub(members: _members);
  }

  void _sendToAll() {
    setState(() {
      _admin.send('Hello');
    });
  }

  void _sendToQa() {
    setState(() {
      _admin.sendTo<Tester>('BUG!');
    });
  }

  void _sendToDevelopers() {
    setState(() {
      _admin.sendTo<Developer>('Hello, World!');
    });
  }

  void _addTeamMember() {
    final name = '${faker.person.firstName()} ${faker.person.lastName()}';
    final teamMember = faker.randomGenerator.boolean()
        ? Tester(name: name)
        : Developer(name: name);

    setState(() {
      _notificationHub.register(teamMember);
    });
  }

  void _sendFromMember(TeamMember member) {
    setState(() {
      member.send('Hello from ${member.name}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
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
            const SizedBox(height: spaceL),
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
