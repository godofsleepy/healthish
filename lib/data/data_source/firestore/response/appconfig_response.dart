import 'dart:convert';

import 'package:healthish/domain/model/appconfig_model.dart';

extension AppconfigResponse on AppconfigModel {
  Map<String, dynamic> toMap() {
    return {
      'contact-complaiment': contactComplaiment?.toJson(),
      'title': title,
      'guide': guide?.map((x) => x?.toJson()).toList(),
    };
  }

  static AppconfigModel fromMap(Map<String, dynamic> map) {
    return AppconfigModel(
      contactComplaiment:
          ContactComplaiment.fromJson(map['contact-complaiment']),
      title: map['title'],
      guide: List<Guide?>.from(map['guide']?.map((x) => Guide?.fromJson(x))),
    );
  }

  String toJson() => json.encode(toJson());

  AppconfigModel fromJson(String source) => fromMap(json.decode(source));
}
