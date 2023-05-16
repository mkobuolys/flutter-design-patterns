import '../apis/apis.dart';
import '../smart_home_state.dart';

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
