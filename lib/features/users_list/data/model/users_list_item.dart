class UsersListItem {
  String login;
  int id;
  String avatarUrl;
  String type;

  UsersListItem({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.type,
  });

  factory UsersListItem.fromJson(Map<String, dynamic> json) => UsersListItem(
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

  static List<UsersListItem> fromJsonArray(dynamic jsonArray) {
    final List<dynamic> list = jsonArray;
    return list.map((jsonObject) => UsersListItem.fromJson(jsonObject)).toList();
  }
}
