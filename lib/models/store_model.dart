class Store {
  final int? id;
  final String storeName;
  final String phone;
  final String cep;
  final double latitude;
  final double longitude;
  final String city;
  final String uf;
  final String address;

  Store({
    this.id,
    required this.storeName,
    required this.phone,
    required this.cep,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.uf,
    required this.address,
  });

  // Converte o objeto Store para um Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storeName': storeName,
      'phone': phone,
      'cep': cep,
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
      'uf': uf,
      'address': address,
    };
  }

  // Converte um Map para o objeto Store
  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      storeName: json['storeName'],
      phone: json['phone'],
      cep: json['cep'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      city: json['city'],
      uf: json['uf'],
      address: json['address'],
    );
  }
}
