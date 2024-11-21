import 'dart:math';

class UserData {
  static final UserData _instance = UserData._internal();
  factory UserData() => _instance;

  UserData._internal();

  final List<int> heartRates = [80];
  final Random _random = Random();

  void generateHeartRate() {
    if (heartRates.length > 20) {
      heartRates.removeAt(0); // 오래된 데이터 제거
    }
    heartRates.add(80 + _random.nextInt(30)); // 60~100 범위의 랜덤 심박수 추가
  }

  List<int> getHeartRates() => List.unmodifiable(heartRates); // 데이터 보호
}