part of 'firestore_service.dart';

class _FirestoreServiceG implements FirestoreService {
  final FirebaseFirestore firestore;

  _FirestoreServiceG(this.firestore);

  @override
  Future<AppconfigModel> getAppCofig() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection('app-config').doc("dev").get();
    Map<String, dynamic> data = snapshot.data()!;
    return AppconfigResponse.fromMap(data);
  }
}
