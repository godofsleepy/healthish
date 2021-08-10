import 'package:get_it/get_it.dart';
import 'package:healthish/data/data_source/firestore/service/firestore_service.dart';

GetIt locator = GetIt.instance;

void setuplocator() {
  locator.registerSingleton(FirestoreService());
}
