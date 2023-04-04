class UserProfileModel {
  final String email;
  final String name;
  final String uid;
  final String bio;
  final String link;
  final String birthday;
  final bool hasAvatar;

  UserProfileModel({
    required this.birthday,
    required this.email,
    required this.name,
    required this.uid,
    required this.bio,
    required this.link,
    required this.hasAvatar,
  });
//모델이 비어있을때 빈값 리턴
  UserProfileModel.empty()
      : uid = '',
        email = '',
        bio = '',
        name = '',
        link = '',
        birthday = '',
        hasAvatar = false;

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        birthday = json['birthday'],
        email = json['email'],
        name = json['name'],
        link = json['link'],
        hasAvatar = json['hasAvatar'],
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

  UserProfileModel copyWith({
    String? email,
    String? name,
    String? uid,
    String? bio,
    String? link,
    String? birthday,
    bool? hasAvatar,
  }) {
    return UserProfileModel(
      //this는 유저프로파일모델이 원래 가지고 있던것을 가져온다
      birthday: birthday ?? this.birthday,
      email: email ?? this.email,
      name: name ?? this.name,
      uid: uid ?? this.uid,
      bio: bio ?? this.bio,
      link: link ?? this.link,
      hasAvatar: hasAvatar ?? this.hasAvatar,
    );
  }
}
