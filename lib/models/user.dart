class User {
  final String id, email, name, username, contact, avatar, orgProfile;
  final bool accountStatus;

  //final List<GameList> games;

  User(
      {this.id,
      this.email,
      this.name,
      this.username,
      this.contact,
      this.avatar,
      this.orgProfile,
      this.accountStatus});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      name: json['name'],
      username: json['user_name'],
      contact: json['contact'],
      avatar: json['avatar'],
      orgProfile: json['org_profile'],
      accountStatus: json['account_status'],
    );
  }
}

/*
class GameList {
  final Game game;
  final String level;

  GameList({this.game,this.level});

  factory GameList.fromJson(Map<String,dynamic> json){
    return GameList(
        game: json['game'],
        level: json['level']
    );
  }
}

class Game{

}*/
