class Chatuser {
  Chatuser({
    required this.id,
    required this.image,
    required this.isactive,
    required this.name,
    required this.about,
    required this.pushtoken,
    required this.createdon,
    required this.lastactive,
    required this.email,
  });
  late String image;
  late bool isactive;
  late String email;
  late String id;
  late String name;
  late String about;
  late String pushtoken;
  late String createdon;
  late String lastactive;

  Chatuser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? " ";
    id = json['id'] ?? " ";
    isactive = json['isactive'] ?? " ";
    email = json['email'] ?? " ";
    name = json['name'] ?? "";
    about = json['about'] ?? " ";
    pushtoken = json['pushtoken'] ?? " ";
    createdon = json['createdon'] ?? " ";
    lastactive = json['lastactive'] ?? " ";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['isactive'] = isactive;
    data['email'] = email;
    data['name'] = name;
    data['id'] = id;
    data['about'] = about;
    data['pushtoken'] = pushtoken;
    data['createdon'] = createdon;
    data['lastactive'] = lastactive;
    return data;
  }
}
