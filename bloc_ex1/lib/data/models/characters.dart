class Character {
  late int id;
  late String name;
  late String birthday;
  late String image;
  late List<dynamic> occupation;
  late String status;
  late String nickname;
  late List<dynamic> appearance;
  late String portrayed;
  late String category;
  late List<dynamic> betterCallSaulAppearance;
  Character.fromJson(Map<String, dynamic> json) {
    id = json['char_id'];
    name = json['name'];
    birthday = json['birthday'];
    image = json['img'];
    occupation = json['occupation'];
    status = json['status'];
    nickname = json['nickname'];
    appearance = json['appearance'];
    portrayed = json['portrayed'];
    category = json['category'];
    betterCallSaulAppearance = json['better_call_saul_appearance'];
    // map الى  json  تقوم بتحويل من
  }
}
