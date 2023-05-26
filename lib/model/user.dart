class UserInfo {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String? serverAuthCode;

//<editor-fold desc="Data Methods">
  const UserInfo({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.serverAuthCode,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserInfo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          displayName == other.displayName &&
          photoUrl == other.photoUrl &&
          serverAuthCode == other.serverAuthCode);

  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      displayName.hashCode ^
      photoUrl.hashCode ^
      serverAuthCode.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' id: $id,' +
        ' email: $email,' +
        ' displayName: $displayName,' +
        ' photoUrl: $photoUrl,' +
        ' serverAuthCode: $serverAuthCode,' +
        '}';
  }

  UserInfo copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    String? serverAuthCode,
  }) {
    return UserInfo(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      serverAuthCode: serverAuthCode ?? this.serverAuthCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'displayName': this.displayName,
      'photoUrl': this.photoUrl,
      'serverAuthCode': this.serverAuthCode,
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      id: map['id'] as String,
      email: map['email'] as String,
      displayName: map['displayName'] as String,
      photoUrl: map['photoUrl'] as String,
      serverAuthCode: map['serverAuthCode'] as String,
    );
  }

//</editor-fold>
}
