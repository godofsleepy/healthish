import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthish/constants.dart';
import 'package:healthish/contract/register_contract.dart';

class RegisterPresenter implements RegisterContractPresenter {
  RegisterContractView registerContractView;
  Firestore firestore = Firestore.instance;

  RegisterPresenter(this.registerContractView);

  @override
  Future<String> getRegisterData(String name, String email, String password,
      String gender, String telephone) async {
    QuerySnapshot querySnapshot = await firestore
        .collection(Constants.userCollections)
        .where("email", isEqualTo: email)
        .getDocuments();
    if (querySnapshot.documents.length == 0 || querySnapshot.documents.isEmpty){
      DocumentReference documentReference = await firestore.collection(Constants.userCollections).add(<String, dynamic>{
        'email': email,
        'gender': gender,
        'image': 'https://firebasestorage.googleapis.com/v0/b/health-shelter.appspot.com/o/800px-Image_created_with_a_mobile_phone.png?alt=media&token=5461c81c-7aae-4dd5-b43b-c8c7a82bad44',
        'name': name,
        'password': password,
        'phonenumber': telephone,
      });
      if (documentReference.documentID != null){
        return Constants.SUCCESS_RESPONSE;
      }else{
        return Constants.FAILED_RESPONSE;
      }
    }
    return Constants.ALREADY_RESPONSE;
  }

  @override
  loadRegisterData(String name, String email, String password, String gender,
      String telephone) {
    getRegisterData(name, email, password, gender, telephone)
        .then((value) => registerContractView.setRegisterData(value))
        .catchError((error) => registerContractView.setOnErrorRegister(error));
  }
}
