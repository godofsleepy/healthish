import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/data/data_source/firestore/response/appconfig_response.dart';
import 'package:healthish/domain/model/appconfig_model.dart';

part 'firestore_service_g.dart';

abstract class FirestoreService {
  factory FirestoreService(FirebaseFirestore firestore) = _FirestoreServiceG;

  Future<AppconfigModel> getAppCofig();
}
