class Store {
  final String store_name;
  final String phone;
  final String cep;
  final double latitude;
  final double longitude;
  final String city;
  final String uf;
  final String address;

  Store({
    required this.store_name,
    required this.phone,
    required this.cep,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.uf,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'store_name': store_name,
      'phone': phone,
      'cep': cep,
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
      'uf': uf,
      'address': address,
    };
  }
}
