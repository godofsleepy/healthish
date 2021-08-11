import 'package:healthish/domain/model/appconfig_model.dart';

extension AppconfigResponse on AppconfigModel {
  static AppconfigModel fromMap(Map<String, dynamic> map) {
    return AppconfigModel(
      contactComplaiment:
          ContactComplaimentResponse.fromJson(map['contact-complaiment']),
      title: map["title"],
      guide: List<GuideModel?>.from(
          map['guide']?.map((x) => GuideResponse?.fromJson(x))),
    );
  }
}

extension GuideResponse on GuideModel {
  static GuideModel fromJson(Map<String, dynamic> json) => GuideModel(
        image: json['image'] as String?,
        titile: json['titile'] as String?,
        description: json['description'] as String?,
      );
}

extension ContactComplaimentResponse on ContactComplaimentModel {
  static ContactComplaimentModel fromJson(Map<String, dynamic> json) =>
      ContactComplaimentModel(
        address: json['address'] == null
            ? null
            : AddressResponse.fromJson(json['address'] as Map<String, dynamic>),
        phone: json['phone'] as String?,
        telephone: json['telephone'] as String?,
        email: json['email'] as String?,
      );
}

extension AddressResponse on AddressModel {
  static AddressModel fromJson(Map<String, dynamic> json) => AddressModel(
        street: json['street'] as String?,
        name: json['name'] as String?,
      );
}
