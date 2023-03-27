import 'package:shared_preferences/shared_preferences.dart';

class VideoPaybackConfigRepository {
//디스크에 저장되는 key 헷갈리지 않게 정의 실수 방지
  static const String _autoplay = 'autoplay';
  static const String _muted = 'muted';

  final SharedPreferences _preferences;

  VideoPaybackConfigRepository(this._preferences);

  //데이터 저장하기
  Future<void> setMuted(bool value) async {
    _preferences.setBool(_muted, value);
  }

  Future<void> setAutoplay(bool value) async {
    _preferences.setBool(_autoplay, value);
  }

  //데이터 읽기
  bool isMuted() {
    return _preferences.getBool(_muted) ?? false;
  }

  bool isAutoplay() {
    return _preferences.getBool(_autoplay) ?? false;
  }
}
