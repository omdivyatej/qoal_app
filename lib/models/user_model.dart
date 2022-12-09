class UserModel {
  final String uid;

  UserModel({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String height;
  final String weight;
  final String age;
  final String total_calories_burnt;
  final String total_time_h;
  final String total_points;
  final String total_sessions;
  final String total_trophies;
  final String total_coins;
  final String secret_code;

  UserData(
      {required this.total_sessions,
      required this.total_points,
      required this.total_time_h,
      required this.total_calories_burnt,
      required this.height,
      required this.weight,
      required this.age,
      required this.uid,
      required this.name,
      required this.total_coins,
      required this.total_trophies,
      required this.secret_code});
}
