class UserModel {
  final String name;
  final String email;
  final String phone;
  final String picture;
  final String city;
  final String country;
  final int age;
  final String timezone;
  final double latitude;
  final double longitude;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.picture,
    required this.city,
    required this.country,
    required this.age,
    required this.timezone,
    required this.latitude,
    required this.longitude,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final nameJson = json['name'];
    final locationJson = json['location'];
    final coordinatesJson = locationJson['coordinates'];

    return UserModel(
      name: '${nameJson['first']} ${nameJson['last']}',
      email: json['email'],
      phone: json['phone'],
      picture: json['picture']['medium'],
      city: locationJson['city'],
      country: locationJson['country'],
      age: json['dob']['age'],
      timezone: json['registered']['date'],
      latitude: double.parse(coordinatesJson['latitude']),
      longitude: double.parse(coordinatesJson['longitude']),
    );
  }
}
