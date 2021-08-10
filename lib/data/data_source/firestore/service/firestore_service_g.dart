part of 'firestore_service.dart';

class _FirestoreServiceG implements FirestoreService {
  @override
  Future<AppconfigModel> getAppCofig() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('app-config')
        .doc("dev")
        .get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    print("map :  ${data}");
    return AppconfigResponse.fromMap(data);
  }
}
