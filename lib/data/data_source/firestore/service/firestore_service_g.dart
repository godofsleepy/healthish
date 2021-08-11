part of 'firestore_service.dart';

class _FirestoreServiceG implements FirestoreService {
  final FirebaseFirestore firestore;

  _FirestoreServiceG(this.firestore);

  @override
  Future<AppconfigModel> getAppCofig() async {
    var snapshot = await firestore.collection('app-config').doc("dev").get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return AppconfigResponse.fromMap(data);
  }
}
