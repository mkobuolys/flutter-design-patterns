## Class diagram

![Facade Class Diagram](resource:assets/images/facade/facade.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of **Facade** design pattern.

![Facade Implementation Class Diagram](resource:assets/images/facade/facade_implementation.png)

There are several APIs provided to communicate with smart devices (turn them on and off): _AudioApi_, _CameraApi_, _PlaystationApi_, _SmartHomeApi_ and _TvApi_. _NetflixApi_ provides methods to connect to the Netflix platform, disconnect from it and play the selected movie.

APIs are used by the facade classes:

- _GamingFacade_ - uses the _PlaystationApi_ and _CameraApi_ and provides methods related to gaming and streaming actions;
- _SmartHomeFacade_ - uses the _AudioApi_, _CameraApi_, _SmartHomeApi_, _TvApi_ and _NetflixApi_. It provides methods for gaming, streaming actions (_GamingFacade_ is reused with some additional communication together with other smart devices) and actions related to playing a movie from the Netflix platform.

Both of the facades use the _SmartHomeState_ class to save the current state of smart devices.

_FacadeExample_ widget contains the _SmartHomeFacade_ to communicate with the smart devices using the provided action methods in the facade.

### APIs

- _AudioApi_ - an API to turn the smart speakers ON/OFF.

```
class AudioApi {
  const AudioApi();

  bool turnSpeakersOn() => true;

  bool turnSpeakersOff() => false;
}
```

- _CameraApi_ - an API to turn the streaming camera ON/OFF.

```
class CameraApi {
  const CameraApi();

  bool turnCameraOn() => true;

  bool turnCameraOff() => false;
}
```

- _NetflixApi_ - an API to connect to the Netflix platform, disconnect from it and play the movie.

```
class NetflixApi {
  const NetflixApi();

  bool connect() => true;

  bool disconnect() => false;

  void play(String title) {
    // ignore: avoid_print
    print("'$title' has started started playing on Netflix.");
  }
}
```

- _PlaystationApi_ - an API to turn the gaming console (PlayStation) ON/OFF.

```
class PlaystationApi {
  const PlaystationApi();

  bool turnOn() => true;

  bool turnOff() => false;
}
```

- _SmartHomeApi_ - an API to turn the smart lights ON/OFF.

```
class SmartHomeApi {
  const SmartHomeApi();

  bool turnLightsOn() => true;

  bool turnLightsOff() => false;
}
```

- _TvApi_ - an API to turn the smart TV ON/OFF.

```
class TvApi {
  const TvApi();

  bool turnOn() => true;

  bool turnOff() => false;
}
```

### SmartHomeState

A class which holds the current state of all the smart devices at home.

```
class SmartHomeState {
  bool tvOn = false;
  bool audioSystemOn = false;
  bool netflixConnected = false;
  bool gamingConsoleOn = false;
  bool streamingCameraOn = false;
  bool lightsOn = true;
}
```

### GamingFacade

A facade class which uses APIs of the PlayStation and streaming camera and provides simplified methods to use them:

- _startGaming()_ - uses the _PlaystationApi_ to turn the gaming console on;
- _stopGaming()_ - uses the _PlaystationApi_ to turn the gaming console off;
- _startStreaming()_ - uses the _CameraApi_ to turn the streaming camera on and calls the _startGaming_ method;
- _stopStreaming()_ - uses the _CameraApi_ to turn the streaming camera off and calls the _stopGaming_ method.

```
class GamingFacade {
  const GamingFacade({
    this.playstationApi = const PlaystationApi(),
    this.cameraApi = const CameraApi(),
  });

  final PlaystationApi playstationApi;
  final CameraApi cameraApi;

  void startGaming(SmartHomeState smartHomeState) {
    smartHomeState.gamingConsoleOn = playstationApi.turnOn();
  }

  void stopGaming(SmartHomeState smartHomeState) {
    smartHomeState.gamingConsoleOn = playstationApi.turnOff();
  }

  void startStreaming(SmartHomeState smartHomeState) {
    smartHomeState.streamingCameraOn = cameraApi.turnCameraOn();
    startGaming(smartHomeState);
  }

  void stopStreaming(SmartHomeState smartHomeState) {
    smartHomeState.streamingCameraOn = cameraApi.turnCameraOff();
    stopGaming(smartHomeState);
  }
}
```

### SmartHomeFacade

A facade class which uses APIs of the smart TV, audio devices, Netflix platform and smart home equipment. Also, _GamingFacade_ is used. Several methods are provided to simplify smart home actions:

- _startMovie()_ - uses several different APIs to turn off the lights, turn on the smart TV and speakers, connect to the Netflix platform and start playing the selected movie;
- _stopMovie()_ - uses several different APIs to disconnect from the Netflix, turn off the smart TV and speakers, also turns the lights back on;
- _startGaming()_ - uses the _SmartHomeApi_ to turn the lights off, turns the smart TV on via the _TvApi_ and calls the _GamingFacade_ to start the gaming session;
- _stopGaming()_ - uses the _GamingFacade_ to stop the gaming session, turns the smart TV off using the _TvApi_ and turns the lights back on via _SmartHomeApi_;
- _startStreaming()_ - uses the _SmartHomeApi_ to turn the lights on, turns the smart TV on via the _TvApi_ and calls the _GamingFacade_ to start the streaming session;
- _stopStreaming()_ - uses the _GamingFacade_ to stop the streaming session, turns the smart TV off using the _TvApi_ and turns the lights back on via _SmartHomeApi_.

```
class SmartHomeFacade {
  const SmartHomeFacade({
    this.gamingFacade = const GamingFacade(),
    this.tvApi = const TvApi(),
    this.audioApi = const AudioApi(),
    this.netflixApi = const NetflixApi(),
    this.smartHomeApi = const SmartHomeApi(),
  });

  final GamingFacade gamingFacade;
  final TvApi tvApi;
  final AudioApi audioApi;
  final NetflixApi netflixApi;
  final SmartHomeApi smartHomeApi;

  void startMovie(SmartHomeState smartHomeState, String movieTitle) {
    smartHomeState.lightsOn = smartHomeApi.turnLightsOff();
    smartHomeState.tvOn = tvApi.turnOn();
    smartHomeState.audioSystemOn = audioApi.turnSpeakersOn();
    smartHomeState.netflixConnected = netflixApi.connect();
    netflixApi.play(movieTitle);
  }

  void stopMovie(SmartHomeState smartHomeState) {
    smartHomeState.netflixConnected = netflixApi.disconnect();
    smartHomeState.tvOn = tvApi.turnOff();
    smartHomeState.audioSystemOn = audioApi.turnSpeakersOff();
    smartHomeState.lightsOn = smartHomeApi.turnLightsOn();
  }

  void startGaming(SmartHomeState smartHomeState) {
    smartHomeState.lightsOn = smartHomeApi.turnLightsOff();
    smartHomeState.tvOn = tvApi.turnOn();
    gamingFacade.startGaming(smartHomeState);
  }

  void stopGaming(SmartHomeState smartHomeState) {
    gamingFacade.stopGaming(smartHomeState);
    smartHomeState.tvOn = tvApi.turnOff();
    smartHomeState.lightsOn = smartHomeApi.turnLightsOn();
  }

  void startStreaming(SmartHomeState smartHomeState) {
    smartHomeState.lightsOn = smartHomeApi.turnLightsOn();
    smartHomeState.tvOn = tvApi.turnOn();
    gamingFacade.startStreaming(smartHomeState);
  }

  void stopStreaming(SmartHomeState smartHomeState) {
    gamingFacade.stopStreaming(smartHomeState);
    smartHomeState.tvOn = tvApi.turnOff();
    smartHomeState.lightsOn = smartHomeApi.turnLightsOn();
  }
}
```

### Example

_FacadeExample_ widget contains the _SmartHomeState_ which hold the current state of smart devices and _SmartHomeFacade_ to simplify the "smart actions". This widget only knows the simplified methods provided by the smart home facade but does not care about their implementation details, dependencies between classes or other facades and the amount of different APIs used to execute the single action. This allows implementing a complicated logic to handle the smart home actions just by turning the switch ON/OFF in _ModeSwitcher_ widgets. Also, the implementation details of the smart devices' handling methods in the _SmartHomeFacade_ could be changed/improved without affecting the UI code.

```
class FacadeExample extends StatefulWidget {
  const FacadeExample();

  @override
  _FacadeExampleState createState() => _FacadeExampleState();
}

class _FacadeExampleState extends State<FacadeExample> {
  final _smartHomeFacade = const SmartHomeFacade();
  final _smartHomeState = SmartHomeState();

  var _homeCinemaModeOn = false;
  var _gamingModeOn = false;
  var _streamingModeOn = false;

  bool get _isAnyModeOn =>
      _homeCinemaModeOn || _gamingModeOn || _streamingModeOn;

  void _changeHomeCinemaMode(bool activated) {
    if (activated) {
      _smartHomeFacade.startMovie(_smartHomeState, 'Movie title');
    } else {
      _smartHomeFacade.stopMovie(_smartHomeState);
    }

    setState(() => _homeCinemaModeOn = activated);
  }

  void _changeGamingMode(bool activated) {
    if (activated) {
      _smartHomeFacade.startGaming(_smartHomeState);
    } else {
      _smartHomeFacade.stopGaming(_smartHomeState);
    }

    setState(() => _gamingModeOn = activated);
  }

  void _changeStreamingMode(bool activated) {
    if (activated) {
      _smartHomeFacade.startStreaming(_smartHomeState);
    } else {
      _smartHomeFacade.stopStreaming(_smartHomeState);
    }

    setState(() => _streamingModeOn = activated);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingL,
        ),
        child: Column(
          children: <Widget>[
            ModeSwitcher(
              title: 'Home cinema mode',
              activated: _homeCinemaModeOn,
              onChanged: !_isAnyModeOn || _homeCinemaModeOn
                  ? _changeHomeCinemaMode
                  : null,
            ),
            ModeSwitcher(
              title: 'Gaming mode',
              activated: _gamingModeOn,
              onChanged:
                  !_isAnyModeOn || _gamingModeOn ? _changeGamingMode : null,
            ),
            ModeSwitcher(
              title: 'Streaming mode',
              activated: _streamingModeOn,
              onChanged: !_isAnyModeOn || _streamingModeOn
                  ? _changeStreamingMode
                  : null,
            ),
            const SizedBox(height: LayoutConstants.spaceXL * 2),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    DeviceIcon(
                      iconData: FontAwesomeIcons.tv,
                      activated: _smartHomeState.tvOn,
                    ),
                    DeviceIcon(
                      iconData: FontAwesomeIcons.film,
                      activated: _smartHomeState.netflixConnected,
                    ),
                    DeviceIcon(
                      iconData: Icons.speaker,
                      activated: _smartHomeState.audioSystemOn,
                    ),
                  ],
                ),
                const SizedBox(height: LayoutConstants.spaceXL),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    DeviceIcon(
                      iconData: FontAwesomeIcons.playstation,
                      activated: _smartHomeState.gamingConsoleOn,
                    ),
                    DeviceIcon(
                      iconData: FontAwesomeIcons.video,
                      activated: _smartHomeState.streamingCameraOn,
                    ),
                    DeviceIcon(
                      iconData: FontAwesomeIcons.lightbulb,
                      activated: _smartHomeState.lightsOn,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```
