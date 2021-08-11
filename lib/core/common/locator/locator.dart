import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:healthish/data/data_source/firestore/service/firestore_service.dart';

GetIt locator = GetIt.instance;

void setuplocator() {
  locator.registerSingleton(FirebaseFirestore.instance);
  locator.registerSingleton(FirestoreService(locator.get<FirebaseFirestore>()));
}
