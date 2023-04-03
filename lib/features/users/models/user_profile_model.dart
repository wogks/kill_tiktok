class UserProfileModel {
  final String email;
  final String name;
  final String uid;
  final String bio;
  final String link;
  final String birthday;

  UserProfileModel({
    required this.birthday,
    required this.email,
    required this.name,
    required this.uid,
    required this.bio,
    required this.link,
  });
//모델이 비어있을때 빈값 리턴
  UserProfileModel.empty()
      : uid = '',
        email = '',
        bio = '',
        name = '',
        link = '',
        birthday = '';

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        birthday = json['birthday'],
        email = json['email'],
        name = json['name'],
        link = json['link'],
        bio = json['bio'];

  Map<String, String> toJason() {
    return {
      'uid': uid,
      'email': email,
      'bio': bio,
      'name': name,
      'link': link,
      'birthday': birthday,
    };
  }
}
