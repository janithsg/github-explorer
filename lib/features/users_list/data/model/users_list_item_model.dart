class UsersListItemModel {
  String login;
  int id;
  String avatarUrl;
  String type;

  UsersListItemModel({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.type,
  });

  factory UsersListItemModel.fromJson(Map<String, dynamic> json) => UsersListItemModel(
        login: json["login"],
        id: json["id"],
        avatarUrl: json["avatar_url"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "id": id,
        "avatar_url": avatarUrl,
        "type": type,
      };

  static List<UsersListItemModel> fromJsonArray(dynamic jsonArray) {
    final List<dynamic> list = jsonArray;
    return list.map((jsonObject) => UsersListItemModel.fromJson(jsonObject)).toList();
  }
}
