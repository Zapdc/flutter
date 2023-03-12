import 'package:goan_market/consts/consts.dart';

class FirestoreServices{

  static getUser(uid){
    return firestore.collection(userCollection).where('id', isEqualTo: uid).snapshots();
  }
}