import 'dart:convert';

class AddressModel {
  String name = "";
  String phone = "";
  String address = "";
  String pincode = "";
  String type = "";
  AddressModel({
    required this.name,
    required this.phone,
    required this.address,
    required this.pincode,
    required this.type,
  });

  AddressModel copyWith({
    String? name,
    String? phone,
    String? address,
    String? pincode,
    String? type,
  }) {
    return AddressModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      pincode: pincode ?? this.pincode,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'pincode': pincode,
      'type': type,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      pincode: map['pincode'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddressModel(name: $name, phone: $phone, address: $address, pincode: $pincode, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressModel &&
        other.name == name &&
        other.phone == phone &&
        other.address == address &&
        other.pincode == pincode &&
        other.type == type;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        pincode.hashCode ^
        type.hashCode;
  }
}
