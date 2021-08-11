class AppconfigModel {
  ContactComplaimentModel? contactComplaiment;
  String? title;
  List<GuideModel?>? guide;

  AppconfigModel({
    this.contactComplaiment,
    this.title,
    this.guide,
  });
}

class GuideModel {
  String? image;
  String? titile;
  String? description;

  GuideModel({
    this.image,
    this.titile,
    this.description,
  });
}

class AddressModel {
  String? street;
  String? name;

  AddressModel({
    this.street,
    this.name,
  });
}

class ContactComplaimentModel {
  AddressModel? address;
  String? phone;
  String? telephone;
  String? email;

  ContactComplaimentModel({
    this.address,
    this.phone,
    this.telephone,
    this.email,
  });
}
