class UserProfile {
  String firstName;
  String lastName;
  String age;
  String address;
  String imageBase64; // Base64 formatında şəkil

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.address,
    required this.imageBase64,
  });
}