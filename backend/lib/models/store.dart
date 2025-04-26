class Store {
  final String storeName;
  final String phone;
  final String cep;
  final String latitude;
  final String longitude;
  final String city;
  final String state;
  final String address;

  Store({
    required this.storeName,
    required this.phone,
    required this.cep,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.state,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'store_name': storeName,
      'phone': phone,
      'cep': cep,
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
      'state': state,
      'address': address,
    };
  }
}
