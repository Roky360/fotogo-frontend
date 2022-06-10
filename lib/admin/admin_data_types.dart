class AppStatistics {
  int usersCount;
  final int albumsCount;
  final int imagesCount;

  AppStatistics(
      {required this.usersCount,
      required this.albumsCount,
      required this.imagesCount});
}

class UserData {
  final String uid;
  final String displayName;
  final String email;
  final String photoUrl;
  final UserType privilegeLevel;

  UserData(
      {required this.uid,
      required this.displayName,
      required this.email,
      required this.photoUrl,
      required this.privilegeLevel});
}

enum UserType { admin, user }
