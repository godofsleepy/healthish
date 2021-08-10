import 'dart:convert';

class AppconfigModel {
  ContactComplaiment? contactComplaiment;
  String? title;
  List<Guide?>? guide;

  AppconfigModel({
    this.contactComplaiment,
    this.title,
    this.guide,
  });
}

class Guide {
  String? image;
  String? titile;
  String? description;

  Guide({
    this.image,
    this.titile,
    this.description,
  });
  Guide.fromJson(Map<String, dynamic> json) {
    image = json["image"]?.toString();
    titile = json["titile"]?.toString();
    description = json["description"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["image"] = image;
    data["titile"] = titile;
    data["description"] = description;
    return data;
  }
}

class ContactComplaimentAddress {
  String? street;
  String? name;

  ContactComplaimentAddress({
    this.street,
    this.name,
  });
  ContactComplaimentAddress.fromJson(Map<String, dynamic> json) {
    street = json["street"]?.toString();
    name = json["name"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["street"] = street;
    data["name"] = name;
    return data;
  }
}

class ContactComplaiment {
  ContactComplaimentAddress? address;
  String? phone;
  String? telephone;
  String? email;

  ContactComplaiment({
    this.address,
    this.phone,
    this.telephone,
    this.email,
  });
  ContactComplaiment.fromJson(Map<String, dynamic> json) {
    address = (json["address"] != null)
        ? ContactComplaimentAddress.fromJson(json["address"])
        : null;
    phone = json["phone"]?.toString();
    telephone = json["telephone"]?.toString();
    email = json["email"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (address != null) {
      data["address"] = address!.toJson();
    }
    data["phone"] = phone;
    data["telephone"] = telephone;
    data["email"] = email;
    return data;
  }
}
