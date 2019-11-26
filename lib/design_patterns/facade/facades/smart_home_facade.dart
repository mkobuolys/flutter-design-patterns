import 'package:flutter_design_patterns/design_patterns/facade/apis/audio_api.dart';
import 'package:flutter_design_patterns/design_patterns/facade/apis/netflix_api.dart';
import 'package:flutter_design_patterns/design_patterns/facade/apis/smart_home_api.dart';
import 'package:flutter_design_patterns/design_patterns/facade/apis/tv_api.dart';
import 'package:flutter_design_patterns/design_patterns/facade/facades/gaming_facade.dart';
import 'package:flutter_design_patterns/design_patterns/facade/smart_home_state.dart';

class SmartHomeFacade {
  final GamingFacade _gamingFacade = GamingFacade();
  final TvApi _tvApi = TvApi();
  final AudioApi _audioApi = AudioApi();
  final NetflixApi _netflixApi = NetflixApi();
  final SmartHomeApi _smartHomeApi = SmartHomeApi();

  void startMovie(SmartHomeState smartHomeState, String movieTitle) {
    smartHomeState.lightsOn = _smartHomeApi.turnLightsOff();
    smartHomeState.tvOn = _tvApi.turnOn();
    smartHomeState.audioSystemOn = _audioApi.turnSpeakersOn();
    smartHomeState.netflixConnected = _netflixApi.connect();
    _netflixApi.play(movieTitle);
  }

  void stopMovie(SmartHomeState smartHomeState) {
    smartHomeState.netflixConnected = _netflixApi.disconnect();
    smartHomeState.tvOn = _tvApi.turnOff();
    smartHomeState.audioSystemOn = _audioApi.turnSpeakersOff();
    smartHomeState.lightsOn = _smartHomeApi.turnLightsOn();
  }

  void startGaming(SmartHomeState smartHomeState) {
    smartHomeState.lightsOn = _smartHomeApi.turnLightsOff();
    smartHomeState.tvOn = _tvApi.turnOn();
    _gamingFacade.startGaming(smartHomeState);
  }

  void stopGaming(SmartHomeState smartHomeState) {
    _gamingFacade.stopGaming(smartHomeState);
    smartHomeState.tvOn = _tvApi.turnOff();
    smartHomeState.lightsOn = _smartHomeApi.turnLightsOn();
  }

  void startStreaming(SmartHomeState smartHomeState) {
    smartHomeState.lightsOn = _smartHomeApi.turnLightsOn();
    smartHomeState.tvOn = _tvApi.turnOn();
    _gamingFacade.startStreaming(smartHomeState);
  }

  void stopStreaming(SmartHomeState smartHomeState) {
    _gamingFacade.stopStreaming(smartHomeState);
    smartHomeState.tvOn = _tvApi.turnOff();
    smartHomeState.lightsOn = _smartHomeApi.turnLightsOn();
  }
}
